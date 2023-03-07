load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc_221103_2015_errors.mat')
pre5_iEEG;
cd("/home/kt/Gdrive/Git/ec_pipeline")
try parfevalOnAll(@gpuDevice,0,[]); catch;end
try reset(gpuDevice(1)); catch;end
try delete(gcp('nocreate')); catch;end
close all;
stats1_summaryStatsPerSbj;

