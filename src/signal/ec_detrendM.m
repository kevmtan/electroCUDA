function [y,xx,p,W] = ec_detrendM(x,varargin)
%DETREND Remove a polynomial trend.
%   Y = DETREND(X) removes the best straight-line fit linear trend from the
%   data in vector X and returns the residual in vector Y.  If X is a
%   matrix, DETREND removes the trend from each column of the matrix. If
%   X is a table or timetable, then DETREND operates on each variable
%   separately.
%
%   Y = DETREND(X,n) removes a polynomial trend with degree n. n = 1 by
%   default. Setting n = 0 is equivalent to using the 'constant' option and
%   setting n = 1 is equivalent to using the 'linear' option.
%
%   Y = DETREND(X,n,BP) removes a continuous, piecewise polynomial trend
%   according to the break points specified in BP. BP can be a vector of
%   sample point values or a logical vector of length equal to the number
%   of sample points, where true indicates the position of a break point.
%
%   Y = DETREND(___,NANFLAG) specifies how NaN (Not-A-Number) values are
%   treated. The default is 'includenan':
%      'includenan' - NaNs are included when calculating the polynomial
%                     trend. If NaNs are present, then the trend and the
%                     corresponding output will be vectors of NaNs.
%
%      'omitnan'    - NaN values are omitted when calculating the trend.
%                     NaN values in the input produce corresponding NaN
%                     values in the output.
%
%   Y = DETREND(___,'Continuous',TF) specifies whether the piecewise
%   polynomial trend is required to be continuous. TF must be one of the
%   following:
%      true         - (default) the fitted trend is continuous everywhere
%      false        - the fitted trend is not required to be continuous
%
%   Y = DETREND(___,'SamplePoints',S) also specifies the sample points S
%   associated with the data in X. S must be a floating-point, duration or
%   datetime vector. S must be sorted and contain unique points. If the
%   first input is a table, S can also specify a table variable. You can
%   use S to specify time stamps for the data. By default, DETREND assumes
%   the data is sampled uniformly at points S = [1 2 3 ... ].
%
%   Arguments supported only when first input is table or timetable:
%
%   Y = DETREND(...,'DataVariables',DV) removes a polynomial trend from the
%   data only in the table variables specified by DV. Other variables in the
%   table not specified by DV pass through to the output without being
%   operated on. The default is all table variables in X. DV must be a table
%   variable name, a cell array or string array of table variable names, a
%   vector of table variable indices, a logical vector, a function handle
%   that returns a logical scalar (such as @isnumeric), or a table vartype
%   subscript. The output table Y has the same size as the input table X.
%
%   Y = DETREND(...,'ReplaceValues',TF) specifies how the detrended data
%   is returned. TF must be one of the following:
%        true  - (default) replace table variables with the detrended data
%        false - append the detrended data as additional table variables
%   If the value of ReplaceValues is false, then the width of Y is the sum
%   of the input data width and the number of data variables specified.
%
%   Examples:
%
%      % Remove a continuous, piecewise linear trend
%      sig = [0 1 -2 1 0 1 -2 1 0];      % signal with no linear trend
%      trend = [0 1 2 3 4 3 2 1 0];      % two-segment linear trend
%      x = sig + trend;                    % signal with added trend
%      y = detrend(x,1,5)                % break point at 5th element
%
%      % Remove a nonlinear trend
%      sig = repmat(sig,1,2);
%      trend = ((1:18)/18).^3;
%      x = sig + trend;
%      y = detrend(x,3);
%      plot(sig); hold on
%      plot(y)
%
%      % Remove discontinuous linear trend with sample points
%      t = -10:10;
%      x = t.^3 + 6*t.^2 + 4*t + 3;
%      bp = 0;
%      y = detrend(x,1,bp,'SamplePoints',t,'Continuous',false);
%      plot(t,x,t,y,t,x-y,':k')
%      legend('Input Data','Detrended Data','Trend','Location','northwest')
%
%      % Remove quadratic trend from the selected variable in a table
%       t = (-4:4)';
%       trend = (t.^2 + 4*t + 3);
%       sig = [0 1 -2 1 0 1 -2 1 0]';
%       x = sig + trend;
%       T = table(t,trend,sig,x);
%       T = detrend(T,2,"DataVariables","x","SamplePoints","t","ReplaceValues",false);
%       stackedplot(T,"XVariable","t")
%
%   See also TRENDDECOMP, MEAN, ISCHANGE, POLYFIT, POLYVAL

%   Copyright 1984-2022 The MathWorks, Inc.

%% Prep

% Parse inputs
x = full(x);
[x,polyDeg,bp,samples,continuity,sizeX,N,isrowx,isNDx,omitnan,...
    xIsTabular,dataVars,replace,permuteRow] = parseInputs(x, varargin{:});
notUniquePoly = false;

% Run detrend on table or array
if xIsTabular
    [y,notUniquePoly,p,W] = detrendTable(x,omitnan,polyDeg,bp,samples,continuity,dataVars,replace,notUniquePoly);
else
    [y,notUniquePoly,p,W] = detrendArray(x,omitnan,polyDeg,bp,samples,sizeX,isrowx,isNDx,continuity,N,permuteRow,notUniquePoly);
end

% Get best fit trend
if nargout > 1
    xx = W*p;
end


if notUniquePoly; warning(message('MATLAB:detrend:PolyNotUnique')); end




%%%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% Detrend an array -------------------------------------------------------
function [y,notUniquePoly,p,W] = detrendArray(x,omitnan,polyDeg,bp,samples,sizeX,...
    isrowx,isNDx,continuity,N,permuteRow,notUniquePoly)
if omitnan && anynan(x)
    nanMask = isnan(x);
    dims = size(x);
    y = NaN(dims,'like',x);

    if iscolumn(x)
        % Detrend a column vector ----------------------------------
        bpNoNans = trimBp(bp,samples(~nanMask));
        [y(~nanMask),notUniquePoly,p,W] = detrendInternal(x(~nanMask),...
            polyDeg,bpNoNans,samples(~nanMask),continuity,nnz(~nanMask),notUniquePoly);
        if height(W)~=dims(1)
            W = makeW_allSamples(bp,samples,polyDeg,N,x); % Build regressor for full data
        end
    else
        % Detrend an nD-array ----------------------------------------------
        p = nan(polyDeg+1,dims(2:end),'like',x); % Preallocate polynomial array

        % Columns without NaNs
        columnHasNan = any(nanMask,1);
        if any(~columnHasNan)
            bp = trimBp(bp,samples);
            [y(:,~columnHasNan),notUniquePoly,p(:,~columnHasNan),W] =...
                detrendInternal(x(:,~columnHasNan),polyDeg,bp,samples,continuity,N,notUniquePoly);
        else
            W = makeW_allSamples(bp,samples,polyDeg,N,x); % Build regressor for full data
        end

        % Columns with NaNs
        columnInd = find(columnHasNan);
        for ii = columnInd
            bpNoNans = trimBp(bp,samples(~nanMask(:,ii)));
            [y(~nanMask(:,ii),ii),notUniquePoly,p(:,ii)] =...
                detrendInternal(x(~nanMask(:,ii),ii),polyDeg,bpNoNans,...
                samples(~nanMask(:,ii)),continuity,nnz(~nanMask(:,ii)),notUniquePoly);
        end
    end
else
    bp = trimBp(bp,samples);
    [y,notUniquePoly,p,W] = detrendInternal(x,polyDeg,bp,samples,continuity,N,notUniquePoly);
end

if isrowx && permuteRow
    y = y.';
elseif isNDx
    y = reshape(y,sizeX);
end


%% Detrend tabular data ---------------------------------------------------
function [y,notUniquePoly,p,W] = detrendTable(x,omitnan,polyDeg,bp,samples,continuity,...
    dataVars,replace,notUniquePoly)
tempTable = x(:,dataVars);
for i = 1:numel(dataVars)
    tempVar = x.(dataVars(i));
    permuteRow = false; % Don't convert a row vector into a column vector for table variables
    [tempVar,sizeX,N,isrowx,isNDx] = reshapeInput(tempVar,permuteRow);
    [tempTable.(i),notUniquePoly,p,W] = detrendArray(tempVar,omitnan,polyDeg,bp,samples,sizeX,isrowx,isNDx,continuity,N,permuteRow,notUniquePoly);
end

if replace
    x(:,dataVars) = tempTable;
    y = x;
else
    y = matlab.internal.math.appendDataVariables(x,tempTable,"detrended");
end


%% Main detrend function --------------------------------------------------
function [y,notUniquePoly,p,W] = detrendInternal(x,polyDeg,bp,samples,continuity,...
    N,notUniquePoly)

lbp = length(bp);
% Detrend computation
if continuity %% Continuous demean ----------------------------------------
    if polyDeg == 0
        W = samples;
        if isempty(bp) % Subtract mean of data
            p = mean(x,1);
            y = x - p;
        else % Continuous constant subtracts the mean of the first segment
            [~,begSeg] = min(abs(samples-bp(1)));
            if lbp == 1
                endSeg = numel(samples);
            else
                [~,endSeg] = min(abs(samples - bp(2)));
            end
            p = mean(x(begSeg:endSeg,:),1);
            y = x - p;
        end
    else % Continuous, piecewise polynomial trend -------------------------

        % Normalize to avoid numerical issues
        if isempty(samples)
            a = samples;
            scaleS = samples;
        else
            scaleS = samples(end);
            if scaleS == 0
                a = samples;
            else
                a = samples./scaleS;
            end
        end

        % Build regressor
        b = a - (bp./scaleS)';
        b = max(b,0);
        W = b(:).^(polyDeg:-1:1);
        W = [reshape(W,N,[]), ones(N,1)];
        W = cast(W,'like',x);

        % Solve least squares problem p = W\x1
        [p, rankW] = matlab.internal.math.leastSquaresFit(W,x);

        if size(W,1) < size(W,2) || rankW < size(W,2)
            notUniquePoly=true;
        end

        % Remove best fit
        y = x - cast(W*p,'like',x);
    end
else %% Discontinuous detrend ---------------------------------------------
    error("Discontinuous not yet supported");
    %     y = zeros(size(x),'like',x);
    %     segments = sum(samples >= bp',2);
    %     x1 = full(x);
    %     W = cell(lbp,1);
    %     p = cell(lbp,1);
    %
    %     % Loop segments
    %     for k = 1:lbp
    %         segidx = segments == k;
    %
    %         if polyDeg == 0 || nnz(segidx) == 1
    %             % Remove mean from each segment
    %             y(segidx,:) = x(segidx,:) - mean(x(segidx,:),1);
    %         else
    %             % Normalize before fitting polynomial
    %             a = samples(segidx);
    %             [std_a, mean_a] = std(a);
    %             a = (a - mean_a)./std_a;
    %
    %             % Construct the Vandermonde matrix
    %             V = [a.^(polyDeg:-1:1), ones(nnz(segidx),1)];
    %             V = cast(V,'like',x1);
    %
    %             % Solve least squares problem tr = V\x1
    %             [tr, rankV] = matlab.internal.math.leastSquaresFit(V,x1(segidx,:));
    %
    %             if size(V,1) < size(V,2) || rankV < size(V,2)
    %                 notUniquePoly = true;
    %             end
    %
    %             % Remove best fit
    %             y(segidx,:) = x(segidx,:) - cast(V*tr,'like',x);
    %
    %             % Save regressors
    %             W{k} = V;
    %             p{k} = tr;
    %         end
end



%% Parse inputs -----------------------------------------------------------
function [x,polyDeg,bp,samples,continuity,sizeX,N,isrowx,isNDx,omitNan,...
    xIsTabular,dataVars,replace,permuteRow] = parseInputs(x,varargin)
% Parse inputs

xIsTabular = istabular(x);

if ~isfloat(x) && ~xIsTabular
    error(message('MATLAB:detrend:InvalidFirstInput'));
end

permuteRow = true; %Convert row vector to column vector if it's not the content of a table variable
[x,sizeX,N,isrowx,isNDx] = reshapeInput(x,permuteRow);

% Set default values
bp = [];
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
    elseif ~islogical(polyDeg) && (~isnumeric(polyDeg) || ~isreal(polyDeg) || polyDeg < 0 || mod(polyDeg,1) ~= 0)
        error(message('MATLAB:detrend:InvalidTrendInputType'));
    else
        polyDeg = double(polyDeg);
    end

    % Parse break points bp
    if nargin > 2 && ~(ischar(varargin{indStart}) || isstring(varargin{indStart}))
        bp = varargin{indStart};
        indStart = indStart+1;
    end

    if indStart<nargin && (ischar(varargin{indStart}) || isstring(varargin{indStart}))
        if matlab.internal.math.checkInputName(varargin{indStart},{'omitnan'},1)
            omitNan = true;
            indStart = indStart+1;
        elseif matlab.internal.math.checkInputName(varargin{indStart},{'includenan'},1)
            indStart = indStart+1;
        end
    end

    % Parse name-value pairs
    [continuity,samples,dataVars,replace] = parseNV(indStart,nargin,continuity,samples,x,xIsTabular,dataVars,replace,varargin{:});
end

if xIsTabular
    for i = 1:numel(dataVars)
        tvar=x.(dataVars(i));
        %isfloat(doubleGpuArray) returns true, so use isobject to exclude gpuArray and friends
        if ~isfloat(tvar) || isobject(tvar) && ismethod(tvar,'detrend')
            error(message('MATLAB:detrend:InvalidInputVar'));
        end
    end
end

% Check bp now that we have non-default s
if isempty(bp)
    if isnumeric(samples) && (isnumeric(bp) || islogical(bp)) ||...
            isdatetime(samples) && (isnumeric(bp) || islogical(bp) || isdatetime(bp)) ||...
            isduration(samples) && (isnumeric(bp) || islogical(bp) || isduration(bp))
        %For datetime and duration s, isnumeric(bp) is needed to make sure empty
        %bp, like [] or double.empty, works with no issues
        bp=[];
    else
        error(message('MATLAB:detrend:BreakpointsInvalid'));
    end
else
    if (isnumeric(bp) && ~isreal(bp)) || ...
            ~isvector(bp) ||issparse(bp) || ...
            ~(islogical(bp) || (isnumeric(bp) && isnumeric(samples))) && ...
            ~isequal(class(bp), class(samples))
        %Last logical says: if bp and s are of different datatypes, then either bp is logical or bp and s are of different kinds of numeric datatypes

        error(message('MATLAB:detrend:BreakpointsInvalid'));
    end
end

% Always use a double abscissa s and center
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
    if length(bp)>length(samples)
        bp = bp(1:length(samples));
    end
    bp = samples(bp);
end


%% parseNV ----------------------------------------------------------------
function [continuity,samples,dataVars,replace] = parseNV(indStart,num,continuity,samples,x,xIsTabular,dataVars,replace,varargin)
spvar = [];
dim = 1; %always 1 for detrend

% Parse name-value pairs
if rem(num-indStart,2) ~= 0
    error(message('MATLAB:detrend:KeyWithoutValue'));
end
for j = indStart:2:length(varargin)
    name = varargin{j};
    if matlab.internal.math.checkInputName(name,{'Continuous'},4)
        continuity = varargin{j+1};
        continuity=matlab.internal.datatypes.validateLogical(continuity,'Continuous');
    elseif matlab.internal.math.checkInputName(name,{'SamplePoints'},1)
        samples=varargin{j+1};
        if xIsTabular
            if istimetable(x)
                error(message("MATLAB:samplePoints:SamplePointsTimeTable"));
            end
        else
            if (~isfloat(samples) && ~isduration(samples) && ~isdatetime(samples))
                error(message('MATLAB:samplePoints:SamplePointsInvalidDatatype'));
            end
        end
        [samples,spvar] = matlab.internal.math.checkSamplePoints(samples,x,xIsTabular,false,dim);
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



%% Reshape ----------------------------------------------------------------
function [x,sizeX,N,isrowx,isNDx] = reshapeInput(x,permuteRow)
sizeX = size(x);
isrowx = isrow(x);
isNDx = ~ismatrix(x); % this means x is multidimensional

if ~istabular(x)
    if isrowx && permuteRow
        x = x(:);   % If a row, turn into column vector, but no need for this if a table variable is 1 x N
    elseif isNDx
        x = reshape(x,sizeX(1),[]); % If x is multidimensional, turn into a matrix
    end
end
N = size(x,1);



%% trimBp -----------------------------------------------------------------
function bp = trimBp(bp,s)
% Include bookend around break points
if ~isempty(s)
    bp = unique([s(1); bp(:)]); %first samplepoint must be the first breakpoint and bp is sorted via unique
    if numel(bp) > 1
        bp = bp(bp >= s(1) & bp < s(end)); %only bp within the range of s are used
    end
else
    bp = [];
end

%% make W for all samples (including nans)
function W = makeW_allSamples(bp,samples,polyDeg,N,x)
bp = trimBp(bp,samples);
% Normalize to avoid numerical issues
if isempty(samples)
    a = samples;
    scaleS = samples;
else
    scaleS = samples(end);
    if scaleS == 0
        a = samples;
    else
        a = samples./scaleS;
    end
end

% Build regressor
b = a - (bp./scaleS)';
b = max(b,0);
W = b(:).^(polyDeg:-1:1);
W = [reshape(W,N,[]), ones(N,1)];
W = cast(W,'like',full(x));