function [sts,obs] = mmr_classifySpecMetrics(sts,obs,o)

%% Regression on PP

% Behavioral response time
lm = fitlm(obs(obs.use,["pp1" "RT"]),"pp1 ~ RT");
sts.ppr_RT = lm.Coefficients.Estimate(2);
sts.ppr_RT_SE = lm.Coefficients.SE(2);
sts.ppr_RT_p = lm.Coefficients.pValue(2);

% Behavioral response choice
lm = fitlm(obs(obs.use,["pp1" "resp"]),"pp1 ~ resp");
sts.ppr_RC = lm.Coefficients.Estimate(2);
sts.ppr_RC_SE = lm.Coefficients.SE(2);
sts.ppr_RC_p = lm.Coefficients.pValue(2);


%% Regression on CC PP

if o.doCC
    % Behavioral response time
    lm = fitlm(obs(obs.cc,["pp1" "RT"]),"pp1 ~ RT");
    sts.ppxr_RT = lm.Coefficients.Estimate(2);
    sts.ppxr_RT_SE = lm.Coefficients.SE(2);
    sts.ppxr_RT_p = lm.Coefficients.pValue(2);

    % Behavioral response choice
    lm = fitlm(obs(obs.cc,["pp1" "resp"]),"pp1 ~ resp");
    sts.ppxr_RC = lm.Coefficients.Estimate(2);
    sts.ppxr_RC_SE = lm.Coefficients.SE(2);
    sts.ppxr_RC_p = lm.Coefficients.pValue(2);

    % Affective valence
    lm = fitlm(obs(obs.cc,["pp1" "valence"]),"pp1 ~ valence");
    sts.ppxr_val = lm.Coefficients.Estimate(2);
    sts.ppxr_val_SE = lm.Coefficients.SE(2);
    sts.ppxr_val_p = lm.Coefficients.pValue(2);
end