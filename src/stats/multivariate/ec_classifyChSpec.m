function [rt,ra] = ec_classifyChSpec(o)
% Performs timeseries statistics contrasting two task conditions within
% channels
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" section)
end
% o.test = 1;


%% Preprocessing
[x,a,t,n,tt] = prep_lfn(o);


%% Classification% Run SVM
[rt,ra] = classify_lfn(x,a,t,n,o,tt);




%%%%%%%%%%%%%%%%%%%%%%%%%% Preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [x,a,t,n] = prep_lfn(o)
%% Load data
tt = tic;
if o.test; disp("[ec_classifyChSpec] TESTING: "+o.dirs.sbj); end

% Load
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if o.test && numel(dbstack)<2; nOg=n; xOg=x; trialNfoOg=trialNfo; end %#ok<NASGU> % Copy origs for testing
disp("[ec_classifyChSpec] Loaded data: "+o.dirs.sbj+" | t="+toc(tt));

% Channel/IC info
if o.ICA
    chNfo = n.icNfo;
    chNfo = renamevars(chNfo,["ic" "sbjIC"],["ch" "sbjCh"]);
    chBad = find(any(n.icBad{:,o.chBadFields},2)); % ICs to include in stats
else
    chBad = find(any(n.chBad{:,o.chBadFields},2)); % chans to include in stats
end

% Remove bad chans/ICs
x(:,chBad,:) = [];
chNfo(chBad,:) = [];


%% Analysis template

% Epoch psych/behav task data
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,tt,oo{:}); %#ok<ASGLU>
ep.Properties.RowNames = {};

% Rename time variable
ep = renamevars(ep,o.timeVar,"t");

% Remove excluded times
ep(ep.t<o.timeRng(1) | ep.t>o.timeRng(2),:) = [];
ep.ide = cast(1:height(ep),like=ep.ide)'; % new epoch indices


%% Analysis-specific EEG preprocessing
oo = namedargs2cell(o.pre);
[x,n] = ec_epochBaseline(x,n,psy,ep,tt,oo{:},test=o.test);
o.n = n;
o.spect = n.spect;


%% Organize data for classifier
u0 = cast(0,like=chNfo.ch); % channel integer type
s0 = cast(nan,o.typeOut);

% Compact metadata
a = ep(:,unique(["cond" "trialA" "latency" o.t "pct" "frame" "bin" "bin2" "RT" "RTog" "stim" "condC"],"stable"));
a.sbjCh(:) = "";
a.y = categorical(a.cond,o.class.cond,Ordinal=true);
a.pred(:) = categorical("",o.class.cond,Ordinal=true);
a.ppd(:) = s0;
a.ppa(:) = s0;
a.pp(:,1:numel(o.class.cond)) = s0;
a.acc(:) = false;
a.in = ismember(a.cond,o.class.cond); % Conditions to classify
a.inx = ismember(a.cond,o.class.condx);
a.ch(:) = u0;
a.sbjID(:) = n.sbjID;
a = movevars(a,unique(["sbjCh" "trialA" "latency" o.t "cond" "y" "pred" "ppd" "ppa" "pp"...
    "acc" "in" "inx"],"stable"),"After",1);

% Only inlcude classifier conds
id = a.in | a.inx;
a = a(id,:);
x = x(id,:,:);

% Preallocate timebin classifier results
t = groupcounts(a,o.t);
t.sbjCh(:) = "";
t.acc(:) = s0;
t.acc_p(:) = s0;
t.acc_h(:) = false;
t.pp(:) = s0;
t.pp_SD(:) = s0;
t.pp_p(:) = s0;
t.pp_h(:) = false;
t.ppr = t.pp;
t.ppr_SD = t.pp;
t.n(:,1:2) = s0;
t.wt(:,1:numel(o.class.cond)) = double(0);
t.accCV(:,1:o.crossval.KFold) = s0;
t.sbjID(:) = n.sbjID;
t.ch(:) = u0;
t = movevars(t,"sbjCh",Before=o.t);
t = movevars(t,["GroupCount" "Percent"],Before="accCV");

% Missclassification cost (account for unbalanced classes)
for b = 1:height(t)
    t.n(b,1) = nnz(a.(o.t)==t.(o.t)(b) & a.cond==o.class.cond(1));
    t.n(b,2) = nnz(a.(o.t)==t.(o.t)(b) & a.cond==o.class.cond(2));
end
t.wt = double(t.n);
t.wt = flip(t.wt ./ mean(t.wt,2), 2);

% Add weights to 'a'
for b = 1:height(t)
    ii = a.(o.t)==t.(o.t)(b) & a.cond==o.class.cond(1);
    a.wt(ii) = t.wt(b,1);
    ii = a.(o.t)==t.(o.t)(b) & a.cond==o.class.cond(2);
    a.wt(ii) = t.wt(b,2);
end
a.wt = single(a.wt);


% %% Save prepped data
% if o.savePrep || ~o.classify || ~o.stats
%     fn = o.dirOutSbj+"s"+n.sbjID+"_x.mat";    savefast(fn,'x');
%     disp("[ec_classifyChSpec] Saved prepped data: "+fn+" t="+toc(tt));
%     fn = o.dirOutSbj+"s"+n.sbjID+"_prep.mat"; save(fn,"a","t","n","ep","psy","trialNfo","-v7");
%     disp("[ec_classifyChSpec] Saved prepped data: "+fn+" t="+toc(tt));
% end






%%%%%%%%%%%%%%%%%%%%%%%%%% Classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% Call classification functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rt,ra] = classify_lfn(x,a,t,n,o,tt)
chs = n.chNfo.ch;
sbjChs = n.chNfo.sbjCh;
if o.test && numel(dbstack)<2; x1=x; a1=a; t1=t; end %#ok<NASGU> % Copy unshaped for testing

% Reshape data by timebins
x = arrayfun(@(b) x(a.(o.t)==b,:,:), t.(o.t), UniformOutput=false);
a = arrayfun(@(b) a(a.(o.t)==b,:), t.(o.t), UniformOutput=false);
t = arrayfun(@(b) t(t.(o.t)==b,:), t.(o.t), UniformOutput=false);

% Preallocate
rt = cell(height(t),1);
ra = rt;

%% Compute per timebin
if o.gpu
    for b = 1:height(t)
        [rt{b},ra{b}] = classifyBin_lfn(x{b},a{b},t{b},chs,sbjChs,o);
    end
else
    parfor b = 1:height(t)
        [rt{b},ra{b}] = classifyBin_lfn(x{b},a{b},t{b},chs,sbjChs,o);
    end
end


%% Finalize
rt = sortrows(vertcat(rt{:}),["ch" o.t],"ascend");
ra = sortrows(vertcat(ra{:}),["condC" "ch" o.t "latency" "trialA"],"ascend");

% Save
fn = o.dirOut+"s"+n.sbjID+"_classifySpec_"+o.name+".mat";
save(fn,"rt","ra","o","-v7");
disp("[ec_classifyChSpec] Saved classificiation results: "+fn+" t="+toc(tt));






% Compute within timebin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rt,ra] = classifyBin_lfn(xb,ab,tb,chs,sbjChs,o,tt)
% b=60; xb=x{b}; ab=a{b}; tb=t{b};
nChs = numel(chs); rt=cell(nChs,1); ra=rt; tic;

% % Missclassification cost (account for unbalanced classes)
% tb.n(1,1) = nnz(ab.cond=="Semantic");
% tb.n(1,2) = nnz(ab.cond=="Episodic");
% tb.wt(1,1) = tb.n(1,2) / tb.n(1,1); 
% tb.wt(1,2) = tb.n(1,1) / tb.n(1,2);
% %[~,id]=min(tb.wt); tb.wt(1,id)=1;

% Loop across channels/ICs
for ch = cast(1:nChs,like=xb)
    [rt{ch},ra{ch}] = classifyCh_lfn(xb(:,ch,:),ab,tb,o,chs(ch),sbjChs(ch));
    if ~rem(ch,20)
        disp("[ec_classifyChSpec] Ran "+o.class.fun+" "+sbjChs(ch)+" "+o.t+"="+tb.(o.t)+" t="+toc(tt));
    end
end

% Finalize
rt = vertcat(rt{:});
ra = vertcat(ra{:});
if o.gpu
    rt = ec_varfun(@gather,rt);
    ra = ec_varfun(@gather,ra);
end
disp("[ec_classifyChSpec] Finished "+o.class.fun+" classifier: s"+o.sbjID+" "+o.t+"="+tb.(o.t)+" t="+toc(tt));




function [tc,ac] = classifyCh_lfn(xc,ac,tc,o,ch,sbjCh)
%% Compute within channel/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% c=104; xc=xb(:,c,:); ac=ab; tc=tb; ch=chs(c); sbjCh=sbjChs(c);
xc = squeeze(xc);
tc.ch=ch; tc.sbjCh=sbjCh; ac.ch(:)=ch; ac.sbjCh(:)=sbjCh;

% Outlier detection (all data)
xc = filloutliers(xc,nan,o.class.ol,1,ThresholdFactor=o.class.olThrAll);

% Outlier detection (within-condition)
for c = unique(ac.condC)'
    id = ac.condC==c;
    xc(id,:) = filloutliers(xc(id,:),o.class.olFill,o.class.ol,1,ThresholdFactor=o.class.olThrCond);
end

% Interpolate missing data
xc = fillmissing(xc,"linear",1);

% PCA
if o.class.pca
    [~,xc] = pca(xc,NumComponents=o.class.pca,Economy=false);
end

% Standardize data
if o.class.std
    xc = normalize(xc,1,"zscore");
end 

% Run classifier algorithm
if o.class.fun=="fitclinear"
    [tc,ac] = fitclinear_lfn(xc,ac,tc,o);
elseif o.class.fun=="fitcknn"
    [tc,ac] = fitcknn_lfn(xc,ac,tc,o);
end

% Calculate classifier metrics
id = ac.in;
ac.acc = ac.pred==ac.y;
ac.ppd = diff(ac.pp,1,2);
ac.ppa = abs(ac.ppd);
tc.acc = mean(ac.acc(id),1,"omitmissing");
tc.pp = mean(ac.ppa(id),1,"omitmissing");
tc.pp_SD = std(ac.ppa(id),1,1,"omitmissing");
id = ac.inx;
tc.ppr = mean(ac.ppa(id),1,"omitmissing");
tc.ppr_SD = std(ac.ppa(id),1,1,"omitmissing");




function [tc,ac] = fitclinear_lfn(xc,ac,tc,o)
%% Run fitclinear %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if all(~ac.stim); o.bayes.OptimizeHyperparameters="none"; o.hyper.PostFitBias=false; end

% Train & optimize
id = ac.in;
oo = namedargs2cell(o.hyper);
mdl = fitclinear(xc(id,:),ac.y(id),oo{:},'OptimizeHyperparameters',o.bayes.OptimizeHyperparameters,...
    'HyperparameterOptimizationOptions',o.bayes.HyperparameterOptimizationOptions); %,'Cost',[0 tc.wt(2); tc.wt(1) 0]);
if o.bayes.OptimizeHyperparameters~="none"
    o.hyper.Lambda = mdl.Lambda;
    o.hyper.Learner = mdl.Learner;
    o.hyper.Regularization = extractBefore(mdl.Regularization," ");
end

% Cross-classify
id = ac.inx;
[ac.pred(id),ac.pp(id,:)] = mdl.predict(xc(id,:));

% Cross-validate
id = ac.in;
oo = horzcat(namedargs2cell(o.hyper),namedargs2cell(o.crossval));
mdl = fitclinear(xc(id,:),ac.y(id),oo{:});
[ac.pred(id),ac.pp(id,:)] = mdl.kfoldPredict;
tc.accCV(1,:) = 1-mdl.kfoldLoss(Mode="individual")';




function [tc,ac] = fitcknn_lfn(xc,ac,tc,o)
%% Run fitcknn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Train & optimize
id = ac.in;
oo = namedargs2cell(o.hyper);
mdl = fitcknn(xc(id,:),ac.y(id),oo{:},'OptimizeHyperparameters',o.bayes.OptimizeHyperparameters,...
    'HyperparameterOptimizationOptions',o.bayes.HyperparameterOptimizationOptions);

% Cross-classify
id = ac.inx;
[ac.pred(id),ac.pp(id,:)] = mdl.predict(xc(id,:));

% Cross-validate
id = ac.in;
oo = namedargs2cell(o.crossval);
mdl = mdl.crossval(oo{:});
[ac.pred(id),ac.pp(id,:)] = mdl.kfoldPredict;
tc.accCV(1,:) = 1-mdl.kfoldLoss(Mode="individual");

