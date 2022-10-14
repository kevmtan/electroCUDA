function ec_interpolateCh(sbj,dirs,bandN,projectN)

dirOut = [dirs.data_root '/robustData/' sbj '/' projectN '/'];

load([dirOut bandN '_' sbj '_' projectN '.mat'], 'HFB');
disp(['Loaded: ' dirOut bandN '_' sbj '_' projectN '.mat'])

% Get ch robust covariance
[chCov,chCovOrder] = chRobustCov(x,[]]);



% Interpolate
[toGood,fromGood] = KT_interpolate_bad_channels(x,chBad,chCovOrder,chCov,3);
x = x*(toGood*fromGood);

