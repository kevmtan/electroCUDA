function [x,aa,rr,n] = ec_splitClassifyData(x,a,r,n,o,tt)
arguments
    x (:,:,:)
    a table
    r table
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
aa = cell(nCh,1);
rr = aa;


%% Split data by channel
parfor c = 1:numel(x)
    [x{c},aa{c},rr{c}] = withinCh_lfn(x{c},a,r,n,o,c);
end

% Vertically concatenate: each element corresponds to each independent analysis
x = vertcat(x{:});
aa = vertcat(aa{:});
rr = vertcat(rr{:});


%% PCA on EEG data for each independent analysis (e.g., spectral PCA)
if o.pca
    % Preallocate weights
    wts = cell(numel(x),1);

    % Probablistic PCA
    if o.pcaGPU
        % Run on GPU
        for c = 1:numel(x)
            [x{c},wts{c}] = pca_lfn(x{c},o);
        end
    else
        % Run on CPU
        parfor c = 1:numel(x)
            [x{c},wts{c}] = pca_lfn(x{c},o);
        end
    end

    % Save weights to n
    n.pcaWts = wts;
end


%% Finish
disp("[ec_splitClassifyData] Finished: "+o.dirs.sbj+" | toc="+toc(tt));






%%% Within-channel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xc1,ac1,rc] = withinCh_lfn(xc,ac,rc,n,o,c)

% Fill channel/ROIs info
if isany(o.concatChs)
    % Get ROI
    ch = n.ROIs.roi(c);
    sbjCh = n.ROIs.sbjROI(c);

    % Fill
    ac.roi(:)=ch; rc.ch(:)=ch;
    ac.sbjROI(:)=sbjCh; rc.sbjROI(:)=sbjCh;
else
    % Get channel
    ch = n.chNfo.ch(c);
    sbjCh = n.chNfo.sbjCh(c);

    % Fill
    ac.ch(:)=ch; rc.ch(:)=ch;
    ac.sbjCh(:)=sbjCh; rc.sbjCh(:)=sbjCh;
end


%% Split EEG & analysis by timepoint
xc1 = cell(height(rc),1);
ac1 = cell(height(rc),1);

for t = 1:height(rc)
    % Indices for timepoint
    id = ac.t==rc.t(t);
    if ~any(ac.use(id)); continue; end % skip if insufficient obs

    % Within-timepoint
    [xc1{t},ac1{t}] = withinTime_lfn(xc(id,:),ac(id,:),o);
end





%%% Within-timepoint %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xct,act] = withinTime_lfn(xct,act,o)

% Outlier detection (all data)
if o.olThrAll
    xct = filloutliers(xct,o.olFill,o.ol,1,ThresholdFactor=o.olThrAll);
end

% Outlier detection (within-condition)
for c = unique(act.cnd)'
    id = act.cnd==c;
    xct(id,:) = filloutliers(xct(id,:),o.olFill,o.ol,1,ThresholdFactor=o.olThrCond);
    %disp("Outliers "+string(c)+": "+nnz(TF)/numel(TF));
end






%%% PCA on EEG data for each independent analysis (e.g., spectral PCA) %%%%
function [xct,wct] = pca_lfn(xct,o)

% Move EEG to GPU
if o.pcaGPU
    xct = gpuArray(xct); end

% Probablistic PCA
[wct,xct] = ppca(xct,o.pca);
% % Run robust PCA
% xct = ec_robustPCA(xct,o.pca);

% Move from GPU to CPU
if o.pcaGPU
    xct = gather(xct); end
