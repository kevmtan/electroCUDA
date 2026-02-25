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

% Convert EEG into channelwise cell array
if isfloat(x)
    x = ec_dim2cell(x,2);
end
nCh = numel(x);

% Preallocate
ob1 = cell(nCh,1);
st1 = ob1;


%% Split data for each independent analysis (channel/IC/ROI x timepoint)
parfor c = 1:nCh
    [x{c},ob1{c},st1{c}] = withinCh_lfn(x{c},ob,st,n,o,c);
end

% Vertically concatenate: each element corresponds to each independent analysis
x = vertcat(x{:});
ob = vertcat(ob1{:});
st = vertcat(st1{:});
splits = numel(x); % number of splits
disp("[ec_splitClassifyData] Split data by "+splits+" independent analysis: "+...
    o.dirs.sbj+" | toc="+toc(tt));


%% PCA & data rank for each analysis split
if o.pca
    %% PCA on chan/IC/ROI width (e.g., spectral PCA)
    wts = cell(splits,1); % Preallocate weights
    if o.pcaGPU
        % Move to GPU
        x = cellfun(@gpuArray,x,UniformOutput=false); 
        
        % Run on GPU per chan
        for s = 1:splits
            [x{s},wts{s}] = pca_lfn(x{s},st(s,:),o);
        end

        % Move from GPU
        if ~o.gpu
            x = cellfun(@gather,x,UniformOutput=false); end
    else
        % Run on CPU
        parfor s = 1:splits
            [x{s},wts{s},st(s,:)] = pca_lfn(x{s},st(s,:),o);
        end
    end

    % Save weights to n
    n.pcaWts = wts;
    disp("[ec_splitClassifyData] Ran PCA on data splits: "+o.dirs.sbj+" | toc="+toc(tt));
else
    %% EEG data rank
    parfor s = 1:splits
        sts = st(s,:);
        sts.rank = ec_rank(x{s});
        st(s,:) = sts;
    end
end


%% Finish
disp("[ec_splitClassifyData] Finished: "+o.dirs.sbj+" | toc="+toc(tt));






%%% Within-channel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xc1,ac1,stc] = withinCh_lfn(xc,obc,stc,n,o,c)
% Prep
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

% Channel/IC/ROI width & features
stc.width(:) = width(xc);
stc.features(:) = width(xc);

% Preallocate
xc1 = cell(height(stc),1);
ac1 = xc1;


%% Split EEG & analysis by timepoint
for t = 1:height(stc)
    % Indices for timepoint
    id = obc.t==stc.t(t);
    if ~any(obc.use(id)); continue; end % skip if insufficient obs

    % Within-timepoint
    [xc1{t},ac1{t}] = withinTime_lfn(xc(id,:),obc(id,:),o);
end






%%% Within-timepoint %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xct,obct] = withinTime_lfn(xct,obct,o)

% Outliers: all-data
if o.olThrAll
    xct = filloutliers(xct,o.olFill,o.ol,1,ThresholdFactor=o.olThrAll);
end

% Outliers: within-condition
for c = unique(obct.cnd)'
    id = obct.cnd==c;
    xct(id,:) = filloutliers(xct(id,:),o.olFill,o.ol,1,ThresholdFactor=o.olThrCond);
    %disp("Outliers "+string(c)+": "+nnz(TF)/numel(TF));
end







%%% PCA on EEG data for each independent analysis (e.g., spectral PCA) %%%%
function [xs,ws,sts] = pca_lfn(xs,sts,o)
%% EEG data rank
sts.rank = ec_rank(xs);

% Get number of components (features)
nComps = o.pca;
if nComps > sts.rank
    nComps = sts.rank; end
sts.features = nComps;


%% Robust PCA
if o.pcaRobust
    xs = inexact_alm_rpca(xs); end

%% PCA (on robustPCA output if previously done)
[ws,xs] = pca(xs,NumComponents=nComps);
