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
splits = numel(x); % number of splits
disp("[ec_splitClassifyData] Split data by "+splits+" independent analysis: "+...
    o.dirs.sbj+" | toc="+toc(tt));


%% PCA & data rank by analysis split
if o.pca=="split"
    wts = cell(splits,1); % preallocate PCA weights
    if o.pcaGPU
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
stc.ch(:)=ch; stc.sbjCh(:)=sbjCh;
obc.ch(:)=ch; obc.sbjCh(:)=sbjCh; 

% Channel/IC/ROI width
stc.width(:) = width(xc);


%% PCA & data rank
if isany(o.pca) && o.pca~="split"
    % Run PCA & rank
    [xc,wc,stc.rank(:)] = ec_pca(xc,nComps=o.pcaComps,rankLim=o.pcaRankLim,...
        robust=o.pcaRobust,gpu=o.pcaGPU,double=true);

    % Gather from GPU
    xc = gather(xc);
end


%% Final pre-split
stc.features(:) = width(x); % final number of features

% Convert to processing precision
if o.pca~="split"
    xc = cast(xc,o.typeProc); 
end


%% Split data by timepoint
xc = cellfun(@(t) xc(t,:),n.times.id,"UniformOutput",false);
obc = cellfun(@(t) obc(t,:),n.times.id,"UniformOutput",false);

% Remove empty cells
xc = xc(~cellfun("isempty",xc));
obc = obc(~cellfun("isempty",obc));






%%% PCA on EEG data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,st,w] = rankPCA_lfn(x,st,o)
% Run PCA & rank
[x,w,st.rank] = ec_pca(x,nComps=o.pcaComps,rankLim=o.pcaRankLim,...
    robust=o.pcaRobust,gpu=o.pcaGPU,double=true);

% Gather from GPU
x = gather(x);

% Convert to processing precision
x = cast(x,o.typeProc);

% Final number of features
st.features = width(x);
