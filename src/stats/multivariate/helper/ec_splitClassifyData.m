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
if o.pcaGPU && o.pca~="split"
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
splits = numel(x); % number of splits
disp("[ec_splitClassifyData] Split data by "+splits+" independent analysis: "+...
    o.dirs.sbj+" | toc="+toc(tt));


%% PCA & data rank by analysis split
if o.pca=="split"
    wts = cell(splits,1); % preallocate PCA weights
    if o.pcaGPU
        % Move EEG to GPU
        x = cellfun(@gpuArray,x,UniformOutput=false); 
        
        % Run on GPU
        for s = 1:splits
            [x{s},st(s,:),wts{s}] = rankPCA_lfn(x{s},st(s,:),o);
        end
    else
        % Run on CPU threadpool
        parfor s = 1:splits
            [x{s},st(s,:),wts{s}] = rankPCA_lfn(x{s},st(s,:),o);
        end
    end
    disp("[ec_splitClassifyData] Ran rank calculation/PCA on data splits: "+o.dirs.sbj+" | toc="+toc(tt));
end


%% Finish
if o.pcaComps 
    n.pcaWts = wts; % Save weights to n
end
disp("[ec_splitClassifyData] Finished: "+o.dirs.sbj+" | toc="+toc(tt));






%%% Within-channel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xc,obc,stc,wc] = withinCh_lfn(xc,obc,stc,n,o,c)
% Fill chan info
if isany(o.concatChs)
    % Get ROI
    ch = n.ROIs.roi(c);
    sbjCh = n.ROIs.sbjROI(c);
else
    % Get channel/IC
    ch = n.chNfo.ch(c);
    sbjCh = n.chNfo.sbjCh(c); 
end

% Fill chan/IC/ROI info
obc.ch(:)=ch; stc.ch(:)=ch;
obc.sbjCh(:)=sbjCh; stc.sbjCh(:)=sbjCh;

% Channel/IC/ROI width
stc.width(:) = width(xc);


%% PCA & data rank
if o.pca~="split"
    [xc,stc,wc] = rankPCA_lfn(xc,stc,o);
end


%% Split data by timepoint
xc = cellfun(@(t) xc(t,:),n.times.id,"UniformOutput",false);
obc = cellfun(@(t) obc(t,:),n.times.id,"UniformOutput",false);

% Remove empty cells
xc = xc(~cellfun("isempty",xc));
obc = obc(~cellfun("isempty",obc));






%%% PCA on EEG data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,st,w] = rankPCA_lfn(x,st,o)
w = [];

%% Robust PCA
if o.pcaRobust
    x = ec_robustPCA(x); % run robust PCA for denoising
end


%% Data rank
xRank = ec_rank(x);


%% Standard PCA
if o.pcaComps
    % Get number of components (features)
    nComps = o.pcaComps;
    if nComps > xRank
        nComps = xRank; end

    % Run standard PCA for dimensionality reduction
    if nComps>0 && nComps<st.width(1)
        [w,x] = pca(x,NumComponents=nComps);
    end
end


%% Finalize
st.features(:) = width(x);
st.rank(:) = xRank;

% Move from GPU
if ~o.gpu
    x = gather(x); % keep 'x' as gpuArray if processing as GPU
end
w = gather(w); % PCA weights always saved on CPU
