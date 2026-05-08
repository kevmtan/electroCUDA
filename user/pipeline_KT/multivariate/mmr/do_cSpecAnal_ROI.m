% oFns = [
%     "/01/lbcn/anal/classifySpecCh/zf_50ms_SemEpi_LR_lambda/o_zf_50ms_SemEpi_LR_lambda.mat",...
%     "/01/lbcn/anal/classifySpecCh/zf_50ms_MathAb_LR_lambda/o_zf_50ms_MathAb_LR_lambda.mat",...
%     "/01/lbcn/anal/classifySpecCh/zf_50ms_SemEpi_LDA_gamma/o_zf_50ms_SemEpi_LDA_gamma.mat",...
%     "/01/lbcn/anal/classifySpecCh/zf_50ms_MathAb_LDA_gamma/o_zf_50ms_MathAb_LDA_gamma.mat"
%     ];
oFns = "/01/lbcn/anal/classifySpecROI/zf_hpfBands_50ms_SemEpi_LDA_gamma/o_zf_hpfBands_50ms_SemEpi_LDA_gamma.mat";


%% Analysis options
oa = struct;
oa.timeVar="latency";
oa.statFn="statLatency";


%% Loop across runs
for io = 1:numel(oFns)
    % Load
    load(oFns(io),"o");

    %% Run post-analysis on classification run
    mmr_cSpecAnal_ROI(o,oa);
end