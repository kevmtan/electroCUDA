function [o,stats] = ec_condVsCondChs_lm(o)
% Performs timeseries statistics contrasting two task conditions within
% channels
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" section)
end
% o.test=1;


%% Prep
tt = tic;
if o.test; disp("[ec_condVsCondChs_lm] TESTING: "+o.dirs.sbj); end
o.nCons = numel(o.stats.contrasts);

% Load
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if o.test && isempty(dbstack); nOg=n; xOg=x; trialNfoOg=trialNfo; end %#ok<NASGU>
toc(tt);

% Channel/IC names
sbjChs = chNfo.sbjCh;
if o.ICA
    sbjChs = n.icNfo.sbjIC; end

% Preallocate results
stats = cell(size(sbjChs)); % Trial-averaged results 


%% Analysis template

% Epoch psych/behav task data
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,oo{:}); toc(tt); %#ok<ASGLU>
ep.Properties.RowNames = {};

% Rename timebin variable
ep = renamevars(ep,o.stats.binVar,"t");

% Remove excluded timebins
ep(ep.t<o.stats.binRng(1) | ep.t>o.stats.binRng(2),:) = [];
ep.ide = uint32(1:height(ep))'; % new epoch indices


%% Analysis-specific EEG preprocessing
oo = namedargs2cell(o.pre);
[x,n] = ec_epochBaseline(x,n,psy,ep,oo{:},test=o.test); toc(tt);
o.n = n;
o.spect = n.spect;


%% Run stats per channel
parfor ch = 1:n.xChs
    %%
    stats{ch} = withinCh_lfn(squeeze(x(:,ch,:)),sbjChs(ch),ep,n,o,tt);
end


%% Finalize
stats = cell2table(stats,VariableNames="s");
stats.sbjID(:) = n.sbjID;
stats.sbjCh = sbjChs;
stats = movevars(stats,["sbjID" "sbjCh"],Before="s");

% Save
fn = o.dirOut+"s"+n.sbjID+"_avg.mat";
save(fn,"stats");
disp("[ec_condVsCond] Saved (time="+toc(tt)+"): "+fn);






%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%% Within-channel routines %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function statCh = withinCh_lfn(xCh,sbjCh,ep,n,o,tt)
% ch=104; xCh=squeeze(x(:,ch,:)); sbjCh=sbjChs(ch);

% Convert EEG data
xCh = cast(xCh,o.stats.typeProc); % to specified precision
if o.stats.gpu % to GPU
    xCh = gpuArray(xCh); end

statCh = cell(n.nConds,1); % Preallocate chan results

%% Loop across contrasts
for c = 1:o.nCons
    statCh{c} = contrast_lfn(xCh,ep,o,c); % Run contrast across timebins & freqs
end

%% Finalize
statCh = vertcat(statCh{:}); % concactenate to table
statCh = renamevars(statCh,["Estimate" "tStat" "pValue"],["b" "t" "p"]);
statCh.frq = categorical(statCh.frq,o.spect.name); % for unstack order!

% Gather data from GPU
if o.stats.gpu
    statCh = convertvars(statCh,@isgpuarray,@gather); end

% Convert to specified FP precision
statCh = convertvars(statCh,["b" "SE" "t" "p" "q"],o.stats.typeOut);

% Unstack by freq (wide-format) to save memory
if o.n.nSpect > 1
    statCh = unstack(statCh,["b" "SE" "t" "p" "q"],"frq");
else
    statCh.frq = []; % Remove frq only one spectral column
end

% Finalize
statCh.sbjCh(:) = sbjCh;
statCh.con = categorical(statCh.con,o.stats.contrasts);
statCh = movevars(statCh,["sbjCh" "con"],Before=o.stats.binVar);
disp("[ec_condVsCondChs_lm] Ran: "+sbjCh+" time="+toc(tt)); 






%%% Run model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sc = contrast_lfn(xCh,ep,o,c)
% Get info
con = o.stats.contrasts(c); % contrast name
cond0 = o.stats.cond0{c};
cond1 = o.stats.cond1{c};
tVar = o.stats.binVar;
nFrq = o.n.nSpect;

% Epochs for conditions in contrast
epc = ep(ismember(ep.cond,[cond0 cond1]),["t" "cond" "ide"]);

% Create contrast regressor
epc.con(:) = false;
epc.con(ismember(epc.cond,cond1)) = true;

% Get bin info
bins = groupcounts(epc,["t" "con"]);
binL = unique(bins.t(bins.GroupCount<15)); % Bins without enough samples
bins = unique(bins.t);
bins(ismember(bins,binL)) = []; % exclude bins with too small samples
nBins = numel(bins);

% Preallocate cond results
sc = cell(nBins*nFrq,1);

% Move to GPU
if o.stats.gpu
    epc = convertvars(epc,@isnumeric,@gpuArray);
    bins=gpuArray(bins); nBins=gpuArray(nBins); nFrq=gpuArray(nFrq);
end


%% Loop across timebins
for t = 1:nBins
    bin = bins(t);
    ept = epc(epc.t==bin,["ide" "con"]);

    %% Loop across spectral columns (freqs/bands/PCs)
    for f = 1:nFrq
        % Add EEG data to epoch table
        ept.x = xCh(ept.ide,f);

        % Run model
        lm = fitlm(ept,'x ~ con');

        %% Extract & organize results
        id = sub2ind([nBins nFrq],t,f); % get index for results

        % Get trial-averaged stats (fixed effects)
        fe = lm.Coefficients(2,:);
        fe.Properties.RowNames = {};
        fe.(o.stats.binVar) = bin;
        fe.frq = o.spect.name(f);
        sc{id} = fe; % save to cond results array
    end
end


%% Organize & FDR
sc = vertcat(sc{:}); % Concactenate within-cond results

% Get peristimulus bins to FDR
if numel(o.stats.fdrBinRng)==2
    id = sc.(tVar)>=o.stats.fdrBinRng(1) & sc.(tVar)<=o.stats.fdrBinRng(2);
else
    id = true(height(sc),1);
end

% Run FDR
sc.q(id) = fdr_BH(sc.pValue(id),o.stats.alpha);
sc.q(~id) = nan;

% Finalize
sc.con(:) = con;