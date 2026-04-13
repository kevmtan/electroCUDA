function [x,n,sts,obs] = ec_analSplit(x,n,st,ob,tt,o)
% Splits data for analyses (chans/ICs/ROIs x timepoints)
arguments
    x                                   % EEG data (matrix or cell array)
    n struct                            % Info struct
    st table                            % Stats table
    ob table = []                       % Observation table
    tt uint64 = tic                     % Timer
    o.std string = ""                   % Standardize data within-split ["zscore"|"robust"|""=skip]; don't standardize to keep baseline at 0
    o.pca string = ""                   % Run rank calculation & PCA by ["ch"|"roi"|"split"|""=skip]
    o.pcaComps (1,1){mustBeInteger} = 0 % Number of components (0=skip, inf=data rank)
    o.pcaRobust (1,1) logical = false   % Run robust PCA for denoising (can do without dim reduction)
    o.pcaGPU (1,1) logical = false      % GPU for rank calculation & PCA
    o.rank (1,1) logical = false        % Calculate data rank if no PCA
    o.floatAnal string = "single"        % Floating-point precision for analysis ("double"|"single")
end
% Make logical flags about data
if isfield(n,"ROIs"), o.roi=true; else; o.roi=false; end


%% Prep
if isfloat(x)
    x = ec_dim2cell(x,2); % convert EEG into channelwise cell array
end
nCh = numel(x);

% Preallocate split data
sts = cell(nCh,1);
obs = sts;
wts = sts;


%% Main
if o.pcaGPU && isany(o.pca)
    % Run on GPU
    for c = 1:nCh
        [x{c},sts{c},obs{c},wts{c}] = withinCh_lfn(x{c},n,st,ob,o,c);
    end
else
    % Run on CPU threadpool
    parfor c = 1:nCh
        [x{c},sts{c},obs{c},wts{c}] = withinCh_lfn(x{c},n,st,ob,o,c);
    end
end


%% Finalize

% Vertically concatenate: each element corresponds to each independent analysis
x = vertcat(x{:});
sts = vertcat(sts{:});
obs = vertcat(obs{:});
n.splits = numel(x); % number of splits

% Save PCA weights
if isany(o.pca) && o.pcaComps 
    n.pcaWts = wts; % Save weights to n
end
disp("[ec_analSplit] Data split by "+n.splits+" (chs/ICs/ROIs x timepoints) "+...
    "for analyses: "+n.sbj+" | toc="+toc(tt));
% c=5; xc=x{c}; stc=st; obc=ob;






function [xc,stc,obc,wtc] = withinCh_lfn(xc,n,stc,obc,o,c)
%%% Within-channel/IC/ROI routine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                           

% Get info
if o.roi
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
if o.roi
    stc.width(:) = width(xc);
end


%% Within-channel processing
if isany(o.pca) && o.pca~="split"
    % Run PCA
    [xc,wtc,stc.rank(:)] = ec_pca(xc,nComps=o.pcaComps,robust=o.pcaRobust,...
        std=o.std,gpu=o.pcaGPU,gather=true,double=true);    
    % Final number of features
    stc.features(:) = width(xc);
elseif ~isany(o.pca)
    % Rank calculation
    if o.rank
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
if o.pca=="split"
    % PCA weight preallocation
    wtc = cell(n.nTimes,1);

    % Copy to GPU
    if o.pcaGPU
        xc = cellfun(@gpuArray,xc,UniformOutput=false);
    end

    % Run PCA
    for t = 1:n.nTimes
        [xc{t},stc(t,:),wtc{t}] = withinSplit_lfn(xc{t},stc(t,:),o);
    end
elseif isany(o.std)
    % Standardize features
    for t = 1:n.nTimes
        xc{t} = withinSplit_lfn(xc{t},[],o);
    end
end






function [xs,sts,w] = withinSplit_lfn(xs,sts,o)
%%% Within-split routine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if o.pca=="split"
    % Standardize predictors, calculate rank, run PCA
    [xs,w,sts.rank] = ec_pca(xs,nComps=o.pcaComps,robust=o.pcaRobust,...
        std=o.std,gpu=o.pcaGPU,gather=true,double=true);
    % Final number of features
    sts.features = width(xs);
else
    % Standardize predictors
    if o.std=="robust"
        xs = normalize(xs,1,"zscore","robust"); % robust z-score
    elseif isany(o.std)
        xs = normalize(xs,1,o.std); % standard z-score
    end
end

% Convert to processing precision
xs = cast(xs,o.floatAnal);


