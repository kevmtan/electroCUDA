function svc = ec_svmSpectral_trial(xc,Y,in,idl,bins)
arguments
    xc   (:,:) single
    Y    (:,1) single
    in   (:,1) logical
    idl  (:,:) logical
    bins (:,1) int16
end

% Organize
nBins = cast(numel(bins),like=bins);
b = nan(nBins,1,"single");
svc = table(bins,b,b,[b b],VariableNames={'latency','acu','p','cost'});

% Add kernelfun pragma to trigger kernel creation
coder.gpu.kernelfun; 

% Loop across latency bins
for l = 1:nBins
    coder.gpu.constantMemory(svc);  
    id = idl(:,l);
    coder.gpu.constantMemory(id);
    svc(l,:) = classifyLat_lfn(xc(id,:),Y(id),in(id),svc(l,:));
end



%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function svl = classifyLat_lfn(xl,Y,in,svl)
%% Classify within-latency 
if nnz(in)<20; return; end
%coder.extrinsic('fitcsvm')

% Train & optimize
svm = fitcsvm(xl(in,:),Y(in),KernelFunction='linear',KernelScale='auto'); %,...
    % OptimizeHyperparameters='auto',HyperparameterOptimizationOptions=...
    % struct(ShowPlots=0,Verbose=0,Repartition=0,KFold=5,...
    % AcquisitionFunctionName='expected-improvement-plus')); %MaxObjectiveEvaluations=30

% Cross-validate
svm = crossval(svm);

% Get cross-validation performance
[y,p,c] = kfoldPredict(svm);
svl.acu = nnz(y==Y(in))/numel(y);
svl.p = mean(abs(p(:,1)));
svl.cost = mean(c);