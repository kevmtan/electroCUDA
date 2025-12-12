function [z,r,o] = ec_thundersvm_optimize(x,y,o)
%% Hyperparameter optimization for ThunderSVM
%   Included with electroCUDA: github.com/kevmtan/electroCUDA
%   ThunderSVM: github.com/Xtra-Computing/thundersvm
%   y-values: class starting with 0 (e.g. y=[0 1] for binary classification)

arguments
    x (:,:) double = []  % Predictor matrix: x(observation,feature)
    y (:,1) double = []  % Label vector: y(observation,1)

    % Hyperparameters (defined here: github.com/cjlin1/libsvm)
    o.type {mustBeMember(o.type,0:4)} = 0     % SVM type (-s)
    o.kernel {mustBeMember(o.kernel,0:3)} = 2 % kernel type (-t)
    o.kfold (1,1) uint32 = 5                  % Cross-validation folds (-v)
    o.degree (1,1) uint32 = 0                 % Polynomial degree (-d)
    o.gamma (1,1) double = 0                  % Gamma of kernel function (-g)
    o.cost (1,1) double = 0                   % Cost/boxconstraint (-c)
    o.nu (1,1) double = 0                     % Nu for nu-SVC/SVR (-n)
    o.epsilon (1,1) double = 0                % Epsilon for epsilon-SVR (-p)
    o.wi (1,:) double = [0 0]                 % Weights per class (-wi)
    o.mem (1,1) double = 0                    % Max memory in kb (-m)
    o.tol (1,1) double = 0                    % Termination tolerance (-e)
    o.prob (1,1) logical = false              % Do posterior probabilities (-b)
    o.gpu (1,1) uint8 = 0                     % Which GPU (-u)
    o.custom string = ""                      % Custom thundersvm-train arguments

    % Options for bayesopt (mathworks.com/help/stats/bayesopt.html)
    o.vars string = "cost"
    o.varsRng (:,:) double = [1e-2 1e3]
    o.varsInit (:,:) double = [];
    o.deterministic (1,1) logical = true         % Deterministic or stochastic objective?
    o.acFun string = "expected-improvement-plus" % Acquisition function
    o.maxEvals (1,1) double = 30
    o.verbose (1,1) double = 1
    o.plot = {@plotObjectiveModel,@plotMinObjective};
    o.parallel (1,1) logical = false

    % Other options
    o.ys (1,:) double = [0 1]      % Class labels (integers starting at 0)
    o.std (1,1) logical = false    % Z-score predictors
    o.data string = ""             % Path of existing libsvm-formatted data
    o.mdl string = ""              % Path of existing thundersvm model
    o.binary string = ecu_paths().thundersvm + "thundersvm-train" % thundersvm-train executable
    o.rmData (1,1) logical = false % Remove libsvm-formatted data from disk
end

%% Prep

% Construct command
o.cmd = o.binary+"thundersvm-train -s "+o.type+" -t "+o.kernel;

% Data filename
if o.data==""
    o.data = string(pwd) + filesep + "svm_" + round(rand(1,"single")*1e6);
end

% Input data
if ~isempty(x) && ~isempty(y)
    % Z-score predictors
    if o.std
        x = normalize(x,1,"zscore");
    end

    % Save data to libsvm format
    libsvmwrite(char(o.data),y,sparse(x));
end

% Parameters to optimize
vars = o.vars;
v = optimizableVariable(vars(1),o.varsRng(1,:),"Transform","log");
for p = 2:numel(vars)
    v = [v,optimizableVariable(vars(p),o.varsRng(p,:),"Transform","log")]; end %#ok<AGROW>

% Objective function
minfn = @(z) train_lfn(o,z);

% Initial values
if ~isempty(o.varsInit)
    init = table;
    for p = 1:numel(vars)
        init.(vars(p)) = o.varsInit(p,:)'; end
else
    init = [];
end

%% Optimize
r = bayesopt(minfn,v,IsObjectiveDeterministic=o.deterministic,...
    AcquisitionFunctionName=o.acFun,MaxObjectiveEvaluations=o.maxEvals,...
    UseParallel=o.parallel,Verbose=o.verbose,PlotFcn=o.plot,InitialX=init);
z = r.XAtMinObjective;

%% Finalize
if o.rmData; delete(o.data); end % Delete data from disk




%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function loss = train_lfn(oi,z)
%% Training function
cmd = oi.cmd;
for vi = 1:numel(oi.vars)
    oi.(oi.vars(vi)) = z.(oi.vars(vi)); end

% Construct command
if oi.kfold; cmd = cmd+" -v "+oi.kfold; end
if oi.degree; cmd = cmd+" -d "+oi.degree; end
if oi.gamma; cmd = cmd+" -g "+oi.gamma; end
if oi.cost; cmd = cmd+" -c "+oi.cost; end
if oi.nu; cmd = cmd+" -n "+oi.nu; end
if oi.epsilon; cmd = cmd+" -p "+oi.epsilon; end
for p = oi.ys
    if oi.wi(p+1); cmd=cmd+" -w"+p+" "+oi.wi(p+1); end;end
if oi.mem; cmd = cmd+" -m "+oi.mem; end
if oi.tol; cmd = cmd+" -e "+oi.tol; end
if oi.prob; cmd = cmd+" -b "+oi.prob; end
if oi.gpu; cmd = cmd+" -u "+oi.gpu; end
if oi.custom~=""; cmd = cmd+" "+oi.custom; end
cmd = cmd+" "+oi.data; % build system command

% Train
[~,msg] = system(cmd);

% Calculate k-fold loss
loss = 1-str2double(extractAfter(msg,"Cross Accuracy = "));
%disp(cmd);
