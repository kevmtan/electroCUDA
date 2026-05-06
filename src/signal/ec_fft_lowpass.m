function y = ec_fft_lowpass(x,n,passband,steepness,mask_full)
% FFT-based lowpass filter (zero-phase, temporally symmetrical)
% Filters over 1st dimension
%
% steepness — same meaning as MATLAB lowpass(...,'Steepness',s): scalar in
% [0.5, 1). Higher steepness => narrower transition band. Default 0.85.
% Transition width (Hz) is W = (0.99 - 0.98*s) * (fs/2 - passband), as in
% https://www.mathworks.com/help/signal/ref/lowpass.html
arguments
    x {mustBeFloat} % Input data, filters over 1st dimension
    n (1,1) % Subject/recording metadata (struct) or sampling rate (numeric)
    passband (1,1) double % Passband edge (hz)
    steepness (1,1) double ...
        {mustBeGreaterThanOrEqual(steepness,0.5),mustBeLessThan(steepness,1)} = 0.85
    mask_full = [] % Optional precomputed FFT mask (length=size(x,1))
end

%% Prep
szX = size(x);
xFrames = szX(1);
id = true(szX(end),1); % Index of last dim filter (e.g. freqs)

% Extract info from 'n' recording metadata struct
if isstruct(n)
    % Sampling rate
    if isfield(n,"hz0")
        fs = n.hz0; % ec_analPrep()/ec_epochPsy() pipeline
    else
        fs = n.hz; % default pipeline
    end

    % Indices of frequencies above passband to filter
    if numel(szX)>1 && szX(end)>1
        if isfield(n,"spect") && height(n.spect)==szX(end) &&...
                any(n.spect.Properties.VariableNames=="freq")
            id = n.spect.freq > passband;
        elseif isfield(n,"spect0") && height(n.spect0)==szX(end) &&...
                any(n.spect0.Properties.VariableNames=="freq")
            id = n.spect0.freq > passband;
        end
    end
elseif isnumeric(n) && isscalar(n) && ispositive(n)
    % Assume 'n' argument is sampling rate
    fs = double(n);
else
    error("2nd argument must be recording info struct 'n' or sampling rate in hz");
end

% Replace NaNs with zeros (invalidates FFT)
idnan = isnan(x);
x(idnan) = 0;


%% Construct filter (or use precomputed mask)
if isempty(mask_full)
    fNyquist = fs/2; % nyquist frequency
    fTrans = (0.99 - 0.98*steepness) * (fNyquist - passband); % transition bandwidth
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

    % Apply symmetrically to two-sided spectrum
    mask_full = [mask; flipud(mask(2:end-1))];  % mirror for negative freqs
    mask_full = mask_full(1:xFrames);           % handle odd/even n
else
    if numel(mask_full)~=xFrames
        error("Precomputed mask length (%d) must equal size(x,1) (%d)",...
            numel(mask_full),xFrames);
    end
    mask_full = reshape(mask_full,[],1);
    if isa(x,"gpuArray") && ~isa(mask_full,"gpuArray")
        mask_full = gpuArray(mask_full);
    elseif ~isa(x,"gpuArray") && isa(mask_full,"gpuArray")
        mask_full = gather(mask_full);
    end
    mask_full = cast(mask_full,like=x);
end


%% Apply filter to input data
if ~any(id)
    warning("electroCUDA:ec_fft_lowpass:NothingAbovePassband", ...
        "No frequency bins along the last dimension are above the passband edge (%.6g Hz); returning input unchanged.", ...
        passband);
    y = x;
elseif all(id)
    y = real(ifft(fft(x) .* mask_full));
else
    % Apply filter only to above-passband freqs in 'id', same as x(:,:,...,id)
    subs = repmat({':'}, 1, ndims(x));
    subs{end} = id;
    y = x;
    y(subs{:}) = real(ifft(fft(x(subs{:})) .* mask_full));
end

% Restore NaNs
y(idnan) = x(idnan);