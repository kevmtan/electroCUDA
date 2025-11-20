function o = ec_thundersvm_train(x,y,o)
%% Matlab wrapper for thundersvm-train
%   Included with electroCUDA: github.com/kevmtan/electroCUDA
%   ThunderSVM: github.com/Xtra-Computing/thundersvm
%   y-values: class starting with 0 (e.g. y=[0 1] for binary classification)

arguments
    x (:,:) double = []  % Predictor matrix: x(observation,feature)
    y (:,1) double = []  % Label vector: y(observation,1)

    % Hyperparameters (definitions: github.com/cjlin1/libsvm)
    o.type {mustBeMember(o.type,0:4)} = 0     % SVM type (-s)
    o.kernel {mustBeMember(o.kernel,0:3)} = 2 % kernel type (-t)
    o.kfold (1,1) uint32 = 0                  % Cross-validation folds (-v)
    o.degree (1,1) uint32 = 0                 % Polynomial degree (-d)
    o.gamma (1,1) double = 0                  % Gamma of kernel function (-g)
    o.cost (1,1) double = 0                   % Cost/boxconstraint (-c)
    o.nu (1,1) double = 0                     % Nu for nu-SVC/SVR (-n)
    o.epsilon (1,1) double = 0                % Epsilon for epsilon-SVR (-p)
    o.wi (1,:) double = [0 0]                 % Weights per class (-wi)
    o.mem (1,1) double = 0                    % Max memory in kb (-m)
    o.tol (1,1) double = 0                    % Termination tolerance (-e)
    o.prob (1,1) double = 0                   % Do posterior probabilities (-b)
    o.gpu (1,1) uint8 = 0                     % Which GPU (-u)
    o.custom string = ""                      % Custom thundersvm-train arguments

    % Other options
    o.ys (1,:) double = [0 1]                 % Class labels (integers starting at 0)
    o.std (1,1) logical = false               % Z-score predictors
    o.data string = ""                        % Path of libsvm-formatted data
    o.mdl string = ""                         % Path of thundersvm model
    o.pred string = ""                        % Path of predictions
    o.binary string = ecu_paths().thundersvm   % thundersvm-train executable
    o.rmData (1,1) logical = false            % Remove libsvm-formatted data from disk

    % Input output from "ec_thundersvm_train"
    o.svm {isempty,isstruct} = []
end
if isstruct(o.svm); o = o.svm; end


%% Main

% Construct command
cmd = o.binary+"thundersvm-train";
cmd = cmd+" -s "+o.type+" -t "+o.kernel;
if o.kfold; cmd = cmd+" -v "+o.kfold; end
if o.degree; cmd = cmd+" -d "+o.degree; end
if o.gamma; cmd = cmd+" -g "+o.gamma; end
if o.cost; cmd = cmd+" -c "+o.cost; end
if o.nu; cmd = cmd+" -n "+o.nu; end
if o.epsilon; cmd = cmd+" -p "+o.epsilon; end
for v = o.ys
    if o.wi(v+1); cmd=cmd+" -w"+v+" "+o.wi(v+1); end;end
if o.mem; cmd = cmd+" -m "+o.mem; end
if o.tol; cmd = cmd+" -e "+o.tol; end
if o.prob; cmd = cmd+" -b "+o.prob; end
if o.gpu; cmd = cmd+" -u "+o.gpu; end
if o.custom~=""; cmd = cmd+" "+o.custom; end
% if o.w0; cmd = cmd+" -w0 "+o.w0; end
% if o.w1; cmd = cmd+" -w1 "+o.w1; end

% Data filename
if o.data==""
    o.data = string(pwd) + filesep + "svm_" + round(rand(1,"single")*1e6); end
cmd = cmd+" "+o.data; % build system command

% Return model filename
if o.mdl==""
    o.mdl = o.data+".model"; end
cmd = cmd+" "+o.mdl;
o.cmd = cmd;

% Predict filename
if o.pred==""
    o.pred = o.data+".pred"; end

% Input data
if ~isempty(x) && ~isempty(y)
    % Z-score predictors
    if o.std
        x = normalize(x,1,"zscore");
    end

    % Save data to libsvm format
    libsvmwrite(char(o.data),y,sparse(x));
end

% Train
[o.fin,o.log] = system(cmd);

% Get cross-validated accuracy
if o.kfold
    o.acc = str2double(extractAfter(o.log,"Cross Accuracy = "));
end

% Delete data from disk
if o.rmData; delete(o.data); end
% disp(o.log);

