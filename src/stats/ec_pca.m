function [x,w,xRank,xS] = ec_pca(x,use,a)
% Denoise with robust PCA, dimensionality reduction with standard PCA.
% Reduces dimensionality to matrix rank if width(x) or a.nComps exceeds
% rank
%
% OUPUTS:
%   x = Input matrix after PCA transform
%   w = PCA weights (standard PCA)
%   xR = matrix rank of input data (after robust PCA if performed)
%   xS = sparse noise matrix extracted by robust PCA
%
% Part of the electroCUDA package: https://github.com/kevmtan/electroCUDA

%% Input validation
arguments
    x (:,:){mustBeFloat}                % Input matrix: x(observations,features)
    use (:,1){mustBeNumericOrLogical} = true(height(x),1) % Rows used to fit standardization/PCA
    a.nComps (1,1) double = 0           % Number of components [0=skip|Inf=rank]
    a.varThr (1,1) double = 0           % Variance threshold to keep (0=skip; <=1 fraction, >1 percent)
    a.nCompLims (1,2) double = [0 Inf]  % Bounds on kept components: [lower upper]
    a.robust (1,1) logical = false      % Use robust PCA
    a.exact (1,1) logical = false       % Use exact rank
    a.std string {mustBeMember(a.std,["zscore" "robust" "" []])} = "robust" % Z-score
    a.double (1,1) logical = false      % Convert to double (single/half can be unstable!)
    a.gpu (1,1) logical = isgpuarray(x) % Compute on GPU
    a.gather (1,1) logical = false      % Gather outputs from GPU
end
if isgpuarray(x); a.gpu=true; end

% Validate 'use' argument 
if islogical(use)
    % Logical mask mode
    if numel(use) ~= height(x)
        error("[ec_pca] Logical 'use' length (%d) must match rows in x (%d).",numel(use),height(x));
    end
elseif isnumeric(use)
    % Numeric index mode (allow explicit row indices)
    if numel(use)==height(x) && all(ismember(use,[0 1]))
        % Numeric mask mode (0/1)
        use = logical(use);
    elseif any(~isfinite(use)) || any(use<1) || any(use>height(x)) || any(use~=round(use))       
        error("[ec_pca] Numeric 'use' must contain valid row indices in [1,%d].",height(x));
    end
end
if ~any(use)
    warning("[ec_pca] No rows selected in 'use'; returning empty outputs.");
    x = [];
    w = [];
    xRank = 0;
    xS = [];
    return;
end


%% Prep

% Parse variance threshold (accept fraction [0,1] or percent [0,100])
a.varThr = parseVarThr_lfn(a.varThr);

% Use exact rank if GPU array & single/half (bad results otherwise)
if a.gpu && (isa(x,"single") || isa(x,"half")) && ~a.double
    a.exact = true;
end

% Convert to double
if a.double
    x = double(x);
end


%% Standardize predictors
if a.std=="robust"
    ctr = median(x(use,:),1,"omitnan");
    scl = mad(x(use,:),1,1);          % 1 = median absolute deviation
    scl(scl==0) = 1;                  % avoid divide-by-zero
    x = (x - ctr) ./ scl;             % apply scaler to all rows
elseif isany(a.std)
    ctr = mean(x(use,:),1,"omitnan");
    scl = std(x(use,:),0,1,"omitnan");
    scl(scl==0) = 1;
    x = (x - ctr) ./ scl;             % apply scaler to all rows
end


%% Robust PCA (denoising)

% Copy to GPU
if a.gpu && ~isgpuarray(x)
    x = gpuArray(x);
end

% Run robust denoising
if a.robust
    [x,xS] = ec_pcaRobust(x);
else
    xS = [];
end


%% Matrix rank
xFit = x(use,:); % rows used to fit PCA
xRank = ec_rank(xFit(all(~isnan(xFit),2),:),exact=a.exact);


%% Standard PCA (dimensionality reduction)
if a.varThr || a.nComps || width(x)>xRank
    % Degenerate rank: nothing to project.
    if xRank==0
        warning("[ec_pca] Matrix is degenerate (rank=0); skipping PCA dimensionality reduction.");
        w = [];
        if a.gpu && a.gather
            x = gather(x);
            w = gather(w);
            xS = gather(xS);
        end
        return;
    end

    % Resolve component bounds and clamp by rank
    [nCompMin,nCompMax] = compLims_lfn(a.nCompLims,xRank);
    
    % Run PCA on fit rows only, then project all rows with learned weights.
    [wAll,~,~,~,explained,mu] = pca(xFit,NumComponents=xRank);

    % Variance threshold supersedes explicit component count
    if a.varThr
        nKeep = find(cumsum(explained)>=a.varThr*100,1,"first");
        if isempty(nKeep)
            nKeep = xRank;
        end
    else
        nKeep = a.nComps;
        % Internal rank-deficiency guard: if no explicit dimensionality
        % target is set (nComps=0,varThr=0) but matrix is rank-deficient,
        % reduce to full rank.
        if ~nKeep && ~a.varThr && width(x)>xRank
            nKeep = xRank;
        end
        if isinf(nKeep)
            nKeep = xRank;
        end
    end

    % Keep bounded number of components
    nKeep = clampCompN_lfn(nKeep,nCompMin,nCompMax);
    if ~nKeep
        warning("[ec_pca] nKeep=0 after clamping; skipping PCA dimensionality reduction.");
        w = [];
        if a.gpu && a.gather
            x = gather(x);
            w = gather(w);
            xS = gather(xS);
        end
        return;
    else
        w = wAll(:,1:nKeep);
        % Apply fit-row centering and PCA weights to all rows.
        x = (x - mu) * w;
    end
else
    w = [];
end


%% Gather
if a.gpu && a.gather
    x = gather(x);
    w = gather(w);
    xS = gather(xS);
end




function varThr = parseVarThr_lfn(varThrIn)
%%% Parse/validate variance threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if varThrIn > 1
    if varThrIn <= 100
        varThr = varThrIn / 100;
    else
        error("[ec_pca] a.varThr must be within [0,1] or [0,100]");
    end
else
    varThr = varThrIn;
end
if varThr < 0
    error("[ec_pca] a.varThr must be non-negative");
end




function [nCompMin,nCompMax] = compLims_lfn(nCompLims,xR)
%%% Resolve component limits %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nCompMin = max(0,round(nCompLims(1)));
nCompMax = round(nCompLims(2));
if isfinite(nCompMax)
    nCompMax = max(nCompMin,nCompMax);
    nCompMax = min(nCompMax,xR); % clamp by rank
else
    nCompMax = xR;
end
nCompMin = min(nCompMin,nCompMax);




function nKeep = clampCompN_lfn(nKeep,nCompMin,nCompMax)
%%% Clamp component count to limits %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nKeep = min(max(round(nKeep),nCompMin),nCompMax);
