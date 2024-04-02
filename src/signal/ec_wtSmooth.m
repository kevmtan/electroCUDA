function [cfs,H] = ec_wtSmooth(cfs,scales,ns)
%% [electroCUDA] smooth wavelet
% Taken from: wavelet.internal.cwt.smoothCFS

%#codegen

N = size(cfs,2);
npad = 2.^nextpow2(N);
isReal = isreal(cfs);

if (coder.gpu.internal.isGpuEnabled) % optimized for GPU coder
    N_1 = fix(npad/2);
    omega_tmp1= 1:N_1;
    omega_tmp2 = omega_tmp1.*((2*pi)/npad);
    omega_tmp3 =-omega_tmp2(fix((npad-1)/2):-1:1);
    omega = [0.0, omega_tmp2, omega_tmp3];
else
    omega = 1:fix(npad/2);
    omega = omega.*((2*pi)/npad);
    omega = [0.0, omega, -omega(fix((npad-1)/2):-1:1)];
end

cfsDFT = fft(cfs,npad,2);
c1 = length(scales);
c2 = length(omega);

if coder.gpu.internal.isGpuEnabled % fused Fmat computation for GPU coder
    Fmat = coder.nullcopy(zeros(c1, c2));
    coder.gpu.kernel;
    for j = 1:c2
        coder.gpu.kernel;
        for i = 1:c1
            Fmat(i, j) = exp(-0.5*((omega(j).*scales(i)).^2));
        end
    end
else
    sc = scales';
    Fmat = exp(-0.5*((sc.*omega).^2));
end

if isReal
    if isempty(coder.target)
        smooth = ifft(Fmat.*cfsDFT,[],2,'symmetric');
    else
        smooth = real(ifft(Fmat.*cfsDFT,[],2));
    end
else
    smooth = ifft(Fmat.*cfsDFT,[],2);
end

cfs = smooth(:,1:N);

% Convolve the coefficients with a moving average smoothing filter across
% scales
H = 1/ns*ones(ns,1);
cfs = conv2(cfs,H,'same');
