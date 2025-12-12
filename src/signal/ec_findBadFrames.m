function [chBad,xBad] = ec_findBadFrames(x,chBad,xBad,w,thr)
%% Find bad channels or components
%  Inputs (thr=0 to skip specific metric):

% Input validation
arguments
    x {mustBeFloat}  % EEG matrix: x(time,ch) | x(time,ch,freq)
    chBad table = []
    xBad table = []
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
if isempty(chBad); chBad=table; end
if isempty(xBad); xBad=table; end
if isequal(size(x),size(w))
    w = double(full(~w));
end
x = normalize(x,1,"zscore","robust");

%% Median absolute deviation
if thr.mad > 0
    ol = isoutlier(x,"median",ThresholdFactor=thr.mad);
    xBad.mad = ol;
    chBad.mad = false(nChs,1); 
    chBad.madP = sum(ol)'./nFrames;
    [~,~,thrHi] = isoutlier(chBad.madP,"median",ThresholdFactor=thr.mad);
    chBad.mad = chBad.madP > thrHi;
end

%% First-order differential
if thr.diff > 0
    ol = diff(x,1,1);
    ol = [false(1,width(ol)); isoutlier(ol,"median",ThresholdFactor=thr.diff)];
    xBad.diff = ol;
    chBad.flat = false(nChs,1); 
    chBad.diff = false(nChs,1); 
    chBad.diffP = sum(ol)'./nFrames;
    [~,thrLo,thrHi] = isoutlier(chBad.diffP,"median",ThresholdFactor=thr.diff);
    chBad.diff = chBad.diffP > thrHi;
    chBad.flat = chBad.diffP < thrLo;
end

%% Sensor-specific noise
if thr.sns > 0
    ol = ec_sensorNoise(x,w); % remove sensor specific
    ol = abs(ol-x); % residual 
    xBad.sns  = isoutlier(ol,"median",ThresholdFactor=thr.sns);
    chBad.sns = false(nChs,1); 
    chBad.snsP = sum(ol,"omitnan")';
    chBad.sns = isoutlier(chBad.snsP,"median",ThresholdFactor=thr.sns);
    %[~,~,thrHi] = isoutlier(ch_bad.snsP,"median",ThresholdFactor=thr.sns);
    %ch_bad.sns = ch_bad.snsP > thrHi;
end

%% Convert to sparse
varCh = varfun(@islogical,chBad(1,:),"OutputFormat","uniform") |...
    varfun(@isfloat,chBad(1,:),"OutputFormat","uniform");
chBad = convertvars(chBad,varCh,'sparse');

varX = varfun(@islogical,xBad(1,:),"OutputFormat","uniform") |...
    varfun(@isfloat,xBad(1,:),"OutputFormat","uniform");
xBad = convertvars(xBad,varX,'sparse');
end




    
    