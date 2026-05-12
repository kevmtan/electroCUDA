function tfce = ec_tfce(stat,featureSize,opts)
%EC_TFCE  Threshold-Free Cluster Enhancement (Smith & Nichols 2009).
%   TFCE = EC_TFCE(STAT,FEATURESIZE) applies signed TFCE to each column of
%   STAT, where STAT is [nVar x N] with nVar = prod(FEATURESIZE). Each
%   column is reshaped to FEATURESIZE, enhanced separately on its positive
%   and negative parts via supra-threshold cluster integration, then
%   combined as TFCEPOS-TFCENEG so the sign of STAT is preserved.
%
%   Output TFCE has the same [nVar x N] shape as STAT. Magnitudes are not
%   t-statistics; they are TFCE scores (~ height^H * extent^E units).
%
%   TFCE = EC_TFCE(...,OPTS) accepts an OPTS struct with the following
%   fields (all optional):
%       'E'             extent exponent (default 0.5; see Defaults below)
%       'H'             height exponent (default 2; see Defaults below)
%       'dh'            integration step; 0 => max(|stat|)/100 per column
%                       (default 0)
%       'conn'          BWCONNCOMP connectivity (default conndef(max(2,K),
%                       "minimal") = rook adjacency: 4-conn in 2-D, 6-conn
%                       in 3-D, chain in 1-D)
%       'spatialDims'   feature-dim indices (1-based, into FEATURESIZE, *not*
%                       the raw data array) that form the TFCE neighborhood;
%                       trailing dims are treated as independent panels
%                       enhanced separately (default = all dims). In the
%                       electroCUDA pipeline this is resolved from named
%                       strings ("time","spect") by ec_contrast_perm before
%                       being passed here as numeric indices.
%       'voxelWeights'  per-voxel extent weights, same shape as the spatial
%                       reshape (i.e., featureSize(spatialDims)). Used as
%                       extent = sum(voxelWeights(idx)) instead of numel(idx)
%                       in the cluster integration. Default [] => uniform
%                       (pixel count). See Defaults below.
%
% ─── Defaults rationale (iEEG-leaning) ────────────────────────────────────
%
%   EXPONENTS H=2, E=0.5
%       The Smith & Nichols 2009 fMRI-3D defaults. Mensen & Khatami (2013,
%       J Neurosci Methods, "Advanced EEG analysis using threshold-free
%       cluster-enhancement") tested several values for 2-D EEG ERP/TF maps
%       and concluded H=2, E=0.5 remains a strong default. Some EEG groups
%       use E=2/3 ≈ 0.67; this slightly increases the relative weight of
%       larger contiguous clusters at the expense of fragmented ones.
%       Because iEEG HFB activity tends to be spatially fragmented (multiple
%       small foci in time-frequency rather than a single large blob),
%       lowering E (e.g., to 0.4) makes inference MORE sensitive to those
%       fragments at the cost of greater susceptibility to noise speckle.
%       Tune E based on whether your priority is contiguous low-frequency
%       effects (E ≈ 0.5–0.67) or fragmented HFB effects (E ≈ 0.4–0.5).
%
%   CONNECTIVITY = ROOK ("minimal")
%       In a time-frequency map, two diagonally-adjacent pixels share neither
%       a time bin nor a frequency bin. Their physical relationship is weaker
%       than orthogonal neighbors, so we exclude them from cluster formation
%       by default. Use opts.conn=conndef(max(2,K),"maximal") to recover the
%       8-/26-connectivity Smith & Nichols default.
%
%   LOG-SPACED FREQUENCY AXIS
%       For a uniformly-sampled log-frequency axis (e.g., n voices/octave)
%       paired with a uniform linear time axis, pixel count IS proportional
%       to (octaves x seconds). The "uniform pixel spacing" assumption in
%       standard TFCE refers to uniform topology (each pixel has the same
%       number of neighbors), not uniform physical spacing — and that holds
%       for log-uniform layouts. No reweighting is needed in this case;
%       voxelWeights can be left empty.
%
%       Set opts.voxelWeights only if you have non-uniform spacing within
%       the same axis (e.g., linear-spaced freq below 30 Hz transitioning
%       to log-spaced above, or irregular time binning). In that case build
%       a [nFreq x nTime] (or whichever spatial layout you have) matrix of
%       voxel "areas" in your physical units of choice.
%
%   PER-BAND H/E
%       Not implemented as an option. If you need different exponents for
%       different frequency bands, split the spatial map into bands, call
%       ec_tfce on each band with its own opts, and concatenate the results
%       before reshaping back. The trade-off is that each band's null
%       distribution is then independent, which loses some FWER power
%       compared to a single joint inference.
%
% ──────────────────────────────────────────────────────────────────────────
%
%   References:
%     Smith SM, Nichols TE (2009) Threshold-free cluster enhancement:
%       Addressing problems of smoothing, threshold dependence and
%       localisation in cluster inference. NeuroImage 44(1):83-98.
%     Mensen A, Khatami R (2013) Advanced EEG analysis using threshold-free
%       cluster-enhancement and non-parametric statistics. NeuroImage
%       67:111-118.
%
%   See also BWCONNCOMP, CONNDEF, EC_PERMUTTEST, EC_PERMUTTEST2.

%% Arguments validation
arguments
    stat {mustBeFloat,mustBeNonempty}
    featureSize (1,:) double {mustBeInteger,mustBePositive}
    opts.E (1,1) double {mustBePositive} = 0.5
    opts.H (1,1) double {mustBePositive} = 2
    opts.dh (1,1) double {mustBeNonnegative} = 0
    opts.conn = []
    opts.spatialDims double {mustBeInteger,mustBeNonnegative} = []
    opts.voxelWeights {mustBeNumeric} = []
end
if ~ismatrix(stat)
    error("[ec_tfce] STAT must be a 2-D [nVar x N] matrix.");
end
[nVar,N] = size(stat);
if nVar ~= prod(featureSize)
    error("[ec_tfce] size(STAT,1)=%d must equal prod(featureSize)=%d.",...
        nVar,prod(featureSize));
end

%% Resolve spatial vs panel dims
nFeatDims = numel(featureSize);
if isempty(opts.spatialDims)
    spatialDims = 1:nFeatDims;
else
    spatialDims = opts.spatialDims(:).';
    if any(spatialDims<1) || any(spatialDims>nFeatDims) || ~isequal(spatialDims,unique(spatialDims))
        error("[ec_tfce] spatialDims must be a unique subset of 1:%d.",nFeatDims);
    end
end
nonSpatial = setdiff(1:nFeatDims,spatialDims,"stable");
spatialSize = featureSize(spatialDims);
if isempty(nonSpatial)
    nonSpatSize = 1;
else
    nonSpatSize = featureSize(nonSpatial);
end
nSpat = prod(spatialSize);
nPanels = prod(nonSpatSize);

%% Default connectivity
K = numel(spatialDims);
if isempty(opts.conn)
    % iEEG-leaning default: rook adjacency (4-conn 2-D, 6-conn 3-D, chain 1-D).
    % MATLAB arrays are >=2-D (a length-d1 vector reshapes to [d1 x 1]),
    % so conn must match the reshape's ndims, not K.
    opts.conn = conndef(max(2,K),"minimal");
end

%% Validate voxelWeights
if ~isempty(opts.voxelWeights)
    expectedSz = spatialSize;
    if isscalar(expectedSz); expectedSz = [expectedSz 1]; end
    actualSz = size(opts.voxelWeights);
    if ~isequal(actualSz,expectedSz) && ~isequal(actualSz(actualSz>1),expectedSz(expectedSz>1))
        error("[ec_tfce] voxelWeights size [%s] must match spatialSize [%s].",...
            num2str(actualSz),num2str(expectedSz));
    end
    if any(opts.voxelWeights(:) < 0)
        error("[ec_tfce] voxelWeights must be non-negative.");
    end
    % Cast to match stat's class for downstream arithmetic.
    opts.voxelWeights = cast(opts.voxelWeights(:),"like",stat);  % flat [nSpat x 1]
end

%% Permute spatial dims to front so each panel sits in contiguous memory.
% When all feature dims are spatial (nonSpatial empty), no permutation is
% needed and we avoid building a permOrder that wouldn't match the array's
% dimensionality (permute requires ndims(A) <= numel(order)).
if isempty(nonSpatial)
    stat3 = reshape(stat,nSpat,1,N);                       % [nSpat x 1 x N]
    invPerm = [];                                          % sentinel: skip inverse permute
else
    stat3 = reshape(stat,[featureSize,N]);                 % [d1 ... dK N]
    permOrder = [spatialDims,nonSpatial,nFeatDims+1];
    stat3 = permute(stat3,permOrder);                      % spatial-major
    stat3 = reshape(stat3,nSpat,nPanels,N);                % [nSpat x nPanels x N]
    [~,invPerm] = sort(permOrder);
end

%% Per-panel, per-permutation TFCE (loop is unavoidable: bwconncomp scalar)
tfceFlat = zeros(nSpat,nPanels,N,"like",stat);
for n = 1:N
    for q = 1:nPanels
        col = stat3(:,q,n);
        if all(col==0|isnan(col))
            continue
        end
        S = reshape(col,spatialSize);
        tfceFlat(:,q,n) = reshape(tfceOne_lfn(S,opts),nSpat,1);
    end
end

%% Reshape back to caller's [nVar x N] layout
if isempty(invPerm)
    % No panels: tfceFlat is already in spatial-major order, just flatten.
    tfce = reshape(tfceFlat,nVar,N);
else
    tfceND = reshape(tfceFlat,[spatialSize,nonSpatSize,N]);
    tfceND = permute(tfceND,invPerm);
    tfce = reshape(tfceND,nVar,N);
end




function out = tfceOne_lfn(S,opts)
%%% Signed TFCE on a single map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out = zeros(size(S),"like",S);
% Positive part
Spos = max(S,0);
hMax = max(Spos,[],"all");
if hMax > 0
    out = out + integrate_lfn(Spos,double(hMax),opts);
end
% Negative part (enhance the magnitude, then subtract to preserve sign)
Sneg = max(-S,0);
hMax = max(Sneg,[],"all");
if hMax > 0
    out = out - integrate_lfn(Sneg,double(hMax),opts);
end


function out = integrate_lfn(P,hMax,opts)
%%% TFCE integral over thresholds for a non-negative map %%%%%%%%%%%%%%%%%%
out = zeros(size(P),"like",P);
if opts.dh > 0
    dh = opts.dh;
else
    dh = hMax/100;
end
hList = dh:dh:hMax;
if isempty(hList) || hList(end) < hMax
    hList = [hList,hMax];
end
useWeights = ~isempty(opts.voxelWeights);
for h = hList
    mask = P >= h;
    if ~any(mask,"all")
        continue
    end
    cc = bwconncomp(mask,opts.conn);
    for k = 1:cc.NumObjects
        idx = cc.PixelIdxList{k};
        if useWeights
            extent = sum(opts.voxelWeights(idx));
        else
            extent = numel(idx);
        end
        out(idx) = out(idx) + (h^opts.H) * (extent^opts.E) * dh;
    end
end
