function [x,ep,n,o] = ec_prepAnalysis(o,tt)
% ec_prepAnalysis: prep subject data for further analyses in electroCUDA
arguments
    o struct
    tt uint64 = tic
end


%% Load data 
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if numel(dbstack)<2; n0=n; x0=x; trialNfo0=trialNfo; end %#ok<NASGU> % Copy origs for testing
disp("[ec_prepAnalysis] Loaded data: "+o.dirs.sbj+" | toc="+toc(tt));
% n=n0; x=x0; trialNfo=trialNfo0; tt=tic; disp("Restored original sbj vars");


%% Channel info & removal
if o.ICA
    % IC info
    n.chNfo = n.icNfo;
    n.chNfo = renamevars(n.chNfo,["ic" "sbjIC"],["ch" "sbjCh"]);
    n = renameStructField(n,'chBad','chBad0'); % must be char
    n = renameStructField(n,'icBad','chBad');
else
    % Channel info
    n.chNfo = chNfo;
end

% Find bad chans
if isany(o.chBadFields)
    chBad = full(any(n.chBad{:,o.chBadFields},2));
else
    chBad = false(n.nChs,1);
end

% Find specified chans to remove
if isany(o.chRm)
    chRm = o.chRm;
    if isnumeric(chRm)
        chRm = ismember(n.chNfo.ch,chRm);
    end
else
    chRm = false(n.nChs,1);
end

% Find ROI chans
if isany(o.ROIs)
    chROIs = ismember(n.chNfo.(o.roiVar),o.ROIs);
else
    chROIs = true(n.nChs,1);
end

% Remove chans
chKeep = all([~chBad,~chRm,chROIs],2);
x = x(:,chKeep,:);
n.chNfo = n.chNfo(chKeep,:);
n.chKeep = chKeep;
n.xChs = width(x);
disp("[ec_prepAnalysis] Kept "+n.xChs+"/"+n.nChs+" chans: "+n.sbj+" | toc="+toc(tt));


%% Psychobehavioral metadata

% Epoch metadata
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,tt,oo{:});
n.trialNfo = trialNfo;

% Rename target time & condition variables
ep = renamevars(ep,[o.timeVar o.condVar],["t" "cnd"]);

% Remove excluded times
if numel(o.timeRng)==2
    ep(ep.t<o.timeRng(1) | ep.t>o.timeRng(2),:) = []; end

% Remove excluded conditions
if isfield(o,"cond1")
    ep(~ismember(ep.cnd,[o.cond1 o.cond0]),:) = [];
elseif isfield(o,"cond")
    ep(~ismember(ep.cnd,[o.cond o.condx]),:) = [];
elseif isfield(o,"conds")
    ep(~ismember(ep.cnd,o.conds),:) = [];
end
ep.ide = cast(1:height(ep),like=ep.ide)'; % update epoch indices


%% Analysis-specific EEG preprocessing
oo = namedargs2cell(o.pre);
[x,n] = ec_epochBaseline(x,n,psy,ep,tt,oo{:},test=o.test);
o.n = n;
o.spect = n.spect;


%% Concactenate channels (e.g., concactenate within-ROI chs)
if isany(o.concatChs)
    [x,n] = concatChs_lfn(x,n,o);
end

%% Final
disp("[ec_prepAnalysis] Finished: "+o.dirs.sbj+" | toc="+toc(tt));






%%% Concactenate channels %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y,n] = concatChs_lfn(x,n,o)
if o.concatChs=="roi"
    %% Concatenate chs within ROI: y{roi}(times,freqs*chans)
    rv = o.roiVar;

    % Get ROIs
    if ~isany(o.ROIs)
        o.ROIs = unique(n.chNfo.(rv),"stable"); end
    n.ROIs = table;
    n.ROIs.roi = intersect(o.ROIs,unique(n.chNfo.(rv)),"stable");
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
        y{r} = x(:,id,:);

        % Concactenate EEG from (times,chans,freqs) to (times,freqs*chans)
        y{r} = reshape(permute(y{r},[1 3 2]), height(y{r}),...
            width(y{r}) * size(y{r},3));  % a-by-(b*c)

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
elseif o.concatChs=="all"
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
end