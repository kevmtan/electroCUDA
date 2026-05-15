function [y, mask_full, passbandOut] = ec_fft_lowpass(x,n,passband,steepness,mask_full,o)
% FFT-based lowpass filter (zero-phase, temporally symmetrical)
% Filters over 1st dimension
%
% [y, mask_full, passbandOut] = ec_fft_lowpass(..., o)
%   passbandOut — passband edge (Hz) for the mask and spect.freq logic: when
%   o.antialiasing>0, min(passbandIn, aliasband) if passbandIn>0, else aliasband
%   (AA-only); otherwise passbandIn.
%
%   Optional 2nd output is the full-length FFT multiplier (column, length
%   size(x,1)). Use o.maskOnly=true to skip filtering and only compute
%   mask_full (y is then x unchanged; NaNs in x are not modified).
%
% steepness — same meaning as MATLAB lowpass(...,'Steepness',s): scalar in
% [0.5, 1). Higher steepness => narrower transition band. Default 0.85.
% Transition width (Hz) is W = (0.99 - 0.98*s) * (fs/2 - passband), as in
% https://www.mathworks.com/help/signal/ref/lowpass.html
%
% o.antialiasing — target output sampling rate (Hz) for the AA solve; 0 = off.
%   ec_epochPreproc passes o.antialiasing (future downsample rate if decimation is later). When > 0, aliasband
%   solves so the cosine roll-off ends at that rate's Nyquist. Final passband
%   = min(passband input, aliasband) when passbandIn>0, else aliasband.
arguments
    x {mustBeFloat} % Input data, filters over 1st dimension
    n (1,1) % Subject/recording metadata (struct) or sampling rate (numeric)
    passband (1,1) double % Requested passband edge (hz)
    steepness (1,1) double ...
        {mustBeGreaterThanOrEqual(steepness,0.5),mustBeLessThan(steepness,1)} = 0.85
    mask_full = [] % Optional precomputed FFT mask (length=size(x,1))
    o.antialiasing (1,1) double = 0 % Target Fs (Hz) for AA cutoff; 0 = use passband as given
    o.maskOnly (1,1) logical = false % If true, only build mask + passbandOut; y = x unchanged
end

%% Prep
szX = size(x);
xFrames = szX(1);
passbandIn = passband;

% Sampling rate
if isstruct(n)
    if isfield(n,"hz0")
        fs = n.hz0; % ec_analPrep()/ec_epochPsy() pipeline
    else
        fs = n.hz; % default pipeline
    end
elseif isnumeric(n) && isscalar(n) && ispositive(n)
    fs = double(n);
else
    error("2nd argument must be recording info struct 'n' or sampling rate in hz");
end

%% Construct filter (or use precomputed mask)
if ~isany(mask_full) || numel(mask_full)~=xFrames
    fNyquist = fs/2; % nyquist frequency

    if o.antialiasing > 0
        targetNyq = o.antialiasing / 2;

        if targetNyq >= fNyquist
            % target_fs >= input_fs: no downsampling, AA not needed
            k = 0.99 - 0.98 * steepness;
            passband = passbandIn;
        else
            % Steepness is treated as a suggestion in AA mode. The highest
            % steepness without cosine-taper ringing is data-driven:
            %   aliasband = targetNyq - min_fTrans  (analytical)
            %   k_opt = min_fTrans / (fNyquist - targetNyq + min_fTrans)
            % min_fTrans = max(1 FFT bin, 10% of targetNyq) ensures the
            % taper spans at least one frequency bin and leaves >=90% passband.
            fRes = fs / xFrames;
            min_fTrans = max(fRes, 0.1 * targetNyq);
            k_opt = min_fTrans / (fNyquist - targetNyq + min_fTrans);
            s_aa = min(0.99, (0.99 - k_opt) / 0.98);
            k = 0.99 - 0.98 * s_aa;  % recompute from clamped steepness
            aliasband = (targetNyq - k * fNyquist) / (1 - k);
            if aliasband <= 0
                % Only reachable for extreme ratios (>~50:1) where s=0.99
                % still can't clear targetNyq; use 90% fallback.
                aliasband = 0.9 * targetNyq;
                warning("electroCUDA:ec_fft_lowpass:AntialiasingFallback", ...
                    "%.1f→%.1f Hz AA (%.1fx ratio): steepness=0.99 still yields " + ...
                    "negative aliasband; using aliasband=%.3g Hz " + ...
                    "(transition extends past target Nyquist).", ...
                    fs, o.antialiasing, fs/o.antialiasing, aliasband);
            end
            % passbandIn<=0: AA-only; else stricter of user LPF vs AA
            if passbandIn > 0
                passband = min(passbandIn, aliasband);
            else
                passband = aliasband;
            end
        end
    else
        k = 0.99 - 0.98 * steepness;
        passband = passbandIn;
    end

    % Transition width uses finalized passband and effective k
    fTrans = k * (fNyquist - passband);
    freqs = (0:floor(xFrames/2)) * (fs/xFrames);

    % Cosine-tapered mask
    mask = ones(length(freqs),1,like=x);
    in_trans = freqs>=passband & freqs<=passband+fTrans;
    if fTrans > 0
        mask(in_trans) = 0.5 * (1 + cos(pi * (freqs(in_trans) - passband) / fTrans));
        mask(freqs>passband+fTrans) = 0;
    else
        mask(freqs>=passband) = 0;
    end

    % Apply symmetrically to two-sided spectrum (even vs odd N differs by one bin)
    if mod(xFrames,2)==0
        mask_full = [mask; flipud(mask(2:end-1))];
    else
        mask_full = [mask; flipud(mask(2:end))];
    end
    assert(numel(mask_full)==xFrames,"ec_fft_lowpass:maskLen",...
        "Internal error: mask length %d != xFrames %d",numel(mask_full),xFrames);
else
    assert(numel(mask_full)==xFrames,"ec_fft_lowpass:maskLen",...
        "Internal error: mask length %d != xFrames %d",numel(mask_full),xFrames);
    mask_full = reshape(mask_full,[],1);
    mask_full = cast(mask_full,like=x); % class + gpuArray placement match x
    passband = passbandIn;
end

passbandOut = passband;

% Last-dim inclusion for temporal LPF vs spect.freq (uses finalized passband)
id = true(szX(end),1);
if isstruct(n) && numel(szX)>1 && szX(end)>1
    if isfield(n,"spect") && height(n.spect)==szX(end) &&...
            any(n.spect.Properties.VariableNames=="freq")
        id = n.spect.freq > passband;
    elseif isfield(n,"spect0") && height(n.spect0)==szX(end) &&...
            any(n.spect0.Properties.VariableNames=="freq")
        id = n.spect0.freq > passband;
    end
end

if o.maskOnly
    y = x;
    return;
end

% Replace NaNs with zeros (invalidates FFT)
idnan = isnan(x);
x(idnan) = 0;


%% Apply filter to input data
if ~any(id)
    warning("electroCUDA:ec_fft_lowpass:NothingAbovePassband", ...
        "No frequency bins along the last dimension are above the passband edge (%.6g Hz); returning input unchanged.", ...
        passband);
    y = x;
elseif all(id)
    y = real(ifft(fft(x) .* mask_full));
else
    % Intentional: temporal LPF only on last-dim slices where id is true (e.g. spect.freq > passband)
    subs = repmat({':'}, 1, ndims(x));
    subs{end} = id;
    y = x;
    y(subs{:}) = real(ifft(fft(x(subs{:})) .* mask_full));
end

% Restore NaNs
y(idnan) = nan;
