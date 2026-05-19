function [stat,obs] = mmr_cSpecAnal_ROI(oa)
arguments
    oa struct
end

%% Load
tt = tic; % start timer

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
fs = logs.n{1}.hz; % sampling rate

% Preallocate
obs = cell(nSbj,1); % observations from all sbjs

% Load observations across subjects
parfor s = 1:nSbj
    obs{s} = loadSbj_lfn(logs(s,:),o);
end
disp("Finished loading data: toc="+toc(tt));


%% LPF smoothing of posterior probability for analyses
if oa.lpf > 0
    % Compute kerrnel
    [k,halfw] = lpfKernel_lfn(oa.lpf,fs);

    % LPF across subjects
    parfor s = 1:numel(obs)
        obs{s} = lpfSbj_lfn(obs{s},k,halfw);
    end
    disp("[mmr_cSpecAnal_ROI] LPF pp1: "+oa.lpf+" Hz (fs="+fs+" Hz) | toc="+toc(tt));
end


%% Prep observations
obs = vertcat(obs{:}); % concatenate subject obs

% Nuisance var: nv includes surrounding "+" so formula is always "fixed"+nv+"(rand...)"
% e.g. oa.nv=["VD" "K_PCA1"] → nv1="+VD+K_PCA1+"; no oa.nv → nv="+"
if isany(oa.nv)
    oa.nv = oa.nv(ismember(oa.nv,obs.Properties.VariableNames)); % ensure existence
    oa.nv1 = "+"+join(string(oa.nv),"+")+"+";
else
    oa.nv1 = "+";
end

% Create new timebin
if oa.timeVar=="bin2" && any(oa.bin2)
    obs.bin2 = double(obs.frame)/logs.n{1}.hz;
    obs.bin2 = double(obs.latency)/oa.bin2;
    obs.bin2 = round(obs.bin2+eps(obs.bin2)) * oa.bin2 * 1000;
    t0 = double(min(obs.bin));
    t1 = double(max(obs.bin));
    obs.bin2(obs.bin2<t0) = t0;
    obs.bin2(obs.bin2>t1) = t1;
    obs = movevars(obs,"bin2",Before="bin");
end

% Rename timevar/condvar for simplicity
obs = renamevars(obs,[oa.timeVar o.p.condVar],["time" "cnd"]);

% If timeVar is latency, convert to milliseconds (if not already)
if oa.timeVar=="latency" && max(obs.time)<100
    obs.time = round(obs.time*1000);
end

% Split observations table
obs = splitapply(@(id) {obs(id,:)},(1:height(obs))',findgroups(obs.ch,obs.time));
splits = height(obs);

% Preallocate stats table
stat = cell(splits,1);
disp("Finished prep: toc="+toc(tt));


%% Analyze within splits
parfor s = 1:splits
    try
        stat{s} = analyze_lfn(obs{s},oa,o);
    catch ME
        fprintf(2,"Split %d failed:\n%s\n",s,getReport(ME));
    end
end

% Concatenate splits
stat = vertcat(stat{:});
disp("Ran analyses across splits: toc="+toc(tt));


%% LPF accuracy
if oa.lpfAcc > 0
    % Compute kernel
    [k,halfw] = lpfKernel_lfn(oa.lpfAcc,fs);

    % ROI indices
    id = splitapply(@(idg) {idg},(1:height(stat))',findgroups(stat.roi));

    % LPF each ROI
    for g = 1:numel(id)
        stat.acc(id{g}) = lpfGrp_lfn(stat.acc(id{g}),k,halfw);
        stat.accl(id{g}) = lpfGrp_lfn(stat.accl(id{g}),k,halfw);
    end
    disp("[mmr_cSpecAnal_ROI] LPF accuracy: "+oa.lpfAcc+"Hz | toc="+toc(tt));
end


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
disp("[mmr_cSpecAnal_ROI] Ran FDR | toc="+toc(tt));


%% Save
fn = o.analOut+oa.statFn;
save(fn,"stat","-v7");
disp("[mmr_cSpecAnal_ROI] Saved classificiation statistics: "+fn+" | toc="+toc(tt));




function st = analyze_lfn(ob,oa,o)
%%% Within-split analyses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  ob=obs{1100}; ob=obs{514}; ob=obs{217};

% Prep
nv = oa.nv1; % string for adding nuisance variables to LME equations
ob.cnd = string(ob.cnd);

% Behavioral condition variable for regression fixed/random effects:
% prefer 'Cond' (original behavioral condition) if present in the obs table;
% otherwise fall back to 'cnd' (classifier label, often pooled within autobio).
if ismember("Cond",string(ob.Properties.VariableNames))
    cv = "Cond";
else
    cv = "cnd";
end

% Autobio indices
ida = ismember(ob.cnd,["Autobio" "Semantic" "Episodic" "Ab"]);
if ~any(ida)
    ida = ob.use;
    warning("No autobio trials found for obs.time="+ob.time(1));
end

% Mentalizing indices
if isany(o.p.condx)
    idm = ismember(ob.cnd,["Self" "Other"]);
    if ~any(idm)
        idm = ob.cc;
        warning("No mentalizing trials found for obs.time="+ob.time(1));
    end
end

% Make regressor containing all training + CC classes
ob.y2 = string(ob.y);
if isany(o.p.condx)
    ob.y2(ob.cc) = string(ob.cx(ob.cc));
end
ob.y2 = categorical(ob.y2,[o.p.cond o.p.condx],Ordinal=true);

% Convert float variables to FP64
ob = convertvars(ob,varfun(@isfloat,ob,OutputFormat="uniform"),"double");

% Initialize stats table
st = table;
st.roi = ob.ch(1);
st.time = ob.time(1);
st.acc = nan;
st.acc_SE = nan;


%% Outlier detection
if any(oa.olThr)
    for c = unique(ob.cnd)'
        ob.pp1(ob.cnd==c) = filloutliers(ob.pp1(ob.cnd==c),oa.olFill,oa.olMethod,1,...
            ThresholdFactor=oa.olThr);
    end
end


%% Model performance

% Accuracy stats (exact binomial test)
[st.acc,st.acc_p,st.acc_SE] = ec_binomTest(ob.acc(ob.use));
st.acc_q = nan;

% Accuracy: Logistic mixed-effects
lme = fitglme(ob(ob.use,:),"acc ~ 1 + (1|sbjID:fold:y) + (1|sbjID:tr)",...
    Distribution="Binomial",Link="logit",FitMethod="REMPL");
st.accl = 1/(1 + exp(-lme.Coefficients.Estimate)); % convert logit to probability
st.accl_SE = lme.Coefficients.SE * st.accl * (1 - st.accl); % logit SE to probability via delta method
st.accl_p = lme.Coefficients.pValue;
st.accl_q = nan;

% % ROC
% rocm = rocmetrics(ob.y(ob.use),ob.pp(ob.use,:),o.p.cond);
% % Precision-recall AUC
% st.auc = rocm.auc("pr");
% st.auc1 = mean(st.auc,"omitmissing");


%% Posterior probability

% Fit full model: per-class PP means with class-specific random slopes per run
lme = fitlme(ob,"pp1 ~ y2-1"+nv+"(1|sbjID:run)+(1|sbjID:tr)",...
    FitMethod="REML",DummyVarCoding="full");

% Cache for contrasts
coefs = string(lme.Coefficients.Name);
beta = lme.Coefficients.Estimate;
V = lme.CoefficientCovariance;
nC = numel(coefs);

% Extract training classes
for c = 1:numel(o.p.cond)
    id = coefs=="y2_"+o.p.cond(c);
    st.ppc(1,c) = lme.Coefficients.Estimate(id);
    st.ppc_SE(1,c) = lme.Coefficients.SE(id);
    st.ppc_p(1,c) = lme.Coefficients.pValue(id);
    st.ppc_q(1,c) = nan;
end
% Extract cross-classification classes
for c = 1:numel(o.p.condx)
    id = coefs=="y2_"+o.p.condx(c);
    st.ppxc(1,c) = lme.Coefficients.Estimate(id);
    st.ppxc_SE(1,c) = lme.Coefficients.SE(id);
    st.ppxc_p(1,c) = lme.Coefficients.pValue(id);
    st.ppxc_q(1,c) = nan;
end

% Contrast: PP difference between training classes (last vs first)
H = zeros(1,nC);
H(coefs=="y2_"+o.p.cond(end)) = 1;
H(coefs=="y2_"+o.p.cond(1)) = -1;
st.ppc1 = H*beta;
st.ppc1_SE = sqrt(H*V*H');
st.ppc1_p = coefTest(lme,H);
st.ppc1_q = nan;

if isany(o.p.condx)
    % Contrast: mentalizing (pooled CC classes) vs. autobio (1 or more training classes)
    H = zeros(1,nC);
    idAb = ismember(coefs,"y2_"+["Autobio" "Semantic" "Episodic" "Ab"]);
    idCC = ismember(coefs,"y2_"+o.p.condx);
    H(idCC) =  1/sum(idCC);
    H(idAb) = -1/sum(idAb);
    st.ppc2 = H*beta;
    st.ppc2_SE = sqrt(H*V*H');
    st.ppc2_p = coefTest(lme,H);
    st.ppc2_q = nan;

    % Contrast: PP difference between cross-classification classes (last vs first)
    H = zeros(1,nC);
    H(coefs=="y2_"+o.p.condx(end)) = 1;
    H(coefs=="y2_"+o.p.condx(1)) = -1;
    st.ppxc1 = H*beta;
    st.ppxc1_SE = sqrt(H*V*H');
    st.ppxc1_p = coefTest(lme,H);
    st.ppxc1_q = nan;
end


%% Regression on training class PPs (autobio only)

% Behavioral response time
lme = fitlme(ob(ida,:),"pp1 ~ "+cv+"+RT"+nv+"(1|sbjID:run:"+cv+")",FitMethod="REML");
id = lme.Coefficients.Name=="RT";
st.ppr_RT = lme.Coefficients.Estimate(id);
st.ppr_RT_SE = lme.Coefficients.SE(id);
st.ppr_RT_p = lme.Coefficients.pValue(id);
st.ppr_RT_q = nan;

% Behavioral response choice
lme = fitlme(ob(ida,:),"pp1 ~ "+cv+"+resp"+nv+"(1|sbjID:run:"+cv+")",FitMethod="REML");
id = contains(lme.Coefficients.Name,"resp");
st.ppr_RC = lme.Coefficients.Estimate(id);
st.ppr_RC_SE = lme.Coefficients.SE(id);
st.ppr_RC_p = lme.Coefficients.pValue(id);
st.ppr_RC_q = nan;


%% Regression on CC PP
if isany(o.p.condx)
    % Behavioral response time
    lme = fitlme(ob(idm,:),"pp1 ~ "+cv+"+RT"+nv+"(1|sbjID:run:"+cv+")",FitMethod="REML");
    id = lme.Coefficients.Name=="RT";
    st.ppxr_RT = lme.Coefficients.Estimate(id);
    st.ppxr_RT_SE = lme.Coefficients.SE(id);
    st.ppxr_RT_p = lme.Coefficients.pValue(id);
    st.ppxr_RT_q = nan;

    % Behavioral response choice
    lme = fitlme(ob(idm,:),"pp1 ~ "+cv+"+resp"+nv+"(1|sbjID:run:"+cv+")",FitMethod="REML");
    id = contains(lme.Coefficients.Name,"resp");
    st.ppxr_RC = lme.Coefficients.Estimate(id);
    st.ppxr_RC_SE = lme.Coefficients.SE(id);
    st.ppxr_RC_p = lme.Coefficients.pValue(id);
    st.ppxr_RC_q = nan;

    % Affective valence
    lme = fitlme(ob(idm,:),"pp1 ~ "+cv+"+valence"+nv+"(1|sbjID:run:"+cv+")",FitMethod="REML");
    id = lme.Coefficients.Name=="valence";
    st.ppxr_val = lme.Coefficients.Estimate(id);
    st.ppxr_val_SE = lme.Coefficients.SE(id);
    st.ppxr_val_p = lme.Coefficients.pValue(id);
    st.ppxr_val_q = nan;
end




function ob = loadSbj_lfn(logS,o)
%%% Load subject observations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(logS.ob,"ob");

% Make ROIs ordinal categoricals in tables (ROIs in 'ch' var)
ob.ch = categorical(ob.ch,o.p.ROIs,Ordinal=true);




function [k,halfw] = lpfKernel_lfn(passband,fs)
%%% Precompute symmetrical Gaussian LPF kernel %%%%%%%%%%%%%%%%%%%%%%%%%%%%
sigma = sqrt(log(2)) / (2*pi*passband) * fs; % sigma in samples: -3dB at oa.lpf Hz
halfw = ceil(3*sigma); % kernel half-width (3-sigma truncation, ~1% of peak)
t = -halfw:halfw; % kernel length
k = exp(-(t.^2)/(2*sigma^2)); % symmetric Gaussian kernel
k = k/sum(k); % normalize kernel




function ob = lpfSbj_lfn(ob,k,halfw)
%%% LPF within-subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extract group data
ob = sortrows(ob,["ch" "tr" "frame"],"ascend"); % ensure temporal-ascending order

% Convert posterior probability to FP64
ob = convertvars(ob,"pp1","double");

% Indices of ROI-trial groups
id = splitapply(@(idg) {idg},(1:height(ob))',findgroups(ob.ch,ob.tr));

% LPF each ROI-trial group
for g = 1:numel(id)
    ob.pp1(id{g}) = lpfGrp_lfn(ob.pp1(id{g}),k,halfw);
end




function x = lpfGrp_lfn(x,k,halfw)
%%% LPF within-group %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = numel(x);

% Interpolate NaNs if any
idn = isnan(x);
if any(idn)
    x = fillmissing(x,"movmedian",halfw);
    x = fillmissing(x,"pchip");
end

% Symmetric padding for edges
x = padarray(x,halfw,"symmetric");
M = floor((numel(x)-N)/2);

% LPF with zero-phase centered convolution w/ Gaussian kernel
x = conv(x,k,"same");

% Remove padding & restore NaNs
x = x(M+1:M+N);
x(idn) = nan;