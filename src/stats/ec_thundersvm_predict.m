function [yy,o] = ec_thundersvm_predict(x,y,o)
%% Matlab wrapper for thundersvm-train
%   Included with electroCUDA: github.com/kevmtan/electroCUDA
%   ThunderSVM: github.com/Xtra-Computing/thundersvm
%   y-values: class starting with 0 (e.g. y=[0 1] for binary classification)

arguments
    x (:,:) double = []                     % Predictor matrix: x(observation,feature)
    y (:,1) double = zeros(height(x),1)     % Label vector: y(observation,1)

    % ThunderSVM options (definitions: github.com/cjlin1/libsvm)
    o.mem (1,1) double = 0                  % Max memory in kb (-m)
    o.prob (1,1) double = 0                 % Do posterior probabilities (-b)
    o.gpu (1,1) uint8 = 0                   % Which GPU (-u)
    o.custom string = ""                    % Custom thundersvm-train arguments

    % Other options
    o.std (1,1) logical = false             % Z-score predictors
    o.data string = ""                      % Path of libsvm-formatted data
    o.mdl string = ""                       % Path of thundersvm model
    o.pred string = ""                      % Path of predictions
    o.binary string = ecu_paths().thundersvm % thundersvm-train executable
    o.rmData (1,1) logical = false          % Remove libsvm-formatted data from disk

    % Input output from "ec_thundersvm_train"
    o.svm {isempty,isstruct} = []
end
if isstruct(o.svm); o = o.svm; end

%% Main

% Construct command
cmd = o.binary+"thundersvm-predict";
if o.mem; cmd = cmd+" -m "+o.mem; end
if o.prob; cmd = cmd+" -b "+o.prob; end
if o.gpu; cmd = cmd+" -u "+o.gpu; end
if o.custom~=""; cmd = cmd+" "+o.custom; end

% Data filename
if o.data==""
    o.data = string(pwd) + filesep + "svm_" + round(rand(1,"single")*1e6); end
cmd = cmd+" "+o.data; % build system command

% Model filename
if o.mdl==""
    o.mdl = o.data+".model"; end
cmd = cmd+" "+o.mdl;

% Output model filename
if o.pred==""
    o.pred = o.data+".pred"; end
cmd = cmd+" "+o.pred;
o.cmd = cmd;

% Input data
if ~isempty(x)
    % Z-score predictors;
    if o.std
        x = normalize(x,1,"zscore");
    end

    % Save data to libsvm format
    libsvmwrite(char(o.data),y,sparse(x));
end

% Train
[o.fin,o.log] = system(cmd);

% Get predicted
yy = readmatrix(o.pred,FileType="text",NumHeaderLines=1);

% Delete data from disk
if o.rmData; delete(o.data); delete(o.mdl); delete(o.pred); end
% disp(o.log);

