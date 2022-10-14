function [ch_bad,x_bad] = ec_findBadFrames(x,ch_bad,x_bad,sfx,thr)
%% Find bad channels or components
%  Inputs (thr=0 to skip specific metric):

% Input validation
arguments
    x {mustBeFloat,mustBeDims(x,[2 3])}  % EEG matrix: x(time,ch) | x(time,ch,freq)
    ch_bad table = []
    x_bad table = []
    sfx {mustBeText} = ""
    thr.mad {mustBeNumeric} = 0    % Median absolute deviation thresh (try 15)
    thr.diff {mustBeNumeric} = 0   % 1st-order differential thresh (try 5)
    thr.sns {mustBeNumeric} = 0 % Sensor-specific noise thresh (try 5)
end
%thr.mad=10; thr.diff=10; thr.sns=3;

%% Prep
nChs = width(x);
nFrames = height(x);
if isempty(ch_bad); ch_bad=table; end
if isempty(x_bad); x_bad=table; end

x = normalize(x,1,"zscore");

%% Median absolute deviation
if thr.mad > 0
    ol = isoutlier(x,"median",1,ThresholdFactor=thr.mad);
    if length(size(ol))==3; ol=permute(ol,[2 1 3]); else; ol=ol'; end
    x_bad.mad = ol;
    ch_bad.("mad"+sfx) = false(nChs,1); 
    ch_bad.("madP"+sfx) = sum(ol,2)./nFrames;
    [~,~,upperThr] = isoutlier(ch_bad.("madP"+sfx),"median",ThresholdFactor=thr.mad*2);
    ch_bad.("mad"+sfx) = ch_bad.("madP"+sfx) > upperThr;
end

%% First-order differential
if thr.diff > 0
    ol = diff(x,1,1);
    ol = [false(1,width(ol));...
        isoutlier(ol,"median",2,ThresholdFactor=thr.diff)];
    if length(size(ol))==3; ol=permute(ol,[2 1 3]); else; ol=ol'; end
    x_bad.diff = ol;
    ch_bad.("diff"+sfx) = false(nChs,1); 
    ch_bad.("diffP"+sfx) = sum(ol,2)./nFrames;
    [~,~,upperThr] = isoutlier(ch_bad.("diffP"+sfx),"median",ThresholdFactor=thr.diff*2);
    ch_bad.("diff"+sfx) = ch_bad.("diffP"+sfx) > upperThr;
end

%% Sensor-specific noise
if thr.sns > 0
    ol = KT_sns(x,nChs); % remove sensor specific
    ol = ol-x; % residual
    ol = abs(ol) > median(abs(ol),1,"omitnan")*thr.sns;
    if length(size(ol))==3; ol=permute(ol,[2 1 3]); else; ol=ol'; end
    x_bad.sns = ol;
    ch_bad.("sns"+sfx) = false(nChs,1); 
    ch_bad.("snsP"+sfx) = sum(x_bad.sns,2)./nFrames;
    [~,~,upperThr] = isoutlier(ch_bad.("snsP"+sfx),"median",ThresholdFactor=thr.sns*2);
    ch_bad.("sns"+sfx) = ch_bad.("snsP"+sfx) > upperThr;
end

%% Convert to sparse
if length(size(x))<3
    varCh = varfun(@islogical,ch_bad(1,:),"OutputFormat","uniform") |...
        varfun(@(x) isa(x,"double"),ch_bad(1,:),"OutputFormat","uniform");
    ch_bad = convertvars(ch_bad,varCh,'sparse');
    varX = varfun(@islogical,x_bad(1,:),"OutputFormat","uniform") |...
        varfun(@(x) isa(x,"double"),x_bad(1,:),"OutputFormat","uniform");
    x_bad = convertvars(x_bad,varX,'sparse');
end




    
    