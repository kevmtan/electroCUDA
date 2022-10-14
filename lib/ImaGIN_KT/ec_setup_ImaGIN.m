saveDir = "/home/kt/Documents/MATLAB/";

% Load the train base
trainBase = load('ImaGIN_trainBaseFeatures_KT.mat');

%% Train the classifier
[mdl,validationAccuracy,validationPredictions,validationScores]...
    = ec_trainClassifier_ImaGIN(trainBase.predictors,trainBase.response);

%% Save results

save(saveDir+"ec_trainedClassifier_ImaGIN.mat",'mdl','-v7');

