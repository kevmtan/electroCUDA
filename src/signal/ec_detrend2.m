function [n,x,w] = ec_detrend2(n,x,w,a)
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
    a.outlier string = "median"     % Outlier method
    a.interp string = "akima" % Interpolation method for missing
    a.poly (1,:){isfloat} = 10   % Polynomial order (can be vector of polynomials)
    a.thr (1,:){isfloat} = 3      % Outlier threshold (same size as order)
    a.itr (1,:){isfloat} = 3      % Number of iterations (same size as order)
    a.win (1,:){isfloat} = 0      % Window width (secs, 0=all) (same size as order)
    a.gpu (1,1){isfloat} = 0 % GPU: 0=disable, 1=Matlab, 2=CUDA (must compile: ec_compileBins)
    a.single logical = []    % Run in single-precision (true/false)
    a.tic uint64 = tic       % Output from 'tic'
    a.pcaThr = 1e-7;
    %a.sfx {istext} = ""
    %a.sfxOg {istext} = ''
end

%% Prep
dims = size(x);
if issparse(w); w=full(w); end
if isempty(w)||isscalar(w); w=false(dims); end
if all(w,'all'); w=false(dims); warning("ec_detrend: all outliers, resetting..."); end
if length(x)<width(x); x=x'; w=w'; warning("ec_detrend: converted to column-major arrays"); end
if ~isequal(dims,size(w)); error("ec_detrend: data must be same size as weights"); end
if ~isfield(n,'xBad'); n.xBad=table; end
if a.gpu && isempty(a.single); a.single=true; end
if a.gpu; reset(gpuDevice()); end
if ~a.single; x=double(x); end
doGPU = a.gpu;
runs = n.runs;
nRuns = numel(runs);
ord = a.poly;
nPoly = nnz(ord);
%pcaThr = a.pcaThr;
olInterp = a.interp;
olMethod = a.outlier;
olPct = nan(nRuns,nPoly); % Preallocate percent outlier array
loRnk = false(nRuns,nPoly);

% Options per rep
if numel(a.thr)~=nPoly; thr=repmat(a.thr,1,nPoly); else; thr=a.thr; end
if numel(a.itr)~=nPoly; itr=repmat(a.itr,1,nPoly); else; itr=a.itr; end
%if numel(a.win)~=nPoly; win=repmat(a.win,1,nPoly); else; win=a.win; end
%if any(win,"all"); win=floor(win.*n.fs); end
itr(itr<1) = 1;

% Convert to single if requested
if a.single 
    x = single(x); olPct=single(olPct); ord=single(ord); thr=single(thr);
    itr=single(itr); %win=single(win); pcaThr=single(pcaThr);
else
    x = double(x);
end

% Segregate data by run
x = mat2cell(x,n.runIdxOg(:,2));
w = mat2cell(w,n.runIdxOg(:,2));

%% Interpolate missing (CPU only)
for ir = 1:nRuns
    if any(ismissing(x{ir}),"all")
        x{ir} = fillmissing(x{ir},olInterp,1,"EndValues","nearest");
        disp(olInterp+" interpolation: "+runs(ir)+" time="+toc(tt));
    end
end

%% Move data to GPU
if doGPU 
    olPct=gpuArray(olPct); ord=gpuArray(ord); thr=gpuArray(thr); itr=gpuArray(itr);
    %win=gpuArray(win); pcaThr=gpuArray(pcaThr);
end

%% Detrend (within-run to avoid edge artifacts)
for ir = 1:nRuns
    [x{ir},w{ir},olPct(ir,:),loRnk(ir,:)] = detrendRun_lfn(x{ir},w{ir},...
        olPct(ir,:),loRnk(ir,:),ord,thr,itr,olMethod,doGPU);
end
if doGPU; olPct=gather(olPct); loRnk=gather(loRnk); ord=gather(ord); end
x = vertcat(x{:});
w = vertcat(w{:});
olPct = sum(olPct,1,"omitnan")/numel(w);
loRnk = any(loRnk,1);
n.xBad.detrend = sparse(w); % save to "n" struct

%% Finalize
for ip = 1:nPoly
    disp("Robust detrended: order="+ord(ip)+" ol="+olPct(ip)+" rankDeficient="+loRnk(ip)); % Display percent outliers
end
toc(a.tic);



%%%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Robust detrend within-run
function [xr,wr,olPctR,loRnkR] = detrendRun_lfn(xr,wr,olPctR,loRnkR,ord,thr,itr,...
    olMethod,doGPU)

% Prep
nPoly=nnz(ord); % olPctR=squeeze(olPctR); loRnkR=squeeze(loRnkR);
if doGPU; xr=gpuArray(xr); wr=gpuArray(wr); nPoly=gpuArray(nPoly); end

% Robust detrend
for ip = 1:nPoly
    %% Detect outliers from residuals of fitted trend (recursive)
    tic;
    for ii = 1:itr(ip)
        xp = xr; % copy input data
        xp(wr) = nan; % replace outliers with nan
        xp = ec_detrendGPU(xp,ord(ip),"omitnan"); % get robust fitted trend
        wr = wr | isoutlier(xr-xp,olMethod,1,"ThresholdFactor",thr(ip)); % find residual outliers
        disp("itr="+ii+" time="+toc);
    end

    % Remove robust fitted trend from input data
    xp = xr; % original data
    xp(wr) = nan; % replace outliers with nan
    [xp,loRnkR(ip)] = ec_detrendGPU(xp,ord(ip),"omitnan"); % robust best-fit trend
    xr = xr-xp; % remove trend from input data
    disp("remove trend: time="+toc);

    % Get number of outliers
    olPctR(ip) = sum(wr,"all"); toc;
end

if doGPU; xr=gather(xr); wr=gather(wr); end


%% TESTING
% function test_lfn 
% t = (-10:.001:10)';
% p = [1 2 1 0];
% x = polyval(p,t);
% x(5000:6000) = x(5000:6000) + 500;
% y = detrend(x,3);
% r = x - y;
% xx = x - r + 300;
% figure;plot([t t t t],[x y r xx])
% 
% 
% %%
% x1 = x;
% x1(5000:6000) = nan;
% y1 = detrend(x1,3,"omitnan");
% r1 = x - y1;
% %r2 = fillmissing(r1,"makima");
% xx1 = x - r1 + 300;
% figure;plot([t t t t],[x y1 r1 xx1])