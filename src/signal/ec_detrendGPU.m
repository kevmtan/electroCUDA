function [xx,loRnk,p,W,y] = ec_detrendGPU(x,varargin)
%% ec_detrendGPU - polynomial detrend on GPU
%
%   Modified native Matlab function 'parallel.internal.flowthrough.detrend'
%   with additional outputs:
%       xx = fitted trend
%       loRnk = polynomial is rank-deficient
%       p = regressor polynomial coefficients
%       W = regressor scaling weights
%
%    Modified by: Kevin Tan, 2022 (github.com/kevmtan/electroCUDA)
%     
%
% ORIGINAL COMMENTS:
%
% ; %#ok undocumented
%
% % Implementation copied from toolbox/matlab/datafun/detrend.m with minor edits.
% % Copyright 1984-2022 The MathWorks, Inc.
%
% % MOD1: Call underlyingType to get the underlyingType if available.
% % MOD2: Force the result to be a gpuArray.
% % MOD3: Ensure that the argument of condest is on the host, as condest does
% % not accept gpuArray input.
% % MOD4: Does not include tabular code in "detrendTable".
%
%DETREND Remove a polynomial trend.
%   Y = DETREND(X) removes the best straight-line fit linear trend from the
%   data in vector X and returns the residual in vector Y.  If X is a
%   matrix, DETREND removes the trend from each column of the matrix.
%
%   Y = DETREND(X,N) removes a polynomial trend with degree N. N = 1 by
%   default. Setting N = 0 is equivalent to using the 'constant' option and
%   setting N = 1 is equivalent to using the 'linear' option.
%
%   Y = DETREND(X,N,BP) removes a continuous, piecewise polynomial trend
%   according to the break points specified in BP. BP can be a vector of
%   sample point values or a logical vector of length equal to the number
%   of sample points, where true indicates the position of a break point.
%
%   Y = DETREND(___,NANFLAG) specifies how NaN values are treated:
%
%      "includemissing" / "includenan" -
%                     (default) NaNs are included when calculating the
%                     polynomial trend. If NaNs are present, then the
%                     trend and the corresponding output will be vectors
%                     of NaNs.
%      "omitmissing" / "omitnan"       -
%                     NaN values are omitted when calculating the trend.
%                     NaN values in the input produce corresponding NaN
%                     values in the output.
%
%   Y = DETREND(___,'Continuous',TF) specifies whether the piecewise
%   polynomial trend is required to be continuous. TF must be one of the
%   following:
%
%      true     - (default) the fitted trend is continuous everywhere
%      false    - the fitted trend is not required to be continuous
%
%   Y = DETREND(___,'SamplePoints',S) also specifies the sample points S
%   associated with the data in X. S must be a floating-point, duration or
%   datetime vector. S must be sorted and contain unique points. You can
%   use S to specify time stamps for the data. By default, DETREND assumes
%   the data is sampled uniformly at points S = [1 2 3 ... ].
%
%   Examples:
%
%      % Remove a continuous, piecewise linear trend
%      sig = [0 1 -2 1 0 1 -2 1 0];      % signal with no linear trend
%      trend = [0 1 2 3 4 3 2 1 0];      % two-segment linear trend
%      x = sig+trend;                    % signal with added trend
%      y = detrend(x,1,5)                % break point at 5th element
%
%      % Remove a nonlinear trend
%      sig = repmat(sig,1,2);
%      trend = ((1:18)/18).^3;
%      x = sig+trend;
%      y = detrend(x,3);
%      plot(sig)
%      hold on
%      plot(y)
%
%   See also MEAN, ISCHANGE, POLYFIT, POLYVAL
%
%   Copyright 1984-2022 The MathWorks, Inc.

%% Main

% Parse inputs
[x,polyDeg,bp,samples,~,sizeX,N,~,isNDx,omitnan,~,~,~,~]...
    = parseInputs(x,varargin{:});

% Move inputs to GPU if 'x' is gpuArray
if isgpuarray(x)
    bp=gpuArray(bp); samples=gpuArray(samples); omitnan=gpuArray(omitnan); 
    sizeX=gpuArray(sizeX); isNDx=gpuArray(isNDx); N=gpuArray(N); 
    % continuity=gpuArray(continuity); permuteRow=gpuArray(permuteRow); isrowx=gpuArray(isrowx); 
end

% Build regressor for all samples (including NaNs)
bp = trimBp(bp,samples);
W = prepareRegressors(bp,samples,polyDeg,sizeX(1));
x = num2cell(x,1);
p = cellfun(@(x) detrendCol(x{:},W,omitnan,polyDeg,bp,samples),x);

% Run detrend
[p,W,loRnk] = detrendArray(x,omitnan,polyDeg,bp,samples,sizeX,N,isNDx); %MOD4

% Get fitted trend (interpolating any nans)
xx = W*p;

% Remove fitted trend from input data
if nargin>4
    y = x - xx;
end

% if continuity
%     xx = W*p;
% else
%     xx = p(:,1);
%     p = p(:,2);
% end
% if notUniquePoly
%    warning(message('MATLAB:detrend:PolyNotUnique'));
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Detrend an array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,W,loRnk] = detrendColumn(x,omitnan,polyDeg,bp,samples,sizeX)
% Preallocate
dims = cast(size(x),"like",x);
p = nan(polyDeg+1,dims(2:end),"like",x); % preallocate polynomial array

% Build regressor for all samples (including NaNs)
bp = trimBp(bp,samples);
W = prepareRegressors(bp,samples,polyDeg,sizeX(1));
x = num2cell(x,1);
p = cellfun(@(x) detrendCol(x{:},W,omitnan,polyDeg,bp,samples),x);


function [p,W,loRnk] = detrendCol(x,W,omitnan,polyDeg,bp,samples)
if omitnan 
    nanMask = isnan(x);
    if any(nanMask,"all")
        % Regressors without nans
        bpi = trimBp(bp,samples(~nanMask));
        Wi = prepareRegressors(bpi,samples(~nanMask),polyDeg,nnz(~nanMask));
        % Detrend computation
        [p,loRnk] = detrendGPU(x(~nanMask),Wi);
    else
        [p,loRnk] = detrendGPU(x,W);
    end
else
    [p,loRnk] = detrendGPU(x,W);
end


%% Detrend an array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,W,loRnk] = detrendArray(x,omitnan,polyDeg,bp,samples,sizeX,N,isNDx)

% Preallocate
dims = cast(size(x),"like",x);
p = nan(polyDeg+1,dims(2:end),"like",x); % preallocate polynomial array

% Build regressor for all samples (including NaNs)
bp = trimBp(bp,samples);
W = prepareRegressors(bp,samples,polyDeg,N);

% Perform detrend
if omitnan 
    % exclude NaNs --------------------------------------------------------
    nanMask = isnan(x);
    nanColumn = any(nanMask,1);

    % Columns without NaNs
    if any(~nanColumn) 
        [p(:,~nanColumn),loRnk] = detrendInternal(x(:,~nanColumn),W);
    end

    % Columns with NaNs
    for ii = cast(find(nanColumn),"like",x)
        % Build regressors without NaN samples
        bpi = trimBp(bp,samples(~nanMask(:,ii)));
        Wi = prepareRegressors(bpi,samples(~nanMask(:,ii)),polyDeg,nnz(~nanMask(:,ii)));

        % Detrend column excluding nans
        [p(:,ii),loRnk] = detrendInternal(x(~nanMask(:,ii),ii),Wi);
    end
else 
    % include NaNs --------------------------------------------------------
    [p,loRnk] = detrendInternal(x,W);
end

% Finalize
if isNDx
    p = reshape(p,polyDeg+1,sizeX(2:end));
end


%% Detrend computation (GPU) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,loRnk] = detrendGPU(x,W)
loRnk = false;

[Q,R] = qr(W,"econ","vector"); % qr(W,0);

% Get fitted polynomial coefficients
p = (R\Q'*x);

% Check if rank-deficient
if size(R,2)>size(R,1) || cond(R,1)>cast(1e+10,"like",R) %MOD3
    loRnk = true; % condest(cast(R,"like",1))
end



%% Detrend computation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,loRnk] = detrendInternal(x,W)
loRnk = false;

if isgpuarray(x)
    [Q,R] = qr(W,"econ","vector"); % qr(W,0);

    % Get fitted polynomial coefficients
    p = (R\Q'*x);

    % Check if rank-deficient
    if size(R,2)>size(R,1) || cond(R,1)>cast(1e+10,"like",R) %MOD3
        loRnk = true; % condest(cast(R,"like",1))
    end
else
    % Solve least squares problem p = W\x1
    [p, rankW] = matlab.internal.math.leastSquaresFit(W,x);

    % Check if rank-deficient
    if rankW < size(W,2)
        loRnk = true;
    end
end

% Remove best-fit trend
% y = x - W*p; % y = x-W*(R\Q'*x);
% if continuity %% Continuous detrend
% if polyDeg == 0
%     % Continuous demean (mean of first segment) -----------------------
%     [~,begSeg] = min(abs(samples-bp(1)));
%     if lbp == 1
%         endSeg = numel(samples);
%     else
%         [~,endSeg] = min(abs(samples - bp(2)));
%     end
%     p = mean(x(begSeg:endSeg,:),1);
%     p = [p,polyDeg([]),bp([])]; %MOD2
%     % y = x - p;
% else
%    % Continuous piecewise polynomial detrend -------------------------
% end
% Remove best-fit trend
% y = x - W*p; % y = x-W*(R\Q'*x);
% else
%     %% Discontinuous detrend (NOT FULLY SUPPORTED)
%     y = zeros(size(x),"like",x);
%     y = [y,polyDeg([]),bp([])]; %MOD2
%     segments = sum(samples >= bp',2);
%     p = cell(lbp,2);
%     
%     for k = 1:lbp
%         segIdx = segments==k;
% 
%         if polyDeg == 0 || nnz(segIdx) == 1
%             % Remove mean from each segment
%             y(segIdx,:) = x(segIdx,:) - mean(x(segIdx,:),1);
%         else
%             % Normalize before fitting polynomial
%             a = samples(segIdx);
%             a = (a - mean(a))/std(a);
% 
%             % Construct the Vandermonde matrix
%             V = [a.^(polyDeg:-1:1), ones(nnz(segIdx),1)];
% 
%             % Solve least squares problem to get polynomial coefficients
%             [Q,R] = qr(V,0);
%             tr = R\(Q'*x(segIdx,:));
% 
%             if size(R,2) > size(R,1) || condest(R) > 1e+10
%                 notUniquePoly = true;
%             end
% 
%             % Remove best fit
%             y(segIdx,:) = x(segIdx,:) - V*tr;
% 
%             % Save regressors
%             W(segIdx,:) = V;
%             p{k,1} = segIdx;
%             p{k,2} = tr;
%         end
%     end
%end



%% Prepare regressors %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function W = prepareRegressors(bp,samples,polyDeg,N)

% Normalize to avoid numerical issues
if isempty(samples)
    scaleS = samples;
else
    scaleS = samples(end);
    if ~scaleS
        samples = samples./scaleS;
    end
end

% Build regressor
b = samples - (bp./scaleS)';
b = max(b,0);
W = b(:).^(polyDeg:-1:1);
W = [reshape(W,N,[]), ones(N,1)];
W = cast(W,"like",polyDeg); %MOD1



%% parseInputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,polyDeg,bp,samples,continuity,sizeX,N,isrowx,isNDx,omitNan,...
    xIsTabular,dataVars,replace,permuteRow] = parseInputs(x, varargin)

xIsTabular = isa(x,'tabular');
if ~isfloat(x) && ~xIsTabular
    error(message('MATLAB:detrend:InvalidFirstInput'));
end
permuteRow = true; %Convert row vector to column vector if it's not the content of a table variable
[x,sizeX,N,isrowx,isNDx] = reshapeInput(x,permuteRow);

% Set default values
bp = '';
continuity = true;
omitNan = false;
dataVars = 1:width(x);
replace = true;
polyDeg = 1;
if isa(x, 'timetable')
    samples = matlab.internal.math.checkSamplePoints(x.Properties.RowTimes,x,false,true,1);
else
    samples = [];
end

if nargin > 1
    % varargin default
    polyDeg = varargin{1};
    indStart = 2;

    % parse degree n
    if ~isscalar(polyDeg) && ~ischar(polyDeg)
        error(message('MATLAB:detrend:InvalidTrendInputType'));
    elseif islogical(polyDeg)
        polyDeg = double(polyDeg);
    elseif ischar(polyDeg) || isstring(polyDeg)
        if strncmpi(polyDeg,'constant',max(4,strlength(polyDeg)))
            polyDeg = 0;
        elseif strncmpi(polyDeg,'linear',max(1,strlength(polyDeg)))
            polyDeg = 1;
        else
            % Assume NV pair
            polyDeg = 1;
            indStart = 1;
        end
    elseif ~isnumeric(polyDeg) || ~isreal(polyDeg) || polyDeg < 0 || mod(polyDeg,1) ~= 0
        error(message('MATLAB:detrend:InvalidTrendInputType'));
    end

    % Parse break points bp
    if nargin > 2 && ~(ischar(varargin{indStart}) || isstring(varargin{indStart}))
        bp = varargin{indStart};
        if isempty(bp) && isnumeric(bp)
            bp = ''; %Empty numeric breakpoints are stored as characters until being validated
        end
        indStart = indStart+1;
    end

    if indStart<nargin && (ischar(varargin{indStart}) || isstring(varargin{indStart}))
        if any(matlab.internal.math.checkInputName(varargin{indStart},{'omitnan','omitmissing'},1))
            omitNan = true;
            indStart = indStart+1;
        elseif any(matlab.internal.math.checkInputName(varargin{indStart},{'includenan','includemissing'},1))
            indStart = indStart+1;
        end
    end

    % Parse name-value pairs
    [continuity,samples,dataVars,replace] = parseNV(indStart,nargin,continuity,samples,x,xIsTabular,dataVars,replace,varargin{:});
end

if xIsTabular
    for i = 1:numel(dataVars)
        %isfloat(doubleGpuArray) returns true, so use isobject to exclude gpuArray and friends
        if ~isfloat(x.(dataVars(i))) || isobject(x.(dataVars(i)))
            %Error if a selected variable is not built-in single or double
            error(message('MATLAB:detrend:InvalidInputVar'));
        end
    end
end

% Check class of bp now that we have samples
if ~ischar(bp)
    if isempty(samples)
        if ~(isnumeric(bp) || islogical(bp))  || ~isreal(bp) || ...
                ~(isvector(bp) || isempty(bp)) || issparse(bp)
            error(message('MATLAB:detrend:BreakpointsInvalid'));
        end
    elseif ~isempty(bp)
        if (isnumeric(bp) && ~isreal(bp)) || ...
                ~(isvector(bp) || isempty(bp)) || issparse(bp) || ...
                ~(islogical(bp) || (isnumeric(bp) && isnumeric(samples))) && ...
                ~(isequal(class(bp), class(samples)))
            error(message('MATLAB:detrend:BreakpointsInvalid'));
        end
    end
else
    bp = [];
end

% Always use a double abscissa samples and center
minS = min(samples);
if isempty(samples)
    samples = (0:N-1).'; % Default [1 2 3 ... n]
    if ~islogical(bp)
        bp = double(bp) - 1;
    end
elseif isduration(samples)
    samples = milliseconds(samples - minS);
    if ~islogical(bp)
        bp = milliseconds(bp - minS);
    end
elseif isdatetime(samples)
    if ~islogical(bp)
        if isempty(bp)
            bp = 0;
        else
            bp = milliseconds(bp - minS);
        end
    end
    samples = milliseconds(samples - minS);
else
    samples = double(samples - minS);
    if ~islogical(bp)
        bp = double(bp - minS);
    end
end

if islogical(bp)
    if length(bp) > length(samples)
        bp = bp(1:length(samples));
    end
    bp = samples(bp);
end

polyDeg = double(polyDeg);



%% parseNV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [continuity,samples,dataVars,replace] = parseNV(indStart,num,continuity,...
    samples,x,xIsTabular,dataVars,replace,varargin)
spvar = [];
dim = 1; %always 1 for detrend

% Parse name-value pairs
if rem(num-indStart,2) ~= 0
    error(message('MATLAB:detrend:KeyWithoutValue'));
end

for j = indStart:2:length(varargin)
    name = varargin{j};
    if (~(ischar(name) && isrow(name)) && ~(isstring(name) && isscalar(name)))
        error(message('MATLAB:detrend:ParseFlags'));
    elseif matlab.internal.math.checkInputName(name,{'Continuous'},4)
        continuity = varargin{j+1};
        continuity = matlab.internal.datatypes.validateLogical(continuity,'Continuous');
    elseif matlab.internal.math.checkInputName(name,{'SamplePoints'},1)
        samples = varargin{j+1};
        if xIsTabular
            if isa(x, 'timetable')
                error(message("MATLAB:samplePoints:SamplePointsTimeTable"));
            end
        else
            if (~isfloat(samples) && ~isduration(samples) && ~isdatetime(samples))
                error(message('MATLAB:samplePoints:SamplePointsInvalidDatatype'));
            end
        end
        [samples, spvar] = matlab.internal.math.checkSamplePoints(samples,x,xIsTabular,false,dim);
    elseif matlab.internal.math.checkInputName(name,{'ReplaceValues'}, 1)
        if xIsTabular
            replace = matlab.internal.datatypes.validateLogical(varargin{j+1},'ReplaceValues');
        else
            error(message('MATLAB:detrend:ReplaceValuesArray'))
        end
    elseif matlab.internal.math.checkInputName(name,{'DataVariables'},1)
        if xIsTabular
            dataVars = matlab.internal.math.checkDataVariables(x, varargin{j+1}, 'detrend');
        else
            error(message('MATLAB:detrend:DataVariablesArray'));
        end
    else
        error(message('MATLAB:detrend:ParseFlags'));
    end
end

if ~isempty(spvar)
    dataVars(dataVars == spvar) = []; % remove sample points var from data vars
end



%% reshapeInput %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,sizeX,N,isrowx,isNDx] = reshapeInput(x,permuteRow)
sizeX = cast(size(x),"like",x);
isrowx = isrow(x);
isNDx = ~ismatrix(x); % this means x is multidimensional

if ~isa(x,'tabular')
    if isrowx && permuteRow
        x = x(:);   % If a row, turn into column vector, but no need for this if a table variable is 1 x N
    elseif isNDx
        x = reshape(x,sizeX(1),[]); % If x is multidimensional, turn into a matrix
    end
end
N = size(x,1);



%% trimBp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bp = trimBp(bp,samples)
% Include bookend around break points
if ~isempty(samples)
    bp = unique([samples(1); bp(:)]);
    if numel(bp) > 1
        bp = bp(bp >= samples(1) & bp < samples(end));
    end
else
    bp = [];
end