function [x,ep,n] = ec_analPrep(tt,a)
% ec_analPrep: prep subject data for further analyses in electroCUDA
arguments
    tt uint64 = tic
    a.dirs struct % Subject directories struct from ec_loadSbj
    a.sfx (1,1) string = "" % Input data suffix
    a.chConcat {mustBeMember(a.chConcat,["roi" "all" "" []])} = "" % Concactenate channels by ["roi"|"all"|""], default="" (none)
    a.chBadVars string = [] % Vars in n.chBad/icBad to use for bad chan removal
    a.chRm = [] % channels to remove (array of chan numbers)
    a.ROIs (1,:) string = [] % remove chs outside these ROIs
    a.roiVar string = "roi" % ROI variable in chNfo
    a.epoch struct = [] % Epoch generation options (ec_epochPsy)
    a.timeVar (1,1) string = "bin" % Timepoint variable from 'psy' ["frame"|"latency"|"bin"|"binPct"|"binRT"]
    a.condVar (1,1) string = "cond" % Condition variable from 'psy'
    a.cond1 = []
    a.cond0 = []
    a.cond (1,:) string = [] % Conditions to classify (train & test)
    a.condx (1,:) string = [] % Conditions to cross-classify (predict)
    a.conds (1,:) string = []
    a.pre struct = [] % Analysis preprocessing options (ec_epochPreproc)
    a.nRmFields (1,:) string = [] % Fields to remove from 'n' to save memory
    a.timeRng = [] % Range of times to run including baseline ([]=epochPsy output)
    a.test (1,1) logical = false
end
% tt=tic;


%% Load data 
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(a.dirs,sfx=a.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
disp("[ec_analPrep] Loaded data: "+a.dirs.sbj+" | toc="+toc(tt));
if numel(dbstack)<2; n0=n; x0=x; trialNfo0=trialNfo; end %#ok<NASGU> % Copy origs for testing
% n=n0; x=x0; trialNfo=trialNfo0; tt=tic; disp("Restored original sbj vars");


%% Channel info & removal
[x,n] = chPrep_lfn(x,chNfo,n,a,tt);


%% Epoching (psychobehavioral metadata)
if ~isempty(a.epoch)
    [psy,ep,n] = makeEpochs_lfn(psy,trialNfo,n,a,tt);
else
    disp("[ec_analPrep] Skipping epoching: empty 'epoch' argument | toc="+toc(tt));
end


%% Preprocessing (analysis-specific)
if exist("ep","var") && ~isempty(ep)
    [x,ep,n] = preproc_lfn(x,n,psy,ep,a,tt);
else
    disp("[ec_analPrep] Skipping preproc: 'ep' var is empty or nonexistent | toc="+toc(tt));
end


%% Channel concatenation
[x,n] = chConcat_lfn(x,n,a,tt);


%% Finalize
n = rmfield(n,a.nRmFields); % Fields to remove from 'n' to save memory
disp("[ec_analPrep] Finished: "+n.sbj+" | toc="+toc(tt));






function [x,n] = chPrep_lfn(x,chNfo,n,a,tt)
%%% Channel info & removal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Channel/IC info
if n.ICA
    % IC info
    n.chNfo = n.icNfo;
    n.chNfo = renamevars(n.chNfo,["ic" "sbjIC"],["ch" "sbjCh"]);
    n = renameStructField(n,'chBad','chBad0'); % must be char
    n = renameStructField(n,'icBad','chBad');
else
    % Channel info
    n.chNfo = chNfo;
end

% Only use existing chBadVars
a.chBadVars(ismember(a.chBadVars,n.chBad.Properties.VariableNames));

% Find bad chans
if isany(a.chBadVars)
    chBad = full(any(n.chBad{:,a.chBadVars},2));
else
    chBad = false(n.nChs,1);
end

% Find specified chans to remove
if isany(a.chRm)
    chRm = a.chRm;
    if isnumeric(chRm)
        chRm = ismember(n.chNfo.ch,chRm);
    end
else
    chRm = false(n.nChs,1);
end

% Find ROI chans
if isany(a.ROIs)
    chROIs = ismember(n.chNfo.(a.roiVar),a.ROIs);
else
    chROIs = true(n.nChs,1);
end

% Collate chans to keep/remove
n.chKeep = all([~chBad,~chRm,chROIs],2);

% Remove chans
if any(~n.chKeep)
    x = x(:,n.chKeep,:);            % from EEG data
    n.chNfo = n.chNfo(n.chKeep,:);  % from chNfo
    n.xChs = width(x);              % number of remaining chans

    % Remove chans from bad frames (n.xBad)
    for v = string(n.xBad.Properties.VariableNames)
        % Get number of dims for var
        nd = ndims(n.xBad.(v));

        % Remove chans from var
        if width(n.xBad.(v))==n.nChs
            if nd==3 % 3D
                xBad = full(n.xBad.(v));
                xBad = xBad(:,n.chKeep,:);
                n.xBad.(v) = sparse(xBad);
            elseif nd==2 % 2D
                n.xBad.(v) = n.xBad.(v)(:,n.chKeep);
            end
        end
    end
end
disp("[ec_analPrep] Kept "+n.xChs+"/"+n.nChs+" chans: "+n.sbj+" | toc="+toc(tt));






function [psy,ep,n] = makeEpochs_lfn(psy,trialNfo,n,a,tt)
%%% Make epochs from psychobehavioral metadata %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run epoching
oo = namedargs2cell(a.epoch);
[ep,trialNfo,n,psy] = ec_epochPsy(psy,trialNfo,n,tt,oo{:});
n.trialNfo = trialNfo;

% Rename target time & condition variables
ep = renamevars(ep,[a.timeVar a.condVar],["t" "cnd"]);
n.trialNfo = renamevars(n.trialNfo,a.condVar,"cnd");

% Remove excluded conditions
if isany(a.cond1) && isany(a.cond0)
    ep = ep(ismember(ep.cnd,[a.cond1 a.cond0]),:);
elseif isany(a.cond) && isany(a.condx)
    ep = ep(ismember(ep.cnd,[a.cond a.condx]),:);
elseif isany(a.conds)
    ep = ep(ismember(ep.cnd,a.conds),:);
end

% Update epoch indices
ep.ide = cast(1:height(ep),like=ep.ide)';
n.ide = ep.ide;

% Update nfo struct
trs = unique(ep.tr);
n.trialNfo = n.trialNfo(ismember(n.trialNfo.tr,trs),:);
n.nTrs = numel(trs);
n.cnds = unique(n.trialNfo.cnd);
n.nCnds = numel(n.cnds);

% Analysis times
[n.timesG,n.times] = findgroups(ep.t);
n.timesG = uint32(n.timesG);
n.nTimes = height(n.times); % number of times






function [x,ep,n] = preproc_lfn(x,n,psy,ep,a,tt)
%%% Analysis-specific preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run preprocessing
if ~isempty(a.pre)
    oo = namedargs2cell(a.pre);
    [x,n] = ec_epochPreproc(x,n,psy,ep,tt,oo{:},test=a.test);
else
    disp("[ec_analPrep] Skipping preproc: empty 'pre' argument | toc="+toc(tt));
end

% Keep analysis times
if isany(a.timeRng) && numel(a.timeRng)==2
    % Keep only analysis timerange
    ep = ep(ep.t>=a.timeRng(1) & ep.t<=a.timeRng(2),:);
    x = x(ep.ide,:,:);

    % Update epoch indices
    ep.ide = cast(1:height(ep),like=ep.ide)';
    n.ide = ep.ide;

    % Analysis times
    [n.timesG,n.times] = findgroups(ep.t);
    n.timesG = uint32(n.timesG);
    n.nTimes = height(n.times); % number of times
end






function [y,n] = chConcat_lfn(x,n,a,tt)
%%% Channel concatenation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if a.chConcat=="roi"
    %% Concatenate chs within ROI: y{roi}(times,freqs*chans)
    rv = a.roiVar;

    % Get ROIs
    if ~isany(a.ROIs)
        a.ROIs = unique(n.chNfo.(rv),"stable"); end
    n.ROIs = table;
    n.ROIs.roi = intersect(a.ROIs,unique(n.chNfo.(rv)),"stable");
    n.nROIs = height(n.ROIs);

    % Preallocate
    y = cell(n.nROIs,1);
    n.ROIs.nChs(:) = cast(0,like=n.chNfo.ch);
    n.ROIs.columns = cell(n.nROIs,1);
    n.ROIs.chs = cell(n.nROIs,1);
    n.ROIs.sbjChs = cell(n.nROIs,1);
    n.ROIs.sbjROI = "s"+n.sbjID+"_"+n.ROIs.roi;
    
    % Concactenate ROI channels
    for r = 1:n.nROIs
        % Find ROI chans
        id = ismember(n.chNfo.(rv),n.ROIs.roi(r));
        n.ROIs.nChs(r) = nnz(id);
        n.ROIs.chs{r} = n.chNfo.ch(id);
        n.ROIs.sbjChs{r} = n.chNfo.sbjCh(id);

        % Extract ROI EEG data
        y{r} = permute(x(:,id,:),[1 3 2]); % permute dims for concatenation

        % Concatenate EEG from (times,chans,freqs) to (times,freqs*chans)
        y{r} = reshape(y{r}, height(y{r}), width(y{r})*size(y{r},3));  % a-by-(b*c)

        % Column info
        for ch = 1:n.ROIs.nChs(r)
            xi = n.spect;
            xi.ch(:) = n.ROIs.chs{r}(ch);
            xi = movevars(xi,"ch","Before",1);
            xi = renamevars(xi,"name","spect");
            if ch==1
                n.ROIs.columns{r} = xi;
            else
                n.ROIs.columns{r} = vertcat(n.ROIs.columns{r},xi);
            end
        end
    end
    disp("[ec_analPrep] Concatenated ROI chs: "+n.sbj+" | toc="+toc(tt));
elseif a.chConcat=="all"
    %% Concatenate all chs: y(times,freqs*chans)

    % Fill ROI info table
    n.ROIs = table;
    n.ROIs.roi = "all";
    n.ROIs.columns = {};
    n.ROIs.nChs = cast(width(x),like=n.chNfo.ch);
    n.ROIs.chs = {n.chNfo.ch};
    n.ROIs.sbjChs = {n.chNfo.sbjCh};
    n.ROIs.sbjROI = "s"+n.sbjID+"_all";

    % Concactenate EEG from (times,chans,freqs) to (times,freqs*chans)
    y = reshape(permute(x,[1 3 2]), height(x), width(x)*size(x,3));

    % Column info
    for ch = 1:n.ROIs.nChs
        xi = n.spect;
        xi.ch(:) = n.ROIs.chs{1}(ch);
        xi = movevars(xi,"ch","Before",1);
        xi = renamevars(xi,"name","spect");
        if ch==1
            n.ROIs.columns{1} = xi;
        else
            n.ROIs.columns{1} = vertcat(n.ROIs.columns{1},xi);
        end
    end
    disp("[ec_analPrep] Concatenated all chs: "+n.sbj+" | toc="+toc(tt));
end