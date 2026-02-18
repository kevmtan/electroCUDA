function [x,ep,n,o,trialNfo] = ec_prepAnalysis(o,tt)
% ec_prepAnalysis: prep subject data for further analyses in electroCUDA
arguments
    o struct
    tt uint64 = tic
end


%% Load data 
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if numel(dbstack)<2; nOg=n; xOg=x; trialNfoOg=trialNfo; end %#ok<NASGU> % Copy origs for testing
disp("[ec_classifyChSpec] Loaded data: "+o.dirs.sbj+" | toc="+toc(tt));


%% Channels

% Channel/IC info
if o.ICA
    n.chNfo = n.icNfo;
    n.chNfo = renamevars(n.chNfo,["ic" "sbjIC"],["ch" "sbjCh"]);
    chBad = any(n.icBad{:,o.chBadFields},2); % ICs to include in stats
else
    n.chNfo = chNfo;
    chBad = any(n.chBad{:,o.chBadFields},2); % chans to include in stats
end

% Remove bad chans/ICs
x(:,chBad,:) = [];
n.chNfo(chBad,:) = [];

% Remove specified chans
if isany(o.chRm)
    chRm = ismember(n.chNfo.ch,o.chRm);
    x(:,chRm,:) = [];
    n.chNfo(chRm,:) = [];
end

% Remove non-ROI channels
if isany(o.ROIs)
    chROIs = ismember(n.chNfo.(o.roiVar),o.ROIs);
    x = x(:,chROIs,:);
    n.chNfo = n.chNfo(chROIs,:);
end


%% Behavioral / recording metadata

% Epoch psych/behav task data
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,tt,oo{:});

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






%%% Concactenate channels %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y,n] = concatChs_lfn(x,n,o)
if o.concatChs=="roi"
    %% Concatenate chs within ROI: y{roi}(times,freqs*chans)
    rv = o.roiVar;

    % Get ROIs
    if ~isany(o.ROIs)
        o.ROIs = unique(n.chNfo.(rv),"stable"); end
    n.ROIs = table;
    n.ROIs.(rv) = intersect(o.ROIs,unique(n.chNfo.(rv)),"stable");
    n.nROIs = height(n.ROIs);

    % Preallocate
    y = cell(n.nROIs,1);
    n.ROIs.nChs(:) = cast(0,like=n.chNfo.ch);
    n.ROIs.columns = cell(n.nROIs,1);
    n.ROIs.chs = cell(n.nROIs,1);
    n.ROIs.sbjChs = cell(n.nROIs,1);
    n.ROIs.sbjROI = "s"+n.sbjID+"_"+n.ROIs.(rv);
    
    % Concactenate ROI channels
    for r = 1:n.nROIs
        % Find ROI chans
        id = ismember(n.chNfo.(rv),n.ROIs.(rv)(r));
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