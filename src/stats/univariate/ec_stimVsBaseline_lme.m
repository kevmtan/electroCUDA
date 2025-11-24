function [o,sAvg,sTr] = ec_stimVsBaseline_lme(o)
% Performs timeseries statistics of evoked activity over baseline 
% (e.g. prestimulus vs. peristimulus) using linear mixed-effects models.
% Trial-averaged & single-trial statistics can be obtained. Multiple
% comparisons corrections are performed across channels, timepoints, and
% bands.
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" ection)
end
% o.test=1;


%% Prep
tt = tic;
if o.test; disp("[ec_stimVsBaseline_lme] TESTING: "+o.dirs.sbj); end

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
sAvg = cell(size(sbjChs)); % Trial-averaged results 
sTr = cell(size(sbjChs)); % Single-trial results


%% Analysis template

% Epoch psych/behav task data
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,oo{:}); toc(tt); %#ok<ASGLU>
ep.Properties.RowNames = {};

% Prep regressor for time variable
ep.t = string(ep.(o.timeVar));
if numel(o.timeRng) == 2
    ep.t(ep.(o.timeVar)<o.timeRng(1) | ep.(o.timeVar)>o.timeRng(2))...
        = ""; % Clear excluded times
end

% Remove excluded times that aren't in baseline
ep(ep.t=="" & ~(ep.BLpre|ep.BLpost),:) = [];
ep.ide = uint32(1:height(ep))'; % new epoch indices


%% Analysis-specific EEG preprocessing
oo = namedargs2cell(o.pre);
[x,n] = ec_epochBaseline(x,n,psy,ep,oo{:},test=o.test); toc(tt);
o.n = n;
o.spect = n.spect;


%% Run stats per channel
parfor ch = 1:n.xChs
    %%
    [sAvg{ch},sTr{ch}] = withinCh_lfn(squeeze(x(:,ch,:)),sbjChs(ch),ep,n,o,tt);
end


%% Finalize

% Trial-averaged
if ~o.randomEffectsOnly
    sAvg = cell2table(sAvg,VariableNames="s");
    sAvg.sbjID(:) = n.sbjID;
    sAvg.sbjCh = sbjChs;
    sAvg = movevars(sAvg,["sbjID" "sbjCh"],Before="s");
    
    % Save
    fn = o.dirOut+"s"+n.sbjID+"_avg.mat";
    save(fn,"sAvg");
    disp("[ec_stimVsBaseline] Saved (time="+toc(tt)+"): "+fn); 
end

% Single-trial
if o.singleTrial
    sTr = cell2table(sTr,VariableNames="s");
    sTr.sbjID(:) = n.sbjID;
    sTr.sbjCh = sbjChs;
    sTr = movevars(sTr,["sbjID" "sbjCh"],Before="s");
    
    % Save
    fn = o.dirOut+"s"+n.sbjID+"_trials.mat";
    save(fn,"sTr");
    disp("[ec_stimVsBaseline] Saved (time="+toc(tt)+"): "+fn); 
end






%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%% Within-channel routines %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [chAvg,chST] = withinCh_lfn(xCh,sbjCh,ep,n,o,tt)
% ch=104; xCh=squeeze(x(:,ch,:)); sbjCh=sbjChs(ch);
tVar = o.timeVar;

% Preallocate chan results
chAvg = cell(n.nConds,1);
chST = cell(n.nConds,1);

%% Loop across conditions
% TODO: convert numeric vars to single, add spect name as var, run fdr_BY,
% unstack from long to wider format to save memory
for c = 1:n.nConds
    % Run LME model(s)
    if o.contrastBL
        [cAvg,cST] = lme_TvsBL_lfn(xCh,ep,n,o,c); % paired contrast (time vs. baseline)
    else
        [cAvg,cST] = lme_Tvs0_lfn(xCh,ep,n,o,c); % one-sample (time - baseline mean)
    end

    %% Organize & FDR 

    % Trial-averaged results
    if ~o.randomEffectsOnly
        % Organize
        cAvg.Name = cast(str2double(extractAfter(cAvg.Name,"t_")),...
            like=ep.(tVar));
        cAvg = mergevars(cAvg,["Lower" "Upper"],NewVariableName="CI");
        cAvg = renamevars(cAvg,["Name" "Estimate" "tStat" "pValue"],...
            [tVar "b" "t" "p"]);
        cAvg = movevars(cAvg,"frq",Before=tVar);
        cAvg.frq = categorical(cAvg.frq,n.spect.name);

        % Preallocate FDR-adjusted p-value
        cAvg.q(:) = single(nan);
        cAvg = movevars(cAvg,"q",After="p");
        
        % Get peristimulus times to FDR
        if numel(o.fdrTimeRng)==2
            id = cAvg.(tVar)>=o.fdrTimeRng(1) & cAvg.(tVar)<=o.fdrTimeRng(2);
        else
            id = true(height(cAvg),1);
        end

        % Run FDR
        cAvg.q(id) = ec_fdr(cAvg.p(id),o.alpha);
        cAvg.q(~id) = nan;

        % Unstack by freq (wide-format) to save memory
        if n.nSpect>1
            cAvg = unstack(cAvg,["b" "SE" "t" "p" "q" "CI"],"frq");
        else
            cAvg.frq = []; % Remove frq only one spectral column
        end

        % Finalize
        cAvg.sbjCh(:) = sbjCh;
        cAvg.cond(:) = n.conds(c);
        cAvg.cond = categorical(cAvg.cond,n.conds);
        cAvg = movevars(cAvg,["sbjCh" "cond"],Before=tVar);

        % Save
        chAvg{c} = cAvg;
    end

    % Single-trial results
    if o.singleTrial
        % Organize
        cST.Name = cast(str2double(extractAfter(cST.Name,"t_")),...
            like=ep.(tVar));
        cST.Level = uint16(str2double(cST.Level));
        cST = renamevars(cST,["Level" "Name" "Estimate" "SEPred" "tStat" "pValue"],...
            ["tr" tVar "b" "SE" "t" "p"]);
        cST = movevars(cST,"frq",Before=tVar);
        cST.frq = categorical(cST.frq,n.spect.name);
        cST = sortrows(cST,["frq" "tr" tVar]);

        % Preallocate FDR-adjusted p-value
        cST.q(:) = single(nan);
        cST = movevars(cST,"q",After="p");
        trs = unique(cST.tr); % Get trials
        
        % Loop across trials to run FDR in each
        for tr = trs'
            % Get peristimulus times to FDR
            if numel(o.fdrTimeRng)==2
                id = cST.tr==tr & cST.(tVar)>=o.fdrTimeRng(1) &...
                    cST.(tVar)<=o.fdrTimeRng(2);
            else
                id = cST.tr==tr;
            end

            % Run FDR
            cST.q(id) = ec_fdr(cST.p(id),o.alpha);
        end

        % Unstack by freq (wide-format) to save memory
        if n.nSpect>1
            cST = unstack(cST,["b" "SE" "t" "p" "q"],"frq");
        else
            cST.frq = [];
        end

        % Finalize
        cST.sbjCh(:) = sbjCh;
        cST.cond(:) = n.conds(c);
        cST.cond = categorical(cST.cond,n.conds);
        cST = movevars(cST,["sbjCh" "cond"],Before=tVar);

        % Save
        chST{c} = cST;
    end
    if o.test; disp("[ec_stimVsBaseline] Ran: "+sbjCh+"_"+n.conds(c)+" time="+toc(tt)); end
end

%% Finalize
chAvg = vertcat(chAvg{:});
chST = vertcat(chST{:});
disp("[ec_stimVsBaseline] Ran: "+sbjCh+" time="+toc(tt)); 




%%% Run model: time vs baseline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% paired contast of time vs. baseline observations
function [cAvg,cST] = lme_TvsBL_lfn(xCh,ep,n,o,c)
cond = n.conds(c);
idc = ep.cond==cond;
times = unique(ep.t(idc),"stable");
nTimes = numel(times);

% Preallocate cond results
cAvg = cell(nTimes*n.nSpect,1);
cST = cell(nTimes*n.nSpect,1);

% Get baseline timepoints
ep0 = ep(idc & (ep.BLpre|ep.BLpost),:);
ep0.t(:) = "BL"; % Mark baseline in time regressor

%% Loop across times
for t = 1:nTimes
    % Get epoch time
    ep1 = [ep0; ep(idc & ep.t==times(t),:)];
    if nnz(ep1.t==times(t))<15; continue; end

    %% Loop across spectral columns (freqs/bands/PCs)
    for f = 1:n.nSpect
        % Add EEG data to epoch table
        ep1.x = double(xCh(ep1.ide,f));

        % Run model
        if ~o.randomEffectsOnly
            % Linear mixed-effects model (trial-averaged & single-trial)
            lme = fitlme(ep1,"x ~ t + (t|tr)",FitMethod="REML");
        else
            % Linear random effects model (single-trial effects only)
            lme = fitlme(ep1,"x ~ -1 + (t|tr)",FitMethod="REML");
        end

        %% Extract & organize results
        id = sub2ind([nTimes n.nSpect],t,f); % get index for results

        % Get trial-averaged stats (fixed effects)
        if ~o.randomEffectsOnly
            fe = dataset2table(lme.Coefficients);
            fe(fe.Name=="(Intercept)",:) = []; % remove intercept
            fe(fe.tStat==0 & fe.pValue==1,:) = []; % remove empty times
            fe = convertvars(fe,2:8,"single"); % convert to single for memory
            fe.frq(:) = n.spect.name(f);
            cAvg{id} = fe; % save to cond results array
        end

        % Get single-trial stats (random effects)
        if o.singleTrial
            [~,~,re] = randomEffects(lme);
            re = dataset2table(re);
            re(re.Name=="(Intercept)",:) = []; % remove intercept
            re(re.tStat==0 & re.pValue==1,:) = []; % remove empty times
            re(:,["Group" "DF" "Lower" "Upper"]) = []; % remove extraneous vars   
            re = convertvars(re,3:6,"single"); % convert to single for memory
            re.frq(:) = n.spect.name(f);
            cST{id} = re;
        end
    end
end

% Concactenate within-cond results
cAvg = vertcat(cAvg{:});
cST = vertcat(cST{:});




%%% Run model: one-sample test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tests times vs. 0, where 0 is the baseline mean per trial
function [cAvg,cST] = lme_Tvs0_lfn(xCh,ep,n,o,c)
cond = n.conds(c);
idc = ep.cond==cond;
times = unique(ep.t(idc),"stable");
nTimes = numel(times);

% Preallocate cond results
cAvg = cell(nTimes*n.nSpect,1);
cST = cell(nTimes*n.nSpect,1);


%% Loop across times
for t = 1:nTimes
    % Get epoch time
    ep1 = ep(idc & ep.t==times(t),:);
    if nnz(ep1.t==times(t))<15; continue; end

    %% Loop across spectral columns (freqs/bands/PCs)
    for f = 1:n.nSpect
        % Add EEG data to epoch table
        ep1.x = double(xCh(ep1.ide,f));

        % Run model
        if ~o.randomEffectsOnly
            % Linear mixed-effects model (trial-averaged & single-trial)
            lme = fitlme(ep1,"x ~ -1+t + (-1+t|tr)",DummyVarCoding="full",...
                FitMethod="REML");
        else
            % Linear random effects model (single-trial effects only)
            lme = fitlme(ep1,"x ~ -1 + (-1+t|tr)",DummyVarCoding="full",...
                FitMethod="REML");
        end

        %% Extract & organize results
        id = sub2ind([nTimes n.nSpect],t,f); % get index for results

        % Get trial-averaged stats (fixed effects)
        if ~o.randomEffectsOnly
            fe = dataset2table(lme.Coefficients);
            fe(fe.tStat==0 & fe.pValue==1,:) = []; % remove empty times
            fe = convertvars(fe,2:8,"single"); % convert to single for memory
            fe.frq(:) = n.spect.name(f);
            cAvg{id} = fe; % save to cond results array
        end

        % Get single-trial stats (random effects)
        if o.singleTrial
            [~,~,re] = randomEffects(lme);
            re = dataset2table(re);
            re(re.tStat==0 & re.pValue==1,:) = []; % remove empty times
            re(:,["Group" "DF" "Lower" "Upper"]) = []; % remove extraneous vars   
            re = convertvars(re,3:6,"single"); % convert to single for memory
            re.frq(:) = n.spect.name(f);
            cST{id} = re;
        end
    end
end

% Concactenate within-cond results
cAvg = vertcat(cAvg{:});
cST = vertcat(cST{:});



% % Random effects covariance pattern (baseline vs. times)
% if o.covPattern=="PAT"
%     % Estimate: all variances & baseline-time covariances
%     % Constrain to 0: time-time covariances
%     o.covPAT = eye(numel(unique(ep.t))+1,"logical");
%     o.covPAT(1,:) = true;
%     o.covPAT(:,1) = true;
% end

% % Random effects covariance pattern (baseline vs. times)
% if o.covPattern=="PAT"
%     nTimes = numel(unique(epC.t));
%     covPAT = o.covPAT(1:nTimes,1:nTimes);
% else
%     covPAT = o.covPattern;
% end