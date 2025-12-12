function [ch_bad,x_bad] = ec_findBadFrames(x,ch_bad,x_bad,w,thr)
%% Find bad channels or components
%  Inputs (thr=0 to skip specific metric):

% Input validation
arguments
    x {mustBeFloat}  % EEG matrix: x(time,ch) | x(time,ch,freq)
    ch_bad table = []
    x_bad table = []
    w {isnumeric,islogical,istext} = []
    thr.mad {mustBeNumeric} = 0    % Median absolute deviation thresh (try 15)
    thr.diff {mustBeNumeric} = 0   % 1st-order differential thresh (try 5)
    thr.sns {mustBeNumeric} = 0 % Sensor-specific noise thresh (try 5)
    %thr.cov {mustBeNumeric} = 0 % Sensor-specific noise thresh (try 5)
end
%thr.mad=10; thr.diff=10; thr.sns=3;

%% Prep
nChs = width(x);
nFrames = height(x);
if isempty(ch_bad); ch_bad=table; end
if isempty(x_bad); x_bad=table; end
if isequal(size(x),size(w))
    w = double(full(~w));
end
x = normalize(x,1,"zscore","robust");

%% Median absolute deviation
if thr.mad > 0
    ol = isoutlier(x,"median",ThresholdFactor=thr.mad);
    x_bad.mad = ol;
    ch_bad.mad = false(nChs,1); 
    ch_bad.madP = sum(ol)'./nFrames;
    [~,~,thrHi] = isoutlier(ch_bad.madP,"median",ThresholdFactor=thr.mad);
    ch_bad.mad = ch_bad.madP > thrHi;
end

%% First-order differential
if thr.diff > 0
    ol = diff(x,1,1);
    ol = [false(1,width(ol)); isoutlier(ol,"median",ThresholdFactor=thr.diff)];
    x_bad.diff = ol;
    ch_bad.flat = false(nChs,1); 
    ch_bad.diff = false(nChs,1); 
    ch_bad.diffP = sum(ol)'./nFrames;
    [~,thrLo,thrHi] = isoutlier(ch_bad.diffP,"median",ThresholdFactor=thr.diff);
    ch_bad.diff = ch_bad.diffP > thrHi;
    ch_bad.flat = ch_bad.diffP < thrLo;
end

%% Sensor-specific noise
if thr.sns > 0
    ol = ec_sensorNoise(x,w); % remove sensor specific
    ol = abs(ol-x); % residual 
    x_bad.sns  = isoutlier(ol,"median",ThresholdFactor=thr.sns);
    ch_bad.sns = false(nChs,1); 
    ch_bad.snsP = sum(ol,"omitnan")';
    ch_bad.sns = isoutlier(ch_bad.snsP,"median",ThresholdFactor=thr.sns);
    %[~,~,thrHi] = isoutlier(ch_bad.snsP,"median",ThresholdFactor=thr.sns);
    %ch_bad.sns = ch_bad.snsP > thrHi;
end

%% Convert to sparse
varCh = varfun(@islogical,ch_bad(1,:),"OutputFormat","uniform") |...
    varfun(@isfloat,ch_bad(1,:),"OutputFormat","uniform");
ch_bad = convertvars(ch_bad,varCh,'sparse');

varX = varfun(@islogical,x_bad(1,:),"OutputFormat","uniform") |...
    varfun(@isfloat,x_bad(1,:),"OutputFormat","uniform");
x_bad = convertvars(x_bad,varX,'sparse');
end




    
    