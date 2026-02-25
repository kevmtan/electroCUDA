function oh = ec_extractHyperparams(mdl,o)
% Extract hyperparameters from classifier model

oh = o.hyper;

% Loop across hyperparameters
for p = 1:numel(o.OptimizeHyperparameters)
    param = o.OptimizeHyperparameters(p); % parameter name
    oh.(param) = mdl.(param); % extract parameter   
    if param=="Regularization" % handle special case for Regularization
        oh.(param) = extractBefore(oh.(param)," "); end
end