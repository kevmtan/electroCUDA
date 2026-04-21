function [x,w,xR,xS] = ec_pca(x,a)
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
    a.nComps (1,1) double = 0           % Number of components [0=skip|Inf=rank]
    a.varThr (1,1) double = 0           % Variance threshold to keep (0=skip; <=1 fraction, >1 percent)
    a.nCompLims (1,2) double = [0 Inf] % Bounds on kept components: [lower upper]
    a.robust (1,1) logical = false      % Use robust PCA
    a.exact (1,1) logical = false       % Use exact rank
    a.std string {mustBeMember(a.std,["zscore" "robust" "" []])} = "robust" % Z-score
    a.double (1,1) logical = false      % Convert to double (single/half can be unstable!)
    a.gpu (1,1) logical = isgpuarray(x) % Compute on GPU
    a.gather (1,1) logical = false      % Gather outputs from GPU
end
if isgpuarray(x); a.gpu=true; end


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

% Copy to GPU
if a.gpu && ~isgpuarray(x)
    x = gpuArray(x);
end


%% Standardize predictors
if a.std=="robust"
    x = normalize(x,1,"zscore","robust"); % robust z-score
elseif isany(a.std)
    x = normalize(x,1,a.std); % standard z-score
end


%% Robust PCA (denoising)
if a.robust
    [x,xS] = ec_pcaRobust(x);
else
    xS = [];
end


%% Matrix rank
xR = ec_rank(x(all(~isnan(x),2),:),exact=a.exact);


%% Standard PCA (dimensionality reduction)
if a.varThr || a.nComps
    % Resolve component bounds and clamp by rank
    [nCompMin,nCompMax] = compLims_lfn(a.nCompLims,xR);
    
    % Run PCA once to full rank, then keep requested subset
    [wAll,xAll,~,~,explained] = pca(x,NumComponents=xR);

    % Variance threshold supersedes explicit component count
    if a.varThr
        nKeep = find(cumsum(explained)>=a.varThr*100,1,"first");
        if isempty(nKeep)
            nKeep = xR;
        end
    else
        nKeep = a.nComps;
        if isinf(nKeep)
            nKeep = xR;
        end
    end

    % Keep bounded number of components
    nKeep = clampCompN_lfn(nKeep,nCompMin,nCompMax);
    if ~nKeep
        w = [];
    else
        w = wAll(:,1:nKeep);
        x = xAll(:,1:nKeep);
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
