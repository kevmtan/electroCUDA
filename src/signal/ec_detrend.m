function [n,x] = ec_detrend(n,x,w,o)
%% Robust detrending - wrapper for CPU processing
%
% INPUTS:
%    see 'input validation' section below
% OUTPUTS:
%    y = detrended data
%    w = updated weights
%    r = basis matrix used
%
% This code was adapted from NoiseTools (audition.ens.fr/adc/NoiseTools)
%
% Modified by: Kevin Tan, 2022 (kevmtan.github.io)
%    - Added GPU support
%    - Replaced bsxfun with implicit expansion operators (much faster)
%    - Miscellaneous compute & readability enhancements

%% Input validation
arguments
    n struct                        % Metadata
    x {mustBeFloat}                 % Raw data: x(frames,chans)|x(frames,chans,freqs)
    w logical = false(size(x))      % Input weights: w(frames,chans)|w(frames,chans,freqs)
    o.missing {istext} = "" % Interpolation method for missing
    o.order (1,:){isfloat} = 10   % Polynomial order (can be vector of polynomials)
    o.thr (1,:){isfloat} = 3      % Outlier threshold (same size as order)
    o.itr (1,:){isfloat} = 3      % Number of iterations (same size as order)
    o.win (1,:){isfloat} = 0      % Window width (secs, 0=all) (same size as order)
    o.basis {mustBeMember(o.basis,{'polynomials','sinusoids'})}...
        = "polynomials"        % Basis function
    o.gpu (1,1){isfloat} = 0 % GPU: 0=disable, 1=Matlab, 2=CUDA (must compile: ec_compileBins)
    o.single logical = []    % Run in single-precision (true/false)
    o.tic uint64 = tic       % Output from 'tic'
    o.pcaThr = 1e-7; 
    %arg.sfx {istext} = ""
    %arg.sfxOg {istext} = ''
end

%% Prep
w = logical(full(w));
if isempty(w)||isscalar(w); w=false(size(x)); end
if ~isequal(size(x),size(w)); error("ec_detrend: data must be same size as weights"); end
if length(x)<width(x); x=x'; w=w'; warning("ec_detrend: converted to column-major arrays"); end
if all(w,'all'); w=false(size(w)); warning("ec_detrend: all outliers, resetting..."); end
if o.gpu && isempty(o.single); o.single=true; end
%if arg.gpu; try reset(gpuDevice()); catch;end;end
if ~isfield(n,'xBad'); n.xBad=table; end
runs = n.runs;
nRuns = numel(runs);
reps = nnz(o.order);
%pcaThr = o.pcaThr;
%basis = string(arg.basis); %#ok<NASGU> 
dims = size(x);
nChs = dims(2);

% Options per rep
if numel(o.thr)~=reps; thr=repmat(o.thr,1,reps); else; thr=o.thr; end
if numel(o.itr)~=reps; itr=repmat(o.itr,1,reps); else; itr=o.itr; end
if numel(o.win)~=reps; win=repmat(o.win,1,reps); else; win=o.win; end
if any(win,"all"); win=floor(win.*n.fs); end
ord = o.order;

% Convert to single if requested
if o.single
    ord=single(ord); thr=single(thr); itr=single(itr); win=single(win);
    x = single(x); 
end

% Concactenate higher dimensions (3D+)
if numel(dims)>2
    x = x(:,:);
    w = w(:,:);
end


%% Interpolate missing
if isany(o.missing)
    for ir = 1:nRuns
        rIdx = n.runIdx(ir,1):n.runIdx(ir,2); % Run indices
        if any(ismissing(x(rIdx,:,:)),"all")
            x(rIdx,:,:) = fillmissing(x(rIdx,:,:),o.missing,1,"EndValues","nearest");
            disp("Interpolated missing: "+runs(ir)+" time="+toc(o.tic));
        end
    end
end

%% Detrend
rIdx = n.runIdxOg(:,2); % run end indices

if o.gpu % && length(dims)<=2 && ~any(win,"all") % TODO: 3d detrend
    if o.gpu==1     % Matlab gpuArray
        [x,w,ols] = detrendGPU_lfn(x,w,rIdx,ord,thr,itr,win);
    elseif o.gpu==2 % CUDA binary
        [x,w,ols] = detrendCUDA_lfn(x,w,rIdx,ord,thr,itr,o);
    end
else
    % CPU parallel threadpool
    ols = nan(nChs,reps,"like",x);
    try parpool("Threads"); catch;end
    parfor ch = 1:nChs
        [x(:,ch),w(:,ch),ols(ch,:)] =...
            detrendCPU_lfn(x(:,ch),w(:,ch),rIdx,ord,thr,itr,win);
    end
end

%% Finalize

% Reshape to original size
if numel(dims)>2
    x = reshape(x,dims);
    w = reshape(w,dims);
end

% Save
n.xBad.detrend = sparse(logical(w));

% Percent outliers
ols = sum(ols,1,"omitnan")/numel(w);
for ii = 1:reps
    disp("Robust detrended: order="+ord(ii)+" ol="+ols(ii)); % Display percent outliers
end
toc(o.tic);





%%%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Detrend with CPU %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,w,ols] = detrendCPU_lfn(x,w,ri,ord,thr,itr,win)
% 'x' and 'w' are vectors
nRuns = height(ri);
reps = nnz(ord);
ols = nan(nRuns,reps,"like",x);

% Separate data per run
x = mat2cell(x,ri);
w = mat2cell(w,ri);

% Detrend within-run to avoid edge artifacts
for i = 1:nRuns
    nFrames = height(x{i});

    % Loop across unique polynomials
    for ii = 1:reps
        iOrd=ord(ii); iThr=thr(ii); iItr=itr(ii); iWin=win(ii);
        if ~iWin
            % Standard detrending (trend fit to entire data)
            regs = regsFromBasis_lfn(nFrames,iOrd);
            [x{i},w{i}] = detrend_lfn(x{i},w{i},regs,iThr,iItr);
        else
            % Overlapping window detrending
            [x{i},w{i}] = detrendWin_lfn(x{i},w{i},iOrd,iThr,iItr,iWin);
        end
        ols(i,ii) = nnz(w{i});
    end
end

% Re-concactenate runs
x = vertcat(x{:});
w = vertcat(w{:});
ols = sum(ols,1,"omitnan");


%% Detrend with Matlab gpuArray %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,w,ols] = detrendGPU_lfn(x,w,ri,ord,thr,itr,win)
x = mat2cell(x,ri);
w = mat2cell(w,ri);

% Copy to GPU
thr=gpuArray(thr); itr=gpuArray(itr); win=gpuArray(win); ord=gpuArray(ord);
nRuns=gpuArray(numel(x)); reps=gpuArray(numel(ord)); %pcaThr=gpuArray(pcaThr);
ols = nan(nRuns,reps,"like",ord); 

% Detrend within-run to avoid edge artifacts
for i = 1:nRuns
    nFrames = cast(height(x{i}),"like",ord);

    % Separate chans & move to GPU
    x{i} = cellfun(@gpuArray,num2cell(x{i},1),"UniformOutput",false);
    w{i} = cellfun(@gpuArray,num2cell(w{i},1),"UniformOutput",false);

    % Detrend each channel
    [x{i},w{i}] = arrayfun(@(x,w) chGPU_lfn(x{:},w{:},ols(i,:),ord,thr,itr,...
        win,reps,nFrames),x{i},w{i},"UniformOutput",false);

    % Combine chans & move to CPU
    x{i} = gather(horzcat(x{i}{:}));
    w{i} = gather(horzcat(w{i}{:}));
end
x = vertcat(x{:});
w = vertcat(w{:});
ols = gather(ols);


%% GPU detrend - channel helper function
function [x,w] = chGPU_lfn(x,w,ols,ord,thr,itr,win,reps,nFrames)

% Loop across unique polynomials
for ii = 1:reps
    iOrd=ord(ii); iThr=thr(ii); iItr=itr(ii); iWin=win(ii);
    if ~iWin
        % Standard detrending (trend fit to entire data)
        regs = regsFromBasis_lfn(nFrames,iOrd);
        [x,w] = detrend_lfn(x,w,regs,iThr,iItr);
    else
        % Overlapping window detrending
        [x,w] = detrendWin_lfn(x,w,iOrd,iThr,iItr,iWin);
    end
    ols(ii) = sum(w);
end


%% Standard detrending (trend fit to entire data) %%%%%%%%%%%%%%%%%%%%%%%%%
function [x,w] = detrend_lfn(x,w,r,iThr,iItr)
% The data are fit to the basis using weighted least squares. The weight is
% updated by setting samples for which the residual is greater than 'thresh'
% times its std to zero, and the fit is repeated at most 'niter'-1 times.
%
% The choice of order (and basis) determines what complexity of the trend
% that can be removed.  It may be useful to first detrend with a low order
% to avoid fitting outliers, and then increase the order.
%
% The tricky bit is to ensure that weighted means are removed before
% calculating the regression (see nt_regw).

% Detrend per polynomial order
for ii = 1:iItr
    % Weighted regression
    z = regw_lfn(x,w,r); % Discard dimensions of r with eigenvalue lower than pcaThr

    % Find outliers from residuals
    d = (x-z).* ~w;
    w(isoutlier(d,"median",1,"ThresholdFactor",iThr)) = true; % update weights
end

% Remove trends
x = x-z;


%% Detrend across overlapping time windows %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y,w] = detrendWin_lfn(x,w,iOrd,iThr,iItr,iWin)
dims = cast(size(x),"like",x);
y = zeros(dims,'like',x);

% 1) divide into windows, 2) detrend each, 3) stitch together, 4) estimate w
for iIter = 1:iItr
    z = zeros(dims,'like',x);
    a = zeros(dims(1),1,'like',x);
    offset = zeros(1,'like',x);
    while true
        start = offset+1;
        stop = min(dims(1),offset+iWin);

        % if not enough valid samples grow window:
        counter = 5;
        while any(sum(min(~w(start:stop),2))) < iWin
            if counter <= 0 ; break; end
            start = max(1,start-iWin/2);
            stop = min(dims(1),stop+iWin/2);
            counter = counter-1;
        end
        if rem(stop-start+1,2)==1; stop = stop-1; end
        wsize2 = stop-start+1;

        % detrend this window
        nFrames = cast(numel(start:stop),"like",x);
        regs = regsFromBasis_lfn(nFrames,iOrd);
        yy = detrend_lfn(x(start:stop,:),w(start:stop,:),regs,iThr,1);

        % triangular weighting
        if start==1
            b = [ones(1,wsize2/2,'like',x)*wsize2/2, wsize2/2:-1:1]';
        elseif stop==dims(1)
            b = [1:wsize2/2, ones(1,wsize2/2,'like',x)*wsize2/2]';
        else
            b = [1:wsize2/2, wsize2/2:-1:1]';
        end

        % overlap-add to output
        y(start:stop,:) = y(start:stop,:) + (yy.*b); %bsxfun(@times,yy,b);
        z(start:stop,:) = z(start:stop,:) + (x(start:stop,:)-yy).*b; %bsxfun(@times,x(start:stop,:)-yy,b);
        a(start:stop,1) = a(start:stop)+b;
        offset = offset+iWin/2;
        if offset > dims(1)-iWin/2; break; end
    end

    if stop<dims(1) % last sample can be missed
        y(end,:) = y(end-1,:);
        a(end,:) = a(end-1,:);
    end
    y = y.*(1./a); %bsxfun(@times,y,1./a);
    y(isnan(y)) = 0;
    z = z.*(1./a); %bsxfun(@times,trend,1./a);
    z(isnan(z)) = 0;

    % Find outliers from residuals
    d = (x-z).* ~w;
    w(isoutlier(d,"median",1,"ThresholdFactor",iThr)) = true; % update weights
end


%% Get regressors from basis function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function regs = regsFromBasis_lfn(nFrames,iOrd)
regs = zeros(nFrames,iOrd,'like',iOrd);
if isgpuarray(iOrd)
    lin = gpuArray.linspace(-1,1,nFrames);
else
    lin = linspace(-1,1,nFrames);
end
for k = 1:iOrd
    regs(:,k) = lin.^k;
end
% regs = [ones(nFrames,1) regs];


%% Weighted Regression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = regw_lfn(x,w,r) % pcaThr
%  b: regression matrix (apply to r to approximate x)
%  z: fitted trend from regession (r*b)

% Demean data & regressors excluding channel-specific outliers
[x,mn] = demean_lfn(x,w); % EEG data
r = demean_lfn(r,w); % regressors

% QR decomposition
[Q,R] = qr(r.* ~w,"econ","vector");

% Regression matrix
b = R\(Q\x); % r*(R\Q'*x);

% Fit weighted regression
z = r*b;
z = z + mn; % add back mean


%% Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,mn] = demean_lfn(x,w)
mn = sum(x(~w),1,"omitnan") ./ (sum(~w,1,"omitnan")+eps);
x = x - mn;


%% Detrend with GPU CUDA binary %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,w,ols] = detrendCUDA_lfn(x,w,rIdx,ord,thr,itr,arg)
nRuns = height(rIdx);
reps = numel(ord);
ols = nan(nRuns,reps);

% Detrend within-run to avoid edge artifacts
for ir = 1:nRuns
    xr = x(rIdx{ir},:);
    wr = w(rIdx{ir},:);

    % Run detrend (for each polynomial order)
    if arg.single
        [xr,wr,ols(ir,:)] = ecc_detr_mex32(xr,wr,ord,thr,itr); % single-precision
    else
        [xr,wr,ols(ir,:)] = ecc_detr_mex64(xr,wr,ord,thr,itr); % double-precision
    end

    % Copy back run data
    x(rIdx{ir},:) = xr;
    w(rIdx{ir},:) = wr;
end


%% Depreciated
% if basis=="polynomials"
%     regs = zeros(nFrames,iOrd,'like',iOrd);
%     lin = linspace(-1,1,nFrames);
%     for k = iOrd
%         regs(:,k) = lin.^k;
%     end
% elseif basis=="sinusoids"
%     regs = zeros(nFrames,iOrd*2,'like',iOrd);
%     lin = linspace(-1,1,nFrames);
%     for k = 1:iOrd
%         regs(:,2*k-1) = sin(2*pi*k*lin/2);
%         regs(:,2*k) = cos(2*pi*k*lin/2);
%     end
% else
%     error("ec_detrend: basis must be 'polynomials' or 'sinusoids'");
% end
%
% % Eigenvector decomposition
% x = demean_lfn(x,w).* w;
% r = demean_lfn(r,w); % remove channel-specific-weighted mean from regressor
% rr = r.*w;
% [V,D] = eig(rr'*rr);
% D = diag(D); %V=real(V); D=real(diag(D));
% D = D/max(D);
% V = V(:,D>pcaThr); % discard weak dims
% rr = rr*V;
% b = ((x'*rr)/(rr'*rr))';
% z = r*(V*b) + mn;
%
%
% %% Weighted regression - all frames (CPU)  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,w] = regw_CPU(x,w,r,iThr,iItr)
% 
% % Recursively-weighted regression
% for ii = 1:iItr
%     % Solve least squares problem p = W\x1
%     [z,rrank] = matlab.internal.math.leastSquaresFit(r.*w,x);
%     z = r*z;
% 
%     % Find outliers from residuals
%     d = abs((x-z)).*w;
%     [~,~,U] = isoutlier(d,"median",1,"ThresholdFactor",iThr);
%     w(d>U) = 0;
% end
% 
% % Detrend input data
% x = x-z; % Remove trends
% 
% % Check if rank-deficient
% if rrank < size(r,2)
%     warning(message('MATLAB:detrend:PolyNotUnique'));
% end
%
%
% %% Weighted regression - all frames (GPU)  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,w] = regw_GPU(x,w,r,iThr,iItr)
% 
% % Recursively-weighted regression
% for ii = 1:iItr
%     % QR decomposition
%     [Q,R] = qr(r.*w,"econ","vector");
% 
%     % Get fitted polynomial coefficients
%     z = r*(R\(Q\x)); %r*(R\Q'*x);
% 
%     % Find outliers from residuals
%     d = abs((x-z)).* w;
%     [~,~,U] = isoutlier(d,"median",1,"ThresholdFactor",iThr);
%     w(d>U) = 0;
% end
% 
% % Detrend input data
% x = x-z; % Remove trends
