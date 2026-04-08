function [x,ob,st,n] = ec_splitClassifyData(x,ob,st,n,o,tt)
arguments
    x (:,:,:)
    ob table
    st table
    n struct
    o struct
    tt uint64 = tic
end


%% Prep
if isfloat(x)
    x = ec_dim2cell(x,2); % convert EEG into channelwise cell array
end
nCh = numel(x);

% Preallocate
ob1 = cell(nCh,1);
st1 = ob1;
wts = ob1;


%% Main
if isany(o.pca) && o.pca~="split" && (o.pcaGPU||o.gpu)
    % Move EEG to GPU
    x = cellfun(@gpuArray,x,UniformOutput=false);

    % Run on GPU
    for c = 1:nCh
        [x{c},ob1{c},st1{c},wts{c}] = withinCh_lfn(x{c},ob,st,n,o,c);
    end
else
    % Run on CPU threadpool
    parfor c = 1:nCh
        [x{c},ob1{c},st1{c},wts{c}] = withinCh_lfn(x{c},ob,st,n,o,c);
    end
end

% Vertically concatenate: each element corresponds to each independent analysis
x = vertcat(x{:});
ob = vertcat(ob1{:});
st = vertcat(st1{:});
n.splits = numel(x); % number of splits
disp("[ec_splitClassifyData] Split data by "+n.splits+" independent analysis: "+...
    o.dirs.sbj+" | toc="+toc(tt));


%% PCA & data rank by analysis split
if o.pca=="split"
    wts = cell(n.splits,1); % preallocate PCA weights
    if o.pcaGPU
        % Run on GPU
        for s = 1:n.splits
            [x{s},st(s,:),wts{s}] = withinSplit_lfn(x{s},st(s,:),o);
        end
    else
        % Run on CPU threadpool
        parfor s = 1:n.splits
            [x{s},st(s,:),wts{s}] = withinSplit_lfn(x{s},st(s,:),o);
        end
    end
    disp("[ec_splitClassifyData] Ran rank calculation/PCA on data splits: "+o.dirs.sbj+" | toc="+toc(tt));
end


%% Finish
if o.pcaComps 
    n.pcaWts = wts; % Save weights to n
end
disp("[ec_splitClassifyData] Finished: "+o.dirs.sbj+" | toc="+toc(tt));






function [xc,obc,stc,wc] = withinCh_lfn(xc,obc,stc,n,o,c)
%%% Within-channel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fill chan info
if isany(o.chConcat)
    % Get ROI
    ch = n.ROIs.roi(c);
    sbjCh = n.ROIs.sbjROI(c);
else
    % Get channel/IC
    ch = n.chNfo.ch(c);
    sbjCh = n.chNfo.sbjCh(c); 
end

% Fill chan/IC/ROI info
stc.ch(:)=ch; stc.sbjCh(:)=sbjCh;
obc.ch(:)=ch; obc.sbjCh(:)=sbjCh; 

% Channel/IC/ROI width
stc.width(:) = width(xc);


%% PCA & data rank
if isany(o.pca) && o.pca~="split"
    % Standardize predictors, calculate rank, run PCA
    [xc,wc,stc.rank(:)] = ec_pca(xc,nComps=o.pcaComps,rankLim=o.pcaRankLim,...
        robust=o.pcaRobust,std=o.std,gpu=o.pcaGPU);

    % Gather from GPU
    if o.pcaGPU && ~o.gpu
        xc = gather(xc);
    end
elseif ~isany(o.pca)
    stc.rank(:) = ec_rank(xc);
    stc.features(:) = width(xc); % final number of features
end


%% Split data by timepoint
xc = splitapply(@(e){xc(e,:)},n.ide,n.timesG);
obc = splitapply(@(e){obc(e,:)},n.ide,n.timesG);

% Remove empty cells
xc = xc(~cellfun(@isempty,xc));
obc = obc(~cellfun(@isempty,obc));






function [x,st,w] = withinSplit_lfn(x,st,o)
%%% Within-split %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if o.pca=="split"
    % Standardize predictors, calculate rank, run PCA
    [x,w,st.rank] = ec_pca(x,nComps=o.pcaComps,rankLim=o.pcaRankLim,...
        robust=o.pcaRobust,std=o.std,gpu=o.pcaGPU,double=true);

    % Gather from GPU
    if o.pcaGPU && ~o.gpu
        x = gather(x);
    end

    % Final number of features
    st.features = width(x);
else
    % Standardize predictors
    if o.std=="robust"
        x = normalize(x,1,"zscore","robust"); % robust z-score
    elseif isany(o.std)
        x = normalize(x,1,o.std); % standard z-score
    end
end

% Convert to processing precision
x = cast(x,o.typeProc);


