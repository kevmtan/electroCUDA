function [x,n,sts,obs] = ec_analSplit(x,n,st,ob,tt,a)
% Splits data for analyses (chans/ICs/ROIs x timepoints)
arguments
    x                                   % EEG data (matrix or cell array)
    n struct                            % Info struct
    st table                            % Stats table
    ob table = []                       % Observation table
    tt uint64 = tic                     % Timer
    a.std string = ""                   % Standardize data within-split ["zscore"|"robust"|""=skip]; don't standardize to keep baseline at 0
    a.rank (1,1) logical = false        % Calculate data rank if no PCA
    a.pca string = ""                   % Run rank calculation & PCA by ["ch"|"roi"|"split"|""=skip]
    a.pcaComps (1,1){mustBeInteger} = 0 % Number of components (0=skip, inf=data rank)
    a.pcaRobust (1,1) logical = false   % Run robust PCA for denoising (can do without dim reduction)
    a.pcaGPU (1,1) logical = false      % GPU for rank calculation & PCA    
    a.pcaSaveWts (1,1) logical = true   % Save PCA weights
    a.floatAnal (1,1) string = "single" % Floating-point precision for analysis ("double"|"single")
end
% Make logical flags about data
if isfield(n,"ROIs"), a.roi=true; else; a.roi=false; end


%% Prep
if isfloat(x)
    x = ec_dim2cell(x,2); % convert EEG into channelwise cell array
end
nCh = numel(x);

% n.ide must be valid row indices into x; stale n.ide would misalign rows.
assert(numel(n.ide)==size(x{1},1) && min(n.ide,[],"all")>=1 && max(n.ide,[],"all")<=size(x{1},1),...
    "[ec_analSplit] n.ide (len=%d, range=[%d,%d]) must match x rows (%d). n.ide appears stale.",...
    numel(n.ide),min(n.ide,[],"all"),max(n.ide,[],"all"),size(x{1},1));

% Preallocate split data
sts = cell(nCh,1);
obs = sts;
wts = sts;


%% Main
if a.pcaGPU && isany(a.pca)
    % Run on GPU
    for c = 1:nCh
        [x{c},sts{c},obs{c},wts{c}] = withinCh_lfn(x{c},n,st,ob,a,c);
    end
else
    % Run on CPU threadpool
    parfor c = 1:nCh
        [x{c},sts{c},obs{c},wts{c}] = withinCh_lfn(x{c},n,st,ob,a,c);
    end
end


%% Finalize

% Vertically concatenate: each element corresponds to each independent analysis
x = vertcat(x{:});
sts = vertcat(sts{:});
obs = vertcat(obs{:});
n.splits = numel(x); % number of splits

% Save PCA weights
if a.pcaSaveWts && isany(a.pca) && a.pcaComps 
    n.pcaWts = wts; % Save weights to n
end
disp("[ec_analSplit] Data split by "+n.splits+" (chs/ICs/ROIs x timepoints) "+...
    "for analyses: "+n.sbj+" | toc="+toc(tt));
% c=5; xc=x{c}; stc=st; obc=ob;






function [xc,stc,obc,wtc] = withinCh_lfn(xc,n,stc,obc,a,c)
%%% Within-channel/IC/ROI routine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                           

% Get info
if a.roi
    % ROI
    ch = n.ROIs.roi(c);
    sbjCh = n.ROIs.sbjROI(c);
else
    % Channel/IC
    ch = n.chNfo.ch(c);
    sbjCh = n.chNfo.sbjCh(c); 
end

% Fill info
stc.ch(:)=ch; stc.sbjCh(:)=sbjCh;
if ~isempty(obc)
    obc.ch(:)=ch; obc.sbjCh(:)=sbjCh;
end

% ROI width
if a.roi
    stc.width(:) = width(xc);
end


%% Within-channel processing
if isany(a.pca) && a.pca~="split"
    % Run PCA
    [xc,wtc,stc.rank(:)] = ec_pca(xc,nComps=a.pcaComps,robust=a.pcaRobust,...
        std=a.std,gpu=a.pcaGPU,double=true,gather=true,exact=false);    
    % Final number of features
    stc.features(:) = width(xc);
    % Save PCA weights
    if a.pcaSaveWts
        wtc = single(wtc);
    else
        wtc = [];
    end
elseif ~isany(a.pca)
    % Rank calculation
    if a.rank
        stc.rank(:) = ec_rank(xc); 
    end
    wtc = [];
end


%% Split data by timepoint
xc = splitapply(@(e){xc(e,:)},n.ide,n.timesG);
if ~isempty(obc)
    obc = splitapply(@(e){obc(e,:)},n.ide,n.timesG);
end


%% Within-split processing
if a.pca=="split"
    % PCA weight preallocation
    wtc = cell(n.nTimes,1);

    % Run PCA
    for t = 1:n.nTimes
        [xc{t},stc(t,:),wtc{t}] = withinSplit_lfn(xc{t},stc(t,:),a);
    end

    % % Gather from GPU
    % if a.pcaGPU
    %     xc = cellfun(@gather,xc,UniformOutput=false);
    %     wtc = cellfun(@gather,wtc,UniformOutput=false);
    % end
elseif isany(a.std)
    % Standardize features
    for t = 1:n.nTimes
        xc{t} = withinSplit_lfn(xc{t},[],a);
    end
end






function [xs,sts,w] = withinSplit_lfn(xs,sts,a)
%%% Within-split routine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if a.pca=="split"
    % Standardize predictors, calculate rank, run PCA
    [xs,w,sts.rank] = ec_pca(xs,nComps=a.pcaComps,robust=a.pcaRobust,...
        std=a.std,gpu=a.pcaGPU,double=true,gather=true,exact=true);
    % Final number of features
    sts.features = width(xs);
    % Save PCA weights
    if a.pcaSaveWts
        w = single(w); % convert to single
    else
        w = []; % delete
    end
else
    % Standardize predictors
    if a.std=="robust"
        xs = normalize(xs,1,"zscore","robust"); % robust z-score
    elseif isany(a.std)
        xs = normalize(xs,1,a.std); % standard z-score
    end
end

% Convert to processing precision
xs = cast(xs,a.floatAnal);


