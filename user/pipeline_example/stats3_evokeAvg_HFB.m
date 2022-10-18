%% Trial-averaged statistics for evoked activity

sbjs = {'s001','s002','s003'}'; 


conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"];
projectN = 'MMR';

o = struct;
o.fnString = 'evAvg_220613';
o.band = 'rHFB';
o.BLpre = [-.2 0]; %[-0.1 0]; % baseline before stim onset
o.BLend = []; %[-0.1 0]; % baseline before next stim onset
o.trL = 3.009;
o.smWin = 0.05; % smoothing gaussian width in secs
o.rmBadCh = true;
o.decimate = false;
o.fsTarg = 1000;
o.clustSize = 0.05; % secs
o.minAnalSize = 20;
o.timeBins = 0.01; % secs
o.noiseFields = {'HFO'};%{'HFO','raw_jump','diff_jump'}; % ['HFO','raw_HF_spike']
o.outlierCenter = 'median';
o.OLthr = 3; %[5 5]; % Lower and upper quantiles for outlier
o.missingInterp = 'linear';
o.k = 12; % Max Number of clustering components across timepoints
o.bin2 = 75; % an.bin2 (reduced unique bins) must be divisible by this variable
o.binP_max = 100;

% Preallocate
if ~exist('sbjStatus','var')
    sbjStatus = table;
    sbjStatus.sbj = sbj_names;
    sbjStatus.stats(:) = nan;
    sbjStatus.plot(:) = nan;
    sbjStatus.error = cell(numel(sbj_names),2);
    sbjStatus.errorFn = cell(numel(sbj_names),1);
    sbjStatus.complete(:) = false;
end
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/evoked/logs/'...
    o.fnString char(datetime('now','TimeZone','local','Format','_HHmm')) '_errors.mat'];

%load('evRobLME_220401_0813_errors.mat')
%sbjFinFn = '/home/kevin/Google Drive/UCLA/Studies/MMR/anal/evoked/logs/evSTblc_220419_0044__errors.mat';

%% Loop
pathsDMN('lbcn')
for s = 1:height(sbjStatus) %find(complete==0|isnan(complete))
    sbj = sbjStatus.sbj{s};
    blocks = BlockBySubj(sbj,projectN);

    if sbjStatus.complete(s)
        continue
    else
        try delete(gcp('nocreate')); catch; end
    end

    % Statistical analysis
    if sbjStatus.stats(s)~=1
        try
            [sbjStatus.stats(s),sbjStatus.plot(s),sbjStatus.errorFn{s}] =...
                evokeAvg3_lme(sbj,blocks,projectN,o);
        catch ME
            warning(['DID NOT COMPLETE: ' sbj])
            sbjStatus.error{s,1} = ME;
            getReport(ME)
        end
    end

    if sbjStatus.stats(s)==1 && sbjStatus.plot(s)==1
        sbjStatus.complete(s) = true;
        disp(['::: FINISHED ' sbj ' :::']);
    end

    % Save sbj log
    save(sbjFinFn,'sbjStatus','-v7');
end

try delete(gcp('nocreate')); catch; end

%% Concactenate
if ~exist('o','var')
    o.fnString = 'evAvg_220613';
end
cd(['/proj/lbcn/d/Results/stats/' o.fnString '/dat/']);
fnLat = strsplit(string(ls(['*_latency_' o.fnString '.mat'])))';
fnPct = strsplit(string(ls(['*_pctRT_' o.fnString '.mat'])))';
fnLat(fnLat=="") = []; fnPct(fnPct=="") = [];

% Load
aLat = table; aPrt = table;
for s = 1:height(fnLat)
    load(fnLat(s),"latS");
    load(fnPct(s),"pctS");

    if isempty(aLat)
        aLat = latS;
    else
        aLat = [aLat;latS]; %#ok<AGROW> 
    end

    if isempty(aPrt)
        aPrt = pctS;
    else
        aPrt = [aPrt;pctS]; %#ok<AGROW> 
    end
end

% Organize latA
aLat.Properties.RowNames = aLat.sbjCh+": "+aLat.latency+"ms";
if ~any(aLat.Properties.VariableNames=="ch")
    aLat.ch = uint8(str2double(extractAfter(aLat.sbjCh,"ch")));
    aLat = movevars(aLat,"ch","After","sbjID");
end
if ~any(aLat.Properties.VariableNames=="ms")
    aLat.Properties.VariableNames{'latency'} = 'ms';
end
aLat = movevars(aLat, 'sbjCh', 'After', width(aLat));
aLat = sortrows(aLat,["sbjID" "ch" "ms"]);

% Organize pctA
aPrt.Properties.RowNames = aPrt.sbjCh+": "+(double(aPrt.pct)./10)+"%";
if ~any(aPrt.Properties.VariableNames=="ch")
    aPrt.ch = uint8(str2double(extractAfter(aPrt.sbjCh,"ch")));
    aPrt = movevars(aPrt,"ch","After","sbjID");
end
aPrt = sortrows(aPrt,["sbjID" "ch" "pct"]);
aPrt = movevars(aPrt, 'sbjCh', 'After', width(aPrt));

% Convert datatype for smaller file sizes
idx = contains(aLat.Properties.VariableNames,("_SE"|"_p"|"_q"));
aLat = convertvars(aLat,idx,'single');
aLat.sbjID = uint8(aLat.sbjID);
aLat.ms = int16(aLat.ms);

idx = contains(aPrt.Properties.VariableNames,("_SE"|"_p"|"_q"));
aPrt = convertvars(aPrt,idx,'single');
aPrt.sbjID = uint8(aPrt.sbjID);

% Save
save(['/proj/lbcn/d/Results/stats/' o.fnString '/latA_' o.fnString '.mat'],'aLat','-v7');
save(['/proj/lbcn/d/Results/stats/' o.fnString '/pctA_' o.fnString '.mat'],'aPrt','-v7');

%%
if ~exist('o','var')
    o.fnString = 'evAvg_220613';
end
cd(['/proj/lbcn/d/Results/stats/' o.fnString]);

sbjDirs = struct2table(dir);
sbjDirs = convertvars(sbjDirs,["name" "folder"],"string");
sbjDirs(~startsWith(sbjDirs.name,"s") | ~sbjDirs.isdir,:) = [];

trs = table; chs = table;
for s = 1:height(sbjDirs)
    try fn = strtrim(ls(sbjDirs.folder(s)+"/"+sbjDirs.name(s)+"/*_misc.mat"));
    catch; warning(num2str(s)); continue;
    end
    load(fn,"trialNfo","chNfo");
    if isempty(trs); trs = trialNfo;
        else; trs = [trs;trialNfo]; %#ok<AGROW> 
    end
    if isempty(chs); chs = chNfo;
    else; chs = [chs;chNfo]; %#ok<AGROW> 
    end
end

trs = convertvars(trs,["sbjID" "r2"],"uint8");
chs = convertvars(chs,["sbjID" "ch"],"uint8");

save(['/proj/lbcn/d/Results/stats/' o.fnString '/trs_' o.fnString '.mat'],'trs','-v7');
save(['/proj/lbcn/d/Results/stats/' o.fnString '/chs_' o.fnString '.mat'],'chs','-v7');
