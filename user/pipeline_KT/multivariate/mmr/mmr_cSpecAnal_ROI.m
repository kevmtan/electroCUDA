function stat = mmr_cSpecAnal_ROI(oa)
arguments
    oa struct
end

%% Load
tt = tic; % Start timer

% Nuisance var: nv includes surrounding "+" so formula is always "fixed"+nv+"(rand...)"
% e.g. oa.nv=["VD" "K_PCA1"] → nv="+VD+K_PCA1+"; no oa.nv → nv="+"
if isfield(oa,"nv") && isany(oa.nv)
    oa.nv = "+"+join(string(oa.nv),"+")+"+";
else
    oa.nv = "+";
end

% Load o struct from oa.analDir/o_<analName>.mat
[~, analName] = fileparts(oa.analDir);
load(string(oa.analDir)+filesep+"o_"+analName, "o");

% Load logs
load(o.analOut+"logs_"+o.analName,"logs"); 
if any(~logs.class)
    warning("Skipping unfinished subjects: "+join(logs.sbj(~logs.class),", "));
end

% Limit to finished subjects
logs = logs(logs.class,:);
nSbj = height(logs);

% Preallocate
oba = cell(nSbj,1); % observations from all sbjs

% Load observations across subjects
for s = 1:nSbj
    % Subject observations
    load(logs.ob(s),"ob");

    % Make ROIs ordinal categoricals in tables (ROIs in 'ch' var)
    ob.ch = categorical(ob.ch,o.p.ROIs,Ordinal=true);
    oba{s} = ob;
end
disp("Finished loading data: toc="+toc(tt));


%% LPF smoothing of posterior probability for analyses
if isfield(oa,"lpf") && oa.lpf > 0
    oba = lpf_lfn(oba,logs,oa,tt);
end


%% Prep observations
oba = vertcat(oba{:}); % concatenate subject obs

if oa.timeVar=="bin2"
    oba.bin2 = double(oba.frame)/logs.n{1}.hz;
    oba.bin2 = double(oba.latency)/oa.bin2;
    oba.bin2 = round(oba.bin2+eps(oba.bin2)) * oa.bin2 * 1000;
    t0 = double(min(oba.bin));
    t1 = double(max(oba.bin));
    oba.bin2(oba.bin2<t0) = t0;
    oba.bin2(oba.bin2>t1) = t1;
    oba = movevars(oba,"bin2",Before="bin");
end

% Rename timevar/condvar for simplicity
oba = renamevars(oba,[oa.timeVar o.p.condVar],["time" "cnd"]);

% If timeVar is latency, convert to milliseconds (if not already)
if oa.timeVar=="latency" && max(oba.time)<100
    oba.time = round(oba.time*1000);
end

% Split observations table
oba = splitapply(@(id) {oba(id,:)},(1:height(oba))',findgroups(oba.ch,oba.time));
splits = height(oba);

% Preallocate stats table
stat = cell(splits,1);
disp("Finished prep: toc="+toc(tt));


%% Analyze within splits
parfor s = 1:splits
    stat{s} = analyze_lfn(oba{s},oa,o);
end
disp("Ran analyses across splits: toc="+toc(tt));

% Concatenate
stat = vertcat(stat{:});


%% FDR
vs = string(stat.Properties.VariableNames);
vsQ = vs(endsWith(vs,"_q")); % fdr vars
vsP = replace(vsQ,"_q","_p"); % expected matching pval vars
id = stat.time>=o.fdrTimeRng(1) & stat.time<=o.fdrTimeRng(2); % fdr time range

% Verify every _q has a matching _p; drop (with warning) any that don't
hasP = ismember(vsP,vs);
if ~all(hasP)
    warning("Skipping FDR for _q vars without matching _p: %s",...
        strjoin(vsQ(~hasP),", "));
    vsQ = vsQ(hasP);
    vsP = vsP(hasP);
end

% Loop across q vars
for v = 1:numel(vsQ)
    % Loop across var columns -- KEEP THIS??
    for w = 1:width(stat.(vsQ(v)))
        % do FDR
        stat.(vsQ(v))(id,w) = ec_fdr(stat.(vsP(v))(id,w),...
            o.alpha,o.fdrDep);
    end
end
disp("Ran FDR: toc="+toc(tt));


%% Save
fn = o.analOut+oa.statFn;
save(fn,"stat","-v7");
disp("Saved classificiation statistics: "+fn+" toc="+toc(tt));




function sts = analyze_lfn(obs,oa,o)
%%% Within-split analyses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% obs=oba{1100}; obs=oba{514}; obs=oba{217};
nv = oa.nv;

% Initialize stats table
sts = table;
sts.roi = obs.ch(1);
sts.time = obs.time(1);
sts.acc = nan;
sts.acc_SE = nan;


%% Model performance

% Accuracy stats (exact binomial test)
[sts.acc,sts.acc_p,sts.acc_SE] = ec_binomTest(obs.acc(obs.use));
sts.acc_q = nan;

% Accuracy: Logistic mixed-effects
lme = fitglme(obs(obs.use,:),"acc ~ 1 + (1|sbjID:tr)",...
    Distribution="Binomial",Link="logit",FitMethod="REMPL");
sts.accl = 1/(1 + exp(-lme.Coefficients.Estimate)); % convert logit to probability
sts.accl_SE = lme.Coefficients.SE * sts.accl * (1 - sts.accl); % logit SE to probability via delta method
sts.accl_p = lme.Coefficients.pValue;
sts.accl_q = nan;

% % ROC
% rocm = rocmetrics(obs.y(obs.use),obs.pp(obs.use,:),o.p.cond);
% 
% % Precision-recall AUC
% sts.auc = rocm.auc("pr");  
% sts.auc1 = mean(sts.auc,"omitmissing");


%% Posterior probability

% PP of main conds (training set)
lme = fitlme(obs(obs.use,:),"pp1 ~ y-1"+nv+"(y-1|sbjID:tr)",...
    FitMethod="REML",DummyVarCoding="full",CovariancePattern="Diagonal");
for c = 1:numel(o.p.cond)
    id = lme.Coefficients.Name=="y_"+o.p.cond(c);
    sts.ppc(1,c) = lme.Coefficients.Estimate(id);
    sts.ppc_SE(1,c) = lme.Coefficients.SE(id);
    sts.ppc_p(1,c) = lme.Coefficients.pValue(id);
    sts.ppc_q(1,c) = nan;
end

% PP of cross-classification conds
if isany(o.p.condx)
    lme = fitlme(obs(obs.cc,:),"pp1 ~ cx-1"+nv+"(cx-1|sbjID:tr)",...
        FitMethod="REML",DummyVarCoding="full",CovariancePattern="Diagonal");
    for c = 1:numel(o.p.condx)
        id = lme.Coefficients.Name=="cx_"+o.p.condx(c);
        sts.ppxc(1,c) = lme.Coefficients.Estimate(id);
        sts.ppxc_SE(1,c) = lme.Coefficients.SE(id);
        sts.ppxc_p(1,c) = lme.Coefficients.pValue(id);
        sts.ppxc_q(1,c) = nan;
    end
end

% PP diff of main conds
lme = fitlme(obs(obs.use,:),"pp1 ~ y"+nv+"(1|sbjID:fold)",FitMethod="REML");
id = lme.Coefficients.Name=="y_"+o.p.cond(end);
sts.ppc1 = lme.Coefficients.Estimate(id);
sts.ppc1_SE = lme.Coefficients.SE(id);
sts.ppc1_p = lme.Coefficients.pValue(id);
sts.ppc1_q = nan;

% PP diff of CC conds
if isany(o.p.condx)
    lme = fitlme(obs(obs.cc,:),"pp1 ~ cx"+nv+"(1|sbjID:run)",FitMethod="REML");
    id = lme.Coefficients.Name=="cx_"+o.p.condx(end);
    sts.ppxc1 = lme.Coefficients.Estimate(id);
    sts.ppxc1_SE = lme.Coefficients.SE(id);
    sts.ppxc1_p = lme.Coefficients.pValue(id);
    sts.ppxc1_q = nan;
end


%% Regression on PP (autobio only)

% Autobio indices
ida = ismember(obs.cnd,["Autobio" "Semantic" "Episodic" "Ab"]);
if ~any(ida)
    ida = obs.use;
    warning("No autobio trials found for obs.time="+sts.time);
end

% Behavioral response time
lme = fitlme(obs(ida,:),"pp1 ~ RT"+nv+"(1|sbjID:fold)",FitMethod="REML");
id = lme.Coefficients.Name=="RT";
sts.ppr_RT = lme.Coefficients.Estimate(id);
sts.ppr_RT_SE = lme.Coefficients.SE(id);
sts.ppr_RT_p = lme.Coefficients.pValue(id);
sts.ppr_RT_q = nan;

% Behavioral response choice
lme = fitlme(obs(ida,:),"pp1 ~ resp"+nv+"(1|sbjID:fold)",FitMethod="REML");
id = contains(lme.Coefficients.Name,"resp");
sts.ppr_RC = lme.Coefficients.Estimate(id);
sts.ppr_RC_SE = lme.Coefficients.SE(id);
sts.ppr_RC_p = lme.Coefficients.pValue(id);
sts.ppr_RC_q = nan;


%% Regression on CC PP
if isany(o.p.condx)
    % Behavioral response time
    lme = fitlme(obs(obs.cc,:),"pp1 ~ RT"+nv+"(1|sbjID:run)",FitMethod="REML");
    id = lme.Coefficients.Name=="RT";
    sts.ppxr_RT = lme.Coefficients.Estimate(id);
    sts.ppxr_RT_SE = lme.Coefficients.SE(id);
    sts.ppxr_RT_p = lme.Coefficients.pValue(id);
    sts.ppxr_RT_q = nan;

    % Behavioral response choice
    lme = fitlme(obs(obs.cc,:),"pp1 ~ resp"+nv+"(1|sbjID:run)",FitMethod="REML");
    id = contains(lme.Coefficients.Name,"resp");
    sts.ppxr_RC = lme.Coefficients.Estimate(id);
    sts.ppxr_RC_SE = lme.Coefficients.SE(id);
    sts.ppxr_RC_p = lme.Coefficients.pValue(id);
    sts.ppxr_RC_q = nan;

    % Affective valence
    lme = fitlme(obs(obs.cc,:),"pp1 ~ valence"+nv+"(1|sbjID:run)",FitMethod="REML");
    id = lme.Coefficients.Name=="valence";
    sts.ppxr_val = lme.Coefficients.Estimate(id);
    sts.ppxr_val_SE = lme.Coefficients.SE(id);
    sts.ppxr_val_p = lme.Coefficients.pValue(id);
    sts.ppxr_val_q = nan;
end




function oba = lpf_lfn(oba,logs,oa,tt)
%%% Low-pass filter within subject/ROI/trial %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sampling rate from first non-empty subject metadata
fs = logs.n{1}.hz;

% Precompute symmetrical Gaussian kernel (LPF passband = oa.lpf)
sigma = sqrt(log(2)) / (2*pi*oa.lpf) * fs; % sigma in samples: -3dB at oa.lpf Hz
halfw = ceil(3*sigma); % kernel half-width (3-sigma truncation, ~1% of peak)
t = -halfw:halfw; % kernel length
k = exp(-(t.^2)/(2*sigma^2)); % symmetric Gaussian kernel
k = k/sum(k); % normalize kernel

%% LPF across subjects
parfor s = 1:numel(oba)
    % Extract group data
    ob = oba{s};
    ob = sortrows(ob,["ch" "tr" "frame"],"ascend"); % ensure temporal-ascending order

    % Convert posterior probability to FP64
    %ob = convertvars(ob,"pp1","double");

    % Indices of ROI-trial groups
    id = splitapply(@(idg) {idg},(1:height(ob))',findgroups(ob.ch,ob.tr));

    %% LPF each ROI-trial group
    for g = 1:numel(id)
        % Extract PP
        x = double(ob.pp1(id{g})); % convert to double
        N = numel(x);

        % Interpolate NaNs if any
        idn = isnan(x);
        if any(idn)
            x = fillmissing(x,"linear",1,EndValues="nearest");
        end

        % Symmetric padding for edges    
        x = padarray(x,halfw,"symmetric");
        M = floor((numel(x)-N)/2);

        %% LPF with zero-phase centered convolution w/ Gaussian kernel
        x = conv(x,k,"same");

        % Remove padding & restore NaNs
        x = x(M+1:M+N);
        x(idn) = nan;

        % Save to observations table
        ob.pp1(id{g}) = x;   
    end

    % Return group data
    oba{s} = ob;
end
disp("[mmr_cSpecAnal_ROI] LPF pp1: "+oa.lpf+" Hz (fs="+fs+" Hz) | toc="+toc(tt));
