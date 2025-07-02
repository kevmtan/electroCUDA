function o = ec_summaryCh_spec(sbj,proj,task,o,a)
arguments
    sbj string
    proj string
    task string
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    a.plot logical = false
    a.test logical = false
    a.dbstop logical = false
end
if a.test
    disp("TESTING sumStats: "+sbj);
    dbstop if error
end
% a.plot=0; a.test=1;
%% Load
if contains(o.sfx,"i"); o.ICA = true; end
if o.ICA && ~contains(o.sfx,"i"); o.sfx = o.sfx + "i"; end
dirs = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.sfx);
o.dirs = dirs;
o.dirIn = dirs.procSbj; %
o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
o.dirOut = dirs.anal+"summary/"+o.name+"/";
o.dirOutSbj = dirs.anal+"summary/"+o.name+"/s"+dirs.sbjID+"/";

% Load
tic;
[ns,xs,psy,trialNfo,chNfo] =...
    ec_loadSbj(dirs,sfx=o.sfx+"s",vars=["n" "x" "psy" "trialNfo" "chNfo"]);
xs = single(xs);
if a.test; xs1=xs; trialNfoOg=trialNfo; x_bad=ns.xBad; end %#ok<NASGU>
toc;

%% Initialize
sbj = ns.sbj;
sbjID = ns.sbjID;
conds = o.conds;
sbjChs = chNfo.sbjCh;
nChs = ns.xChs;
nTrs = ns.nTrials;
nBands = numel(o.bands);
if o.ICA
    nChs = ns.nICs;
    icNfo = ns.icNfo;
    sbjChs = icNfo.sbjIC;
end
% Target sampling rate
if ~isany(o.pre.hzTarg) || ns.hz<o.pre.hzTarg
    o.pre.hzTarg = ns.hz;
end

% Band indices
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.freqs(:) = {[]};
for i = 1:nBands
    B.id(i,:) = (ns.freqs>o.bandsF(i,1) & ns.freqs<=o.bandsF(i,2))';
    B.freqs{i} = ns.freqs(B.id(i,:));
end
B.Properties.RowNames = B.name;

%% Get mean evoked magnitude per freq & cond
fAvg = nan(numel(conds),nChs,numel(ns.freqs),"like",xs);
for c = 1:numel(conds)
    idx = psy.stim & psy.cond==conds(c);
    fAvg(c,:,:) = mean(xs(idx,:,:),1,"omitnan");
end
disp("Calculated mean evoked magnitude per freq & cond: "+sbj); toc;

%% Analysis template
oo = namedargs2cell(o.epoch);
[ep,trialNfo] = ec_epochPsy(psy,trialNfo,ns,oo{:},conds=o.conds,conds2=o.conds2); toc
if ~a.test; end

%% Preprocessing: baseline correction, filtering, downsampling
oo = namedargs2cell(o.pre);
xs = ec_epochBaseline(xs,ns,psy,ep,oo{:}); toc % ADD DOWNSAMPLING

%% Spec: summary stats
ss = statsSpec_lfn(xs,ns,sbjChs,ep,B,o); toc

%% LFP: load & initialize
[n,x,psy1] = ec_loadSbj(dirs,sfx=o.sfx,vars=["n" "x" "psy"]);
if a.test; x1=x; end %#ok<NASGU>
x = single(x);
n.suffix = o.sfx;

%% LFP: denoise, downsample & baseline correction
oo = namedargs2cell(o.pre);
x = ec_epochBaseline(x,n,psy1,ep,oo{:}); toc
if ~a.test; clear n; clear psy1; clear trialNfo1; end

%% LFP: summary stats
ss = statsBand_lfn(x,ns,sbjChs,ep,"lfp",o,ss); toc;

%% Organize data for plotting
lats5 = int16(1000 * (o.stats.epoch(1):o.epoch.bin2:5))';
nLats = numel(lats5);
trialNfo.RT1 = int32(trialNfo.RT*1000);

% Slice full timecourses for plotting
xe = nan(nLats,nChs,nTrs,"like",x);
xhe = nan(nLats,nChs,nTrs,"like",x);
for t = 1:nTrs
    idx = ep.idx(ep.tr==trialNfo.tr(t));
    idx = idx(ismember(ep.bin2(idx),lats5));
    idx = idx(ep.idx(idx)<=trialNfo.idxOff(t));
    [~,ia,ib] = intersect(lats5,ep.bin2(idx),'stable');
    xe(ia,:,t) = x(idx(ib),:);
    xhe(ia,:,t) = mean(xs(idx(ib),:,B.id("hfb",:)),3,'omitnan');
end
trialNfo.RT1(~trialNfo.RT1) = trialNfo.tr(~trialNfo.RT1);

[trialNfo,idx] = sortrows(trialNfo,["cond" "RT1" "tr"]);
xe = xe(:,:,idx);
xhe = xhe(:,:,idx);
disp("Finished plotting prep: "+sbj);

%% Save summary stats
if ~a.test; clear x xh nh ep; end
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
if ~isfolder(o.dirOutSbj); mkdir(o.dirOutSbj); end
% try parfevalOnAll(@gpuDevice,0,[]); catch;end
% try reset(gpuDevice(1)); catch;end

fn = o.dirOut+"s"+sbjID+"_"+o.name+".mat";
save(fn,"ss","-v7");
disp("SAVED: "+fn);

%% Initialize plotting
if ~a.plot
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    savefast(fn,'xe','xhe','fAvg','B','trialNfo');
    disp("SAVED: "+fn);
else
    ec_summaryCh_specPlot(a,o,dirs,ss,xe,xhe,fAvg,B,trialNfo);
end
end




%% Stats Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Summary stats for multiple freqs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ss = statsSpec_lfn(xs,ns,sbjChs,ep,B,o)
sbj = ns.sbj;
sbjID = ns.sbjID;
nChs = size(xs,2);
B(cellfun(@isempty,B.freqs),:) = [];
doICA = ns.ICA;
if doICA; chNames = ns.icNfo.ic; else; chNames=[1:nChs,1]; end
epoch = int16(floor(o.stats.epoch*1000));
epochRT = int16(floor(o.stats.epochRT*1000));
epochPct = int16(o.stats.epochPct);

%% Calculate stats
ss = cell(nChs,1);
parfor ch = 1:nChs
    ssCh = table;
    ssCh.ch(1) = ch;
    if doICA; ssCh.name(1) = chNames(ch); end
    ssCh.sbjID(1) = sbjID;
    epCh = ep;
    epCh.x = squeeze(xs(:,ch,:));
    epCh.latency = double(epCh.latency);

    %% Stim-locked stats (latency)
    if ~isempty(epoch)
        idx = epCh.bin2>=epoch(1) & epCh.bin2<=epoch(2);

        % All frequencies
        sl = grpstats(epCh(idx,:),["cond" "bin2"],"mean","DataVars",["latency" "x"]);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"mean_","");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"GroupCount","N");
        sl.latency=single(sl.latency); sl.cond=string(sl.cond); sl.N=uint16(sl.N);
        sl.sbjCh(:) = sbjChs(ch);
        sl.Properties.RowNames = sl.sbjCh+"_"+sl.cond+"_"+sl.bin2;
        sl = movevars(sl,"sbjCh","Before","cond");

        % Reconstruct frequency band timecourses
        for b = 1:height(B)
            band = B.name(b);
            idb = B.id(b,:);
            epCh.(band)(idx) = mean(epCh.x(idx,idb),2,'omitnan');
        end
        epCh.x = [];

        % Frequency bands
        sl2 = grpstats(epCh(idx,:),["cond" "bin2"],["mean" "sem"],"DataVars",B.name);
        sl2.Properties.VariableNames = strrep(sl2.Properties.VariableNames,"mean_","");
        sl2.Properties.VariableNames = strrep(sl2.Properties.VariableNames,"sem_","SE_");
        sl2.cond=[]; sl2.bin2=[]; sl2.GroupCount=[]; sl2.Properties.RowNames={};
        sl = [sl,sl2]; % Concactenate & copy
        sl = movevars(sl,sl2.Properties.VariableNames,"Before","x");
        ssCh.ms{1} = sl;
    end

    %% RT-locked stats (RT - latency)
    if ~isempty(epochRT)
        idx = epCh.binRT2>=epochRT(1) & epCh.binRT2<=epochRT(2);
        % Frequency bands
        sr = grpstats(epCh(idx,:),["cond" "binRT2"],["mean" "sem"],"DataVars",B.name);
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"mean_","");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"sem_","SE_");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"GroupCount","N");
        sr.N=uint16(sr.N); sr.cond=string(sr.cond);
        sr.sbjCh(:) = sbjChs(ch);
        sr = movevars(sr,"sbjCh","Before","cond");
        sr.Properties.RowNames = sr.sbjCh+"_"+sr.cond+"_"+sr.binRT2;
        ssCh.RT{1} = sr;
    end

    %% Percent RT stats (latency/RT)
    if ~isempty(epochPct)
        idx = epCh.pct2>=epochPct(1) & epCh.pct2<=epochPct(2);
        % Frequency bands
        sp = grpstats(epCh(idx,:),["cond" "pct2"],["mean" "sem"],"DataVars",B.name);
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"mean_","");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"sem_","SE_");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"GroupCount","N");
        sp.N=uint16(sp.N); sp.cond=string(sp.cond);
        sp.sbjCh(:) = sbjChs(ch);
        sp = movevars(sp,"sbjCh","Before","cond");
        sp.Properties.RowNames = sp.sbjCh+"_"+sp.cond+"_"+sp.pct2;
        ssCh.pct{1} = sp;
    end

    %% Copy
    ss{ch} = ssCh;
end

% Finalize
ss = vertcat(ss{:});
ss.sbjCh = sbjChs;
ss.Properties.RowNames = sbjChs;
disp("SPEC summary stats: "+sbj);
end


% Summary stats for single freq/timecourse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ss = statsBand_lfn(xa,na,sbjChs,ep,band,o,ss)
sbj = na.sbj;
sbjID = na.sbjID;
nChs = size(xa,2);
epoch = int16(floor(o.stats.epoch*1000));
epochRT = int16(floor(o.stats.epochRT*1000));
epochPct = int16(o.stats.epochPct);
if nargin<7
    ss = table;
    ss.ch = (1:nChs)';
    if na.ICA; ss.name = na.icNfo.name; end
    ss.sbjID(:) = sbjID;
end

%% Calculate stats
ss = table2struct(ss);
ss = mat2cell(ss,ones(height(ss),1));
parfor ch = 1:nChs
    ssCh = ss{ch};
    epCh = ep;
    epCh.x = xa(:,ch); % Channel data
    epCh.latency = double(epCh.latency);

    %% Stim-locked stats
    if ~isempty(epoch)
        idx = epCh.bin2>=epoch(1) & epCh.bin2<=epoch(2);

        % All frequencies
        sl = grpstats(epCh(idx,:),["cond" "bin2"],["mean" "sem"],"DataVars",["latency" "x"]);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"_x","_"+band);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"mean_","");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"sem_","SE_");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"GroupCount","N");
        sl.latency=single(sl.latency); sl.cond=string(sl.cond); sl.N=uint16(sl.N);
        sl.sbjCh(:) = sbjChs(ch);
        sl.Properties.RowNames = sl.sbjCh+"_"+sl.cond+"_"+sl.bin2;
        sl = movevars(sl,"sbjCh","Before","cond");
        sl.SE_latency = [];
        % Copy to permanent table
        if any(fieldnames(ssCh)=="ms")
            ssCh.ms.(band) = sl.(band);
            ssCh.ms.("SE_"+band) = sl.("SE_"+band);
        else
            ssCh.ms = sl;
        end
    end

    %% RT-locked stats
    if ~isempty(epochRT)
        idx = epCh.binRT2>=epochRT(1) & epCh.binRT2<=epochRT(2);
        sr = grpstats(epCh(idx,:),["cond" "binRT2"],["mean" "sem"],"DataVars","x");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"_x","_"+band);
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"mean_","");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"sem_","SE_");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"GroupCount","N");
        sr.N=uint16(sr.N); sr.cond=string(sr.cond);
        sr.sbjCh(:) = sbjChs(ch);
        sr.Properties.RowNames = sr.sbjCh+"_"+sr.cond+"_"+sr.binRT2;
        sr = movevars(sr,"sbjCh","Before","cond");
        % Copy to permanent table
        if any(fieldnames(ssCh)=="RT")
            ssCh.RT.(band) = sr.(band);
            ssCh.RT.("SE_"+band) = sr.("SE_"+band);
        else
            ssCh.RT = sr; % Copy
        end
    end

    %% Percent RT stats
    if ~isempty(epochPct)
        idx = epCh.pct2>=epochPct(1) & epCh.pct2<=epochPct(2);
        sp = grpstats(epCh(idx,:),["cond" "pct2"],["mean" "sem"],"DataVars","x");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"_x","_"+band);
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"mean_","");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"sem_","SE_");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"GroupCount","N");
        sp.N=uint16(sp.N); sp.cond=string(sp.cond);
        sp.sbjCh(:) = sbjChs(ch);
        sp.Properties.RowNames = sp.sbjCh+"_"+sp.cond+"_"+sp.pct2;
        sp = movevars(sp,"sbjCh","Before","cond");
        % Copy to permanent table
        if any(fieldnames(ssCh)=="pct")
            [~,iA,iB] = intersect(ssCh.pct.Properties.RowNames,sp.Properties.RowNames,"stable");
            ssCh.pct.(band)(iA) = sp.(band)(iB);
            ssCh.pct.("SE_"+band)(iA) = sp.("SE_"+band)(iB);
        else
            ssCh.pct = sp; % Copy
        end
    end

    %% Copy
    ss{ch} = ssCh;
end

% Finalize
ss = struct2table(vertcat(ss{:}));
ss.sbjCh = sbjChs;
ss.Properties.RowNames = sbjChs;
disp(band+" summary stats: "+sbj);
end



