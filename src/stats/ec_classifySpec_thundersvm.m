function [rs,ra] = ec_classifySpec_thundersvm(dirs,o,oi)
arguments
    dirs struct = []
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    oi.ICA logical = false
    oi.sfx string = "s"
    oi.prep logical = true
    oi.svm logical = true
    oi.stats logical = true
    oi.plot logical = true
    oi.test logical = false
end
% oi.ICA=doICA; oi.sfx=sfx; oi.test=true;
try mkdir(o.dirOutSbj); catch;end
cd(o.dirOutSbj);

%% Prep
if oi.prep
    try parpool('threads'); catch;end

    % Run Prep
    [x,a,n,r0] = prep_lfn(dirs,o,oi);

    % Save prepped data if not continuing
    if ~oi.svm || ~oi.stats
        fn = o.dirOutSbj+"s"+n.sbjID+"_prep.mat";
        savefast(fn,'x','a','n','r0');
    end
end

%% SVM
if oi.svm
    if ~oi.prep
        % Load prepped data
        fn = o.dirOutSbj+"s"+o.sbjID+"_prep.mat";
        load(fn,'x','a','n','r0');
    end
    % try delete(gcp('nocreate')); catch;end
    % try parpool('Local12',4); catch;end

    %% Run SVM
    [rs,ra] = wrapper_lfn(x,a,n,r0,o);

    % Save results
    fn = o.dirOut+"s"+n.sbjID+"_svmSpectral_"+o.name+".mat";
    save(fn,"rs","ra","-v7.3");
end




%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [x,a,n,r0] = prep_lfn(dirs,o,oi)
%% Preprocess data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;

% Load
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(dirs,oi.sfx); toc
x = single(x);
n.suffix = oi.sfx;
if oi.ICA; n.ICA=1; else; n.ICA=0; end

% Initialize
conds = o.conds;
fs = n.fs;
trialNfo.condC = categorical(trialNfo.cond,conds);

% Add sampling rate info to 'o' struct
if o.hzTarget>0; o.fsTarg=o.hzTarget; else; o.fsTarg=fs; end

% Band indices
if any(o.freqIdx)
    n.freqs = n.freqs(o.freqIdx);
    x = x(:,:,o.freqIdx);
end
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.freqs(:) = {[]};
for i = 1:numel(o.bands)
    B.id(i,:) = n.freqs>o.bandsF(i,1) & n.freqs<=o.bandsF(i,2);
    B.freqs{i} = n.freqs(B.id(i,:));
end
B.Properties.RowNames = B.name;

% Order ICs like source channels
if oi.ICA
    [n.icNfo,idl] = sortrows(n.icNfo,"ic","ascend");
    x = x(:,idl,:);
    n.chNfo = n.icNfo;
    n.chNfo = renamevars(n.chNfo,["ic" "sbjIC"],["ch" "sbjCh"]);
else
    n.chNfo = chNfo;
end


%% Analysis template
ep = ec_epochMetadata(psy,trialNfo,n,o); toc

% Custom condition names
if isfield(o,"conds2") && isany(o.conds2)
    [~,ci] = max(ep.cond==o.conds,[],2);
    ep.cond = o.conds2(ci)';
end
if ~oi.test; ep.time=[]; else; ep1=ep; end %#ok<NASGU>


%% Baseline correction, filtering, downsampling
x = ec_baselineTrials(x,n,psy,ep,o); toc
if oi.test; x1=x; end %#ok<NASGU>


%% Organize data for classifier
if n.xChs>255; u0=zeros(1,"uint16"); else; u0=zeros(1,"uint8"); end
s0=nan(1,"single"); % i0=zeros(1,"int16");
n.chNfo.ch = cast(n.chNfo.ch,like=u0);

% Compact metadata
a = ep(:,unique(["cond" "trialA" "latency" o.t "pct" "stim" "RT"],"stable"));
a.RT = single(a.RT);
a.ch(:) = u0;
a.pred(:) = s0;
a.p(:) = s0;
a.p0(:) = s0;
a.p1(:) = s0;
a.in = ismember(a.cond,o.svm_cond); % Conditions to classify
a.inx = ismember(a.cond,o.svm_condx);
a.y(:) = s0;
[~,y] = max(a.cond(a.in)==o.svm_cond,[],2);
a.y(a.in) = y-1;
[~,y] = max(a.cond(a.inx)==o.svm_condx,[],2);
a.y(a.inx) = y-1;
a.sbjCh(:) = "";
a = movevars(a,["ch" "latency" o.t "pred" "p" "p1" "y"],"After","trialA");
if numel(o.svm_cond)==2
    a.y(isnan(a.y))=false; a.pred(isnan(a.pred))=false;
    a = convertvars(a,["y" "pred"],"logical");
end

% Only inlcude classifier conds
id = a.in | a.inx;
a = a(id,:);
x = x(id,:,:);

% Preallocate classifier results
vars = o.bayesopt.vars;
r0 = table;
r0.sbjID = n.sbjID;
r0.ch = u0;
r0.acc = s0;
r0.accCV = s0;
r0.p = s0;
r0.p_SD = s0;
r0.n = uint32(0);
r0.sbjCh = "";
r0.o = table(0,'VariableNames',vars(1));
r0.sbjCh = "";
for v = 1:numel(vars)
    r0.o.(vars(v)) = single(0); end



function [rs,ra] = wrapper_lfn(x,a,n,r0,o)
%% Classifier wrapper %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id = a.in | a.inx;
a = a(id,:);
x = x(id,:,:);
sbjChs = n.chNfo.sbjCh;

% Loop across timebins
rs = cell(n.xChs,1);
ra = rs;
for ch = 1:n.xChs
    [rs{ch},ra{ch}] = chan_lfn(x(:,ch,:),a,r0,o,ch,sbjChs(ch));
end

% Finalize
rs = vertcat(rs{:});
ra = vertcat(ra{:});
rs = sortrows(rs,["ch" o.t],"ascend");
ra = sortrows(ra,["ch" o.t],"ascend");
disp("[ec_svmSpectral] Finished classification: "+n.sbj+" t="+toc);



function [rs,ra] = chan_lfn(xc,ra,rs,o,ch,sbjCh)
%% Within-chan compute %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ch=104; xc=x(:,ch,:); ac=a; 
tic;
xc = squeeze(xc); 
ra.ch(:)=ch; ra.sbjCh(:)=sbjCh; rs.ch=ch; rs.sbjCh=sbjCh; 

% Add timing metrics as predictors for non-stationary classification
xc = [cast(ra.latency,like=xc) cast(ra.pct,like=xc) xc];

% Setup SVM
ax = nan(height(ra),3,"single");
fn = o.dirOutSbj+"svm.ch"+ch;
wi = o.svm.wi;
for v = 1:numel(wi)
        wi(v) = nnz(ra.y(ra.in)==v-1)/nnz(ra.y(ra.in)==0); end
if o.bayesopt_do
    svm = o.bayesopt;
    opt = true;
else
    svm = o.svm;
    opt = false;
end
svm.data = fn;
svm.std = o.svm_std;
svm.rmData = false;
svm.wi = wi;
svm.kfold = o.svm_kFold;
svm = namedargs2cell(svm);


%% Optimize/cross-validate
if opt
    % Optimize & cross-validate
    [rs.o,r] = ec_thundersvm_optimize(xc(ra.in,:),ra.y(ra.in),svm{:});
    rs.accCV = 1-r.MinObjective;
else
    % Cross-validate
    svm = ec_thundersvm_train(xc(ra.in,:),ra.y(ra.in),svm{:});
    rs.accCV = svm.acc;
end

% Set optimized hyperparameters
svm = o.svm;
svm.data = fn;
svm.std = o.svm_std;
svm.rmData = false;
svm.wi = wi;
if opt
    p = string(rs.o.Properties.VariableNames);
    for v = 1:numel(p)
        svm.(p(v)) = rs.o.(p(v)); end
end

%% Train
svm.kfold = 0;
svm = namedargs2cell(svm);
svm = ec_thundersvm_train(svm{:});

%% Classify
ax(ra.in,:) = ec_thundersvm_predict(svm=svm);

%% Cross-classify
svm.rmData = true;
ax(ra.inx,:) = ec_thundersvm_predict(xc(ra.inx,:),svm=svm);

%% Finalize
id = ra.in;
ra.y = logical(ra.y); % assumes BINARY classification !!!
ra.pred = logical(ax(:,1));
ra.p(ra.pred) = ax(ra.pred,2);
ra.p(~ra.pred) = ax(~ra.pred,3);
ra.p0 = ax(:,3);
ra.p1 = ax(:,2);
rs.acc = nnz(ra.y(id)==ra.pred(id))/nnz(id);
rs.p = mean(ra.p(id));
rs.p_SD = std(ra.p(id));
disp("[ec_svmSpectral] Classified "+sbjCh+" t="+toc+":");
disp(rs);






%%
% function [sc,ac] = classifyCh_lfn(xc,ac,tb,sc,o,ch,sbjCh)                       
% %% Classify latency bin per chan/IC  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ch=104; xc=x{61}(:,ch,:); ac=a{61}; oc=oSVM.o(ch,:); sc=s0;
% xc = squeeze(xc);
% sc.ch=ch; sc.sbjCh=sbjCh; ac.ch(:)=ch; ac.sbjCh(:)=sbjCh;
% if nnz(ac.in)<width(xc); return; end
% 
% % Prep
% ax = nan(height(ac),3,"single");
% fn = o.dirOutSbj+"svm_b"+tb.(o.t)+".ch"+ch;
% wi = o.svm.wi;
% for v = 1:numel(wi)
%         wi(v) = nnz(ac.y(ac.in)==v-1)/nnz(ac.y(ac.in)==0); end
% if o.bayesopt_do && tb.(o.t)>=0
%     svm = o.bayesopt;
%     opt = true;
% else
%     svm = o.svm;
%     opt = false;
% end
% svm.data = fn;
% svm.std = o.svm_std;
% svm.rmData = false;
% svm.wi = wi;
% svm.kfold = o.svm_kFold;
% svm = namedargs2cell(svm);
% 
% %% Optimize/cross-validate
% if opt
%     % Optimize & cross-validate
%     [sc.o,r] = ec_thundersvm_optimize(xc(ac.in),ac.y(ac.in),svm{:});
%     sc.accCV = 1-r.MinObjective;
% else
%     % Cross-validate
%     svm = ec_thundersvm_train(xc(ac.in),ac.y(ac.in),svm{:});
%     sc.accCV = svm.acc;
% end
% 
% % Set optimized hyperparameters
% svm = o.svm;
% svm.data = fn;
% svm.std = o.svm_std;
% svm.rmData = false;
% svm.wi = wi;
% if opt
%     p = string(sc.o.Properties.VariableNames);
%     for v = 1:numel(p)
%         svm.(p(v)) = sc.o.(p(v)); end
% end
% 
% %% Train
% svm.kfold = 0;
% svm = namedargs2cell(svm);
% svm = ec_thundersvm_train(svm{:});
% 
% %% Classify
% ax(ac.in,:) = ec_thundersvm_predict(svm=svm);
% 
% %% Cross-classify
% % svm.rmData = true;
% ax(ac.inx,:) = ec_thundersvm_predict(xc(ac.inx,:),svm=svm);
% 
% %% Finalize
% ac.y = logical(ac.y); % assumes BINARY classification !!!
% ac.pred = logical(ax(:,1));
% ac.p(ac.pred) = ax(ac.pred,2);
% ac.p(~ac.pred) = ax(~ac.pred,3);
% ac.p0 = ax(:,3);
% ac.p1 = ax(:,2);
% id = ac.in;
% sc.acc = nnz(ac.y(id)==ac.pred(id))/nnz(id);
% sc.p = mean(ac.p(id));
% sc.p_SD = std(ac.p(id));



%% Optimize hyperparameters per timebin & chan
% cd(o.dirOutSbj);
% oSVM = optimizeSVM_lfn(x,a,n,o);
% disp("[ec_svmSpectral] Optimized SVM hyperparameters: "+n.sbj+" t="+toc);
% function oSVM = optimizeSVM_lfn(xb,ab,n,o)
% %% Optimize hyperparameters across chans %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% idx = ab.in & ab.stim;
% ab = ab(idx,:);
% xb = xb(idx,:,:);
% sbjChs = n.chNfo.sbjCh;
% oSVM = cell(n.xChs,1);
% oB = o.bayesopt;
% oB.data = o.dirOutSbj+"svm_o.";
% tO = o.tO;
% doZ = o.svm_std;
% 
% % Parfor across chans
% if o.bayesopt_do
%     parfor ch = 1:n.xChs
%         ac = ab;
%         ac.x = squeeze(xb(:,ch,:));
%         oSVM{ch} = optimizeCh_lfn(ac,tO,oB,doZ,sbjChs(ch));
%     end
% else
%     for ch = 1:n.xChs
%         oc = table;
%         oc.o = table;
%         for v=1:numel(oB.vars)
%             oc.o.(oB.vars(v)) = 0; end
%         oSVM{ch} = oc;
%     end
% end
% oSVM = vertcat(oSVM{:});
%
%
%
% function oc = optimizeCh_lfn(ac,tO,oB,doZ,sbjCh)
% %% Optimize hyperparameters for highest-eigendistance bin in chan %%%%%%%%%
% tic;
% vars = oB.vars;
% 
% % Find bin with max Euclidian distance across classifier conds
% c0 = grpstats(ac(ac.y==0,:),tO,"mean",DataVars="x");
% c = grpstats(ac(ac.y==1,:),tO,"mean",DataVars="x");
% c0.d(:) = nan;
% for b = 1:height(c0)
%     c0.d(b) = pdist2(c0.(3)(b,:),c.(3)(b,:)); end
% [~,c] = max(c0.d);
% c0  = c0.(tO)(c);
% c = ac.(tO)==c0;
% 
% % Prep
% ac = ac(c,:);
% if doZ 
%     ac.x = normalize(ac.x,1,"zscore"); end % z-score
% oB.wi(1) = 1;
% for v = 2:numel(oB.wi)
%     oB.wi(v) = nnz(ac.y==v-1)/nnz(ac.y==0); end
% oB.data = oB.data+sbjCh;
% oB = namedargs2cell(oB);
% oc = table;
% oc.sbjCh = sbjCh;
% oc.(tO) = c0;
% 
% % Run optimization
% [oc.o,oc.r,oc.svm] = ec_thundersvm_optimize(ac.x,ac.y,oB{:});
% oc.err = oc.r.MinObjective;
% str = "[ec_svmSpectral] Optimized: "+sbjCh+" "+tO+"="+c0+" err="+oc.err+" ";
% for v = 1:numel(vars)
%     str = str+vars(v)+"="+"="+oc.o.(vars(v))+" "; end
% disp(str+"t="+toc);



%% Depreciated
% %% Optimize hyperparameters per chan
% oSVM = cell(nChs,1);
% parfor ch = 1:nChs
%     ac = an;
%     ac.x = squeeze(x(:,ch,:));
%     ac = ac(ac.in,:);
%     oSVM{ch} = optimizeSVM_lfn(ac,o,sbjChs(ch));
% end
% disp("[ec_svmSpectral] Optimized SVM hyperparameters: "+n.sbj+" t="+toc);
% 
% 
% %% Classify latency bins per chan
% an = cellfun(@(i) an(i,:), t.i,UniformOutput=false); % Reshape metadata by latency
% x = cellfun(@(i) x(i,:,:), t.i,UniformOutput=false); % Reshape EEG data by latency
% sv = cell(nBins,1);
% av = sv;
% 
% % Parfor across chans
% parfor b = 1:nBins % ch=104; tc=t; svc=sv0;
%     [sv{b},av{b}] = classifyLatency_lfn(x{b},an{b},t(b,:),n,o,oSVM,sv0); 
% end
% disp("[ec_svmSpectral] Finished SVM: "+n.sbj+" t="+toc);

% function oCh = optimizeSVM_lfn(ac,o,sbjCh)                       
% %% Classify latency bin per chan/IC  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic;
% 
% % Get bin2 with max euclidian distance between cond0 & cond1
% c0 = grpstats(ac(ac.y==0 & ac.stim,:),o.tO,"median",DataVars="x");
% c1 = grpstats(ac(ac.y==1 & ac.stim,:),o.tO,"median",DataVars="x");
% c0.d = pdist2(c0.median_x,c1.median_x,"euclidean",Largest=1)';
% [~,c1] = max(c0.d);
% c1 = ac.(o.tO)==c0.(o.tO)(c1);
% 
% if o.gpu
%     ac.x = gpuArray(ac.x);
%     ac.y = gpuArray(ac.y);
% end
% 
% % Train & optimize
% svm = fitcsvm(ac.x(c1,:),ac.y(c1),o.svmOpt{:}); 
% 
% % Save optimized hyperparameters
% oCh = o.fitcsvm;
% opt = svm.HyperparameterOptimizationResults.XAtMinEstimatedObjective;
% for h = 1:width(opt)
%     oCh = horzcat(oCh,{opt.Properties.VariableNames{h},opt.(h)}); %#ok<AGROW>
% end
% disp("[ec_svmSpectral] Optimized SVM hyperparameters: "+sbjCh+" t="+toc);

% function [svb,ab] = classifyLatency_lfn(xb,ab,tb,n,o,oSVM,svb)                       
% %% Compute per latency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic;
% svb.(o.t) = tb.(o.t);
% 
% % Move data to GPU
% if o.gpu
%     xb = gpuArray(xb);
%     ab = convertvars(ab,@(v) isnumeric(v)|islogical(v),'gpuArray');
% end
% 
% % Reshape data by chan
% xb = num2cell(xb,[1 3])';
% 
% %% Compute across chans/ICs (vectorized)
% [svb,ab] = arrayfun(@(xc,oc,ch) classifyCh_lfn(xc{:},ab,svb,o,oc{:},ch),...
%     xb,oSVM,n.chNfo.ch,UniformOutput=false);
% svb = vertcat(svb{:});
% ab = vertcat(ab{:});
% disp("[ec_svmSpectral] Finished classification: bin="+tb.(o.t)+"  sbj="+n.sbj+"  t="+toc);

% function [svc,ac] = classifyCh_lfn(xc,ac,svc,o,oc,ch)                       
% %% Classify latency bin per chan/IC  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ch=104; xc=xb{ch}; ac=ab; svc=svb; oc=oSVM{ch};
% in=ac.in; inx=ac.inx; nObs=nnz(in); svc.ch=ch; ac.ch(:)=ch;
% if nObs<width(xc); return; end
% 
% % Train
% svm = fitcsvm(xc(in,:),ac.y(in),oc{:});
% % svm = svm.discardSupportVectors;
% 
% % Predict
% [y,p] = predict(svm,xc(inx,:));
% ac.pred(inx)=y; ac.p(inx)=p(:,1);
% 
% % Cross-validate
% svm = crossval(svm,o.crossval{:});
% 
% % Assess performance
% [y,p] = kfoldPredict(svm);
% svc.acc = nnz(y==ac.y(in))/nnz(in);
% svc.acc_SD = mad(y,0,1);
% svc.p = median(abs(p(:,1)));
% svc.p_SD = mad(abs(p(:,1)),1,1);
% svc.n = nObs;
% ac.pred(in)=y; ac.p(in)=p(:,1);
