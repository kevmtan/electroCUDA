function [o,stat,ob] = ec_classifySpec(o)
% Performs classification & cross-classification within channels/ICs/ROIs
% across time using spectral activity as features. ROI classificaiton
% concatenates timecourses from within-ROI channels. 
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2026
%
% OUTPUTS:
%   ob = classified observations
%   stat = classifier results & statistics per independent analysis
%       (chans/ICs/ROIs x timepoints) 

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" section)
end
% o.test = 1;


%% Prepare subject data
tt = tic; % start timer
[x,ep,n,o] = ec_prepAnalysis(o,tt); % analysis-specific preprocessing


%% Make classifier templates
[ob,stat] = ec_classifyTemplates(n,ep,o,tt);


%% Split variables so splits directly go into ec_runClassifier
[x,ob,stat,n] = ec_splitClassifyData(x,ob,stat,n,o,tt);


%% Classification
[ob,stat] = classify_lfn(x,ob,stat,n,o,tt);


%% Save
o.saved.stat = o.dirOut+"s"+n.sbjID+"_stat.mat";
save(o.saved.stat,"stat","-v7");
disp("[ec_classifyChSpec] Saved classificiation statistics: "+o.saved.stat+" toc="+toc(tt));
o.saved.ob = o.dirOut+"s"+n.sbjID+"_ob.mat";
save(o.saved.ob,"ob","-v7");
disp("[ec_classifyChSpec] Saved classificiation observations: "+o.saved.ob+" toc="+toc(tt));






%%%%%%%%%%%%%%%%%%%%%%%%%% Classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%% Initialize classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ob,stat] = classify_lfn(x,ob,stat,n,o,tt)
splits = numel(x);

%% Compute across data splits (chans/ICs/ROIs x timepoints)
if o.gpu
    for s = 1:splits
        [ob{s},stat(s,:)] = ec_runClassifier(x{s},ob{s},stat(s,:),o);
    end
else
    parfor s = 1:splits
        [ob{s},stat(s,:)] = ec_runClassifier(x{s},ob{s},stat(s,:),o);
    end
end
disp("[ec_classifyChSpec] Ran classifiers: "+n.sbj+" toc="+toc(tt));


%% Concactenate channel results
ob = vertcat(ob{:}); % sortrows(vertcat(ob{:}),["ch" "tr" "t"],"ascend");


%% FDR
vs = string(stat.Properties.VariableNames);
vsP = vs(contains(vs,"_p")); % pval vars
vsQ = vs(contains(vs,"_q")); % fdr vars
id = stat.t>=o.fdrTimeRng(1) & stat.t<=o.fdrTimeRng(2); % fdr time range

% Loop across q vars
for v = 1:numel(vsQ)
    % Loop across var columns -- KEEP THIS??
    for w = 1:width(stat.(vsQ(v)))
        % do FDR
        stat.(vsQ(v))(id,w) = ec_fdr(stat.(vsP(v))(id,w),...
            o.alpha,o.fdrDep);
    end
end
disp("[ec_classifyChSpec] Ran FDR: "+n.sbj+" toc="+toc(tt));


%% Finalize
% TO DO: convert float vars to output type

% Remove vars
stat = removevars(stat,["cost" "cv" "cvh"]);

% Rename vars
ob = renamevars(ob,["t" "cnd"],[o.timeVar o.condVar]);
stat = renamevars(stat,"t",o.timeVar);