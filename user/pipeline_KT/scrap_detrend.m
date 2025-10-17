nh = load('nh_s38_MMR.mat','n');
nh = nh.n;
xh = load('xh_s38_MMR.mat','x');
xh = xh.x;
xh = mat2cell(xh,nh.runIdxOg(:,2));

hpfHz = 1;
hpf = designfilt('highpassfir',StopbandFrequency=hpfHz*0.5,PassbandFrequency=hpfHz,...
    PassbandRipple=0.1,DesignMethod="kaiserwin",SampleRate=nh.fs);
hpf1 = hpf.Coefficients;

%%
xh1 = xh{1}(:,[96 106]); tic;
xh1c = hpf.filtfilt(xh1); toc


%%
tic;
xh1g = ecc_filtfilt2_mex64(xh1,hpf1); toc


%%
load('n_s38_MMR.mat','n');
load('x_s38_MMR.mat','x');
x = mat2cell(x,n.runIdxOg);
%%

x1 = x{1}; tic;
x11 = ecc_cwt_mex64(x1,n.fs,[1 300],10,10); toc


%%
ord = 10;

%%
W1 = nan(n.nFrames,ord+1,'like',x);
lin = linspace(-1,1,n.nFrames);
for k = 1:ord
    W1(:,k) = lin.^k;
end
W1 = [ones(n.nFrames,1) W1];

%%
W = prepareRegressors(0,1:n.nFrames,ord,n.nFrames);

%%
function W = prepareRegressors(bp,samples,polyDeg,N)

% Normalize to avoid numerical issues
if isempty(samples)
    a = samples;
    scaleS = samples;
else
    scaleS = samples(end);
    if scaleS == 0
        a = samples;
    else
        a = samples./scaleS;
    end
end

% Build regressor
b = a - (bp./scaleS)';
b = max(b,0);
W = b(:).^(polyDeg:-1:1);
W = [reshape(W,N,[]), ones(N,1)];
W = cast(W,'like',polyDeg); %MOD1
end