function [rt,ra] = ec_classifySpec(o)
arguments
    % Basic info
    o.dirs struct = []
    o.sbj = [];
    o.sbjID = [];
    o.proj string = [];
    o.task string = [];
    o.ICA (1,1) logical = false
    o.dsTarg = []; % Downsampling target
    o.sfx string = ""
    o.name string = string(datetime('now','Format','yyMMdd'));

    % Runtime options
    o.gpu = false; % use GPU 
    o.prep (1,1) logical = true
    o.classify (1,1) logical = true
    o.stats (1,1) logical = true
    o.figures (1,1) logical = true
    o.savePrep (1,1) logical = true;
    o.save = true; % save summary stats data
    o.test (1,1) logical = false;

    % Frequency bands
    o.freqIdx {islogical,isnumeric} = []; % Indices of frequencies to keep: x(:,:,freqIdx)
    o.bands (1,:) string = []; % Band name
    o.bands2 (1,:) string = []; % Band display name
    o.bandLims (:,2) double = []; % Band limits

    % Task conditions (list by nominal order)
    o.conds (1,:) string = [];
    o.conds2 (1,:) string = []; % must match order of 'o.conds'

    % Classifier temporal binning variable (classify within timebin per channel/IC)
    o.t {mustBeMember(o.t,["latency" "bin" "bin2" "pct" "pct2"])} = "pct"

    % Classifier basic options
    o.class {isstruct,iscell} = []
    
    % Classifier hyperparameters (input args for function in 'o.class.fun')
    o.hyper {isstruct,iscell} = []

    % Cross-validation parameters (mathworks.com/help/stats/crossval.html)
    o.crossval {isstruct,iscell} = []

    % Optimize hyperparameters (mathworks.com/help/stats/bayesopt.html)
    o.bayes {isstruct,iscell} = []

    % Epoching (see 'ec_epochPsy')
    o.epoch {isstruct,iscell} = []

    % Preprocessing (see 'ec_epochBaseline')
    o.pre {isstruct,iscell} = []

    % Plot options
    o.plotType string = ""
    o.plot {isstruct,iscell} = []
end

%% Initialize
% o.prep=1; o.classify=1; o.stats=1; o.plot=1; o.test=1; 
o.dirIn = o.dirs.procSbj; %
o.dirFS = o.dirs.fsSbj; % Freesurfer subjects dir
o.dirOut = o.dirs.anal+"classifySpec"+filesep+o.name+filesep;
o.dirOutSbj = o.dirOut+"s"+o.dirs.sbjID+filesep;
mkdir(o.dirOutSbj);
cd(o.dirOutSbj);


%% Preprocessing
if o.prep
    [x,a,t,n] = prep_lfn(o);
end


%% Classification
if o.classify
    % Load prepped data
    if ~exist("x","var")
        fn = o.dirOutSbj+"s"+n.sbjID+"_x.mat";
        load(fn,"x");
    end
    if ~exist("a","var") || ~exist("t","var") || ~exist("n","var")
        fn = o.dirOutSbj+"s"+o.sbjID+"_prep.mat";
        load(fn,"a","t","n");
    end

    % Run SVM
    [rt,ra] = classify_lfn(x,a,t,n,o);
end




%%%%%%%%%%%%%%%%%%%%%%%%%% Preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [x,a,t,n] = prep_lfn(o)
%% Preprocess data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;

% Load
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,o.sfx); toc
n.suffix = o.sfx;
if o.ICA; n.ICA=1; else; n.ICA=0; end

% Initialize
n.xBad = [];
fs = n.fs;

% Add sampling rate info to 'o' struct
if o.dsTarg>0; o.fsTarg=o.dsTarg; else; o.fsTarg=fs; end

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
    B.id(i,:) = n.freqs>o.bandLims(i,1) & n.freqs<=o.bandLims(i,2);
    B.freqs{i} = n.freqs(B.id(i,:));
end
B.Properties.RowNames = B.name;
n.bands = B;

% Order ICs like source channels
if o.ICA
    [n.icNfo,idl] = sortrows(n.icNfo,"ic","ascend");
    x = x(:,idl,:);
    n.chNfo = n.icNfo;
    n.chNfo = renamevars(n.chNfo,["ic" "sbjIC"],["ch" "sbjCh"]);
else
    n.chNfo = chNfo;
end


%% Analysis template
oo = namedargs2cell(o.epoch);
[ep,psy,trialNfo] = ec_epochPsy(psy,trialNfo,n,oo{:},conds=o.conds,conds2=o.conds2); toc
if ~o.test; ep.time=[]; else; ep1=ep; end %#ok<NASGU>


%% Baseline correction, filtering, downsampling
oo = namedargs2cell(o.pre);
x = ec_epochBaseline(x,n,psy,ep,oo{:}); toc
if o.test; xOg=x; end %#ok<NASGU>


%% Organize data for classifier
if n.xChs>255; u0=uint16(0); else; u0=uint8(0); end
s0=single(nan);
n.chNfo.ch = cast(n.chNfo.ch,like=u0);

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
disp("[ec_classifySpec] Organized prepped data: "+n.sbj+" t="+toc);
% for b = 1:height(t)
%     t.n(b,1) = nnz(a.(o.t)==t.(o.t)(b) & a.cond==o.class.cond(1));
%     t.n(b,2) = nnz(a.(o.t)==t.(o.t)(b) & a.cond==o.class.cond(2));
% end
% t.wt = double(t.n);
% t.wt = flip(t.wt ./ mean(t.wt,2), 2);
% 
% % Add weights to 'a'
% for b = 1:height(t)
%     ii = a.(o.t)==t.(o.t)(b) & a.cond==o.class.cond(1);
%     a.wt(ii) = t.wt(b,1);
%     ii = a.(o.t)==t.(o.t)(b) & a.cond==o.class.cond(2);
%     a.wt(ii) = t.wt(b,2);
% end
% a.wt = single(a.wt);


%% Save prepped data
if o.savePrep || ~o.classify || ~o.stats
    fn = o.dirOutSbj+"s"+n.sbjID+"_x.mat";    savefast(fn,'x');
    disp("[ec_classifySpec] Saved prepped data: "+fn+" t="+toc);
    fn = o.dirOutSbj+"s"+n.sbjID+"_prep.mat"; save(fn,"a","t","n","ep","psy","trialNfo","-v7");
    disp("[ec_classifySpec] Saved prepped data: "+fn+" t="+toc);
end




%%%%%%%%%%%%%%%%%%%%%%%%%% Classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [rt,ra] = classify_lfn(x,a,t,n,o)
%% Call classification functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if o.test; x1=x; a1=a; t1=t; end %#ok<NASGU>
chs = n.chNfo.ch;
sbjChs = n.chNfo.sbjCh;

% Reshape data by timebins
x = arrayfun(@(b) x(a.(o.t)==b,:,:), t.(o.t), UniformOutput=false);
a = arrayfun(@(b) a(a.(o.t)==b,:), t.(o.t), UniformOutput=false);
t = arrayfun(@(b) t(t.(o.t)==b,:), t.(o.t), UniformOutput=false);
o.nBins = height(t);


%% Compute per timebin
if o.gpu
    [rt,ra] = arrayfun(@(x,a,t) classifyBin_lfn(gpuArray(x{:}),a{:},t{:},chs,sbjChs,o),...
        x,a,t,UniformOutput=false);
else
    rt=cell(height(t),1); ra=rt;
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
disp("[ec_classifySpec] Saved classificiation results: "+fn+" t="+toc);




function [rt,ra] = classifyBin_lfn(xb,ab,tb,chs,sbjChs,o)
%% Compute within timebin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% b=60; xb=x{b}; ab=a{b}; tb=t{b};
nChs = numel(chs); rt=cell(nChs,1); ra=rt; tic;

% Missclassification cost (account for unbalanced classes)
tb.n(1,1) = nnz(ab.cond=="Semantic");
tb.n(1,2) = nnz(ab.cond=="Episodic");
tb.wt(1,1) = tb.n(1,2) / tb.n(1,1); 
tb.wt(1,2) = tb.n(1,1) / tb.n(1,2);
%[~,id]=min(tb.wt); tb.wt(1,id)=1;

% Loop across channels/ICs
for ch = cast(1:nChs,like=xb)
    [rt{ch},ra{ch}] = classifyCh_lfn(xb(:,ch,:),ab,tb,o,chs(ch),sbjChs(ch));
    if ~rem(ch,20)
        disp("[ec_classifySpec] Ran "+o.class.fun+" "+sbjChs(ch)+" "+o.t+"="+tb.(o.t)+" t="+toc);
    end
end

% Finalize
rt = vertcat(rt{:});
ra = vertcat(ra{:});
if o.gpu
    rt = ec_varfun(@gather,rt);
    ra = ec_varfun(@gather,ra);
end
disp("[ec_classifySpec] Finished "+o.class.fun+" classifier: s"+o.sbjID+" "+o.t+"="+tb.(o.t)+" t="+toc);




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

