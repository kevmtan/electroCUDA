sbjs = {'S12_38_LK','S12_42_NC','S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS',...
    'S12_39_RT','S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR','S15_87_RL',...
    'S16_95_JOB','S16_96_LF'}';
proj = "lbcn";
task = "MMR";


load("parcellationIdx.mat","atlaz");

%%
for s = 1:numel(sbjs)
    sbj = sbjs{s};
    disp("SUBJECT: "+sbj);
    chNfo = defineROI_lfn(sbj,proj,task,atlaz);
    chNfo.dist = [];
    chNfoA{s} = chNfo;
end

chNfoA = vertcat(chNfoA{:});



%% Main function
function chNfo = defineROI_lfn(sbj,proj,task,atlaz)

try
    [chNfo,dirs] = ec_loadSbj(sbj=sbj,proj=proj,task=task,vars="chNfo");
catch ME
    chNfo = [];
    disp(ME);
    return
end



end



%%
% % ATL
% chNfo.KTroi(strcmp(chNfo.Destr_ind,'35') | strcmp(chNfo.Destr_ind,'44') | chNfo.DK==34) = deal("ATL");
% chNfo.KTroi(chNfo.DK==7 & chNfo.MNI_coord(:,2)>-8) = deal("ATL");
% chNfo.KTroi(chNfo.DK==31 & chNfo.MNI_coord(:,2)>5) = deal("ATL"); %superior temporal
% chNfo.KTroi(chNfo.DK==16 & chNfo.MNI_coord(:,2)>0) = deal("ATL"); % middle temporal
%
% chNfo.KTroi(chNfo.sbjID=="34" & ismember(chNfo.ch,[14 18 19 64])) = deal("ATL");
% chNfo.KTroi(chNfo.sbjID=="46" & ismember(chNfo.ch,[65 66])) = deal("ATL"); %%%%
% chNfo.KTroi(chNfo.sbjID=="56" & ismember(chNfo.ch,[25:28])) = deal("ATL");
%
% %TPJ
% notTPJyeo17 = {'17Networks_1','17Networks_2','17Networks_5','17Networks_6','17Networks_12'};
% TPJinds = (ismember(chNfo.DK,[2 9 31 32]) & chNfo.MNI_coord(:,2)<=-40 & chNfo.MNI_coord(:,3)>= 0 & ~ismember(chNfo.Yeo17,notTPJyeo17));
% chNfo.KTroi(TPJinds) = deal("TPJ");
% %chNfo.KTroi(chNfo.sbjID=="34" & ismember(chNfo.ch,[73 74 75])) = deal("TPJ"); %%%
% chNfo.KTroi(chNfo.sbjID=="34" & ismember(chNfo.ch,[74 75])) = deal("TPJ");
% chNfo.KTroi(chNfo.sbjID=="38" & ismember(chNfo.ch,[36])) = deal("TPJ");
% chNfo.KTroi(chNfo.sbjID=="46" & ismember(chNfo.ch,[72])) = deal("TPJ");
%
% %PMC
% PMCinds = (ismember(chNfo.DK,[11 24 26]) & chNfo.MNI_coord(:,2)<=-30 & ~ismember(chNfo.Yeo17,{'17Networks_1','17Networks_2'}));
% chNfo.KTroi(PMCinds) = deal("PMC");
%
% %dmPFC
% chNfo.KTroi(ismember(chNfo.DK,[3 29]) & chNfo.MNI_coord(:,2)>=30) = deal("dmPFC"); %>=35
% chNfo.KTroi(chNfo.sbjID=="34" & ismember(chNfo.ch,52)) = deal("");
%
% %vmPFC
% chNfo.KTroi(ismember(chNfo.DK,[15 27 33])) = deal("vmPFC");
% chNfo.KTroi(chNfo.sbjID=="81" & ismember(chNfo.ch,[65 71 83])) = deal(""); % ultra early mOFC response
%
% % amPFC
% chNfo.KTroi(chNfo.sbjID=="33" & ismember(chNfo.ch,[17 97 98 99 100 101])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="34" & ismember(chNfo.ch,[53 54 55 88 89 90])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="38" & ismember(chNfo.ch,[99 100])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="42" & ismember(chNfo.ch,[66 67 68])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="46" & chNfo.ch == 33) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="47" & ismember(chNfo.ch,[17 18])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="53" & ismember(chNfo.ch,[116 117 118 119])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="60" & ismember(chNfo.ch,[97 98 99 100 105 106 107])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="76" & ismember(chNfo.ch,[4 5 6 7])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="78" & ismember(chNfo.ch,[33 34 35 41 42 43 44 150 151 152 153 154])) = deal("amPFC");
% chNfo.KTroi(chNfo.sbjID=="81" & ismember(chNfo.ch,[91 92])) = deal("amPFC");
%
% % Visual
% chNfo.KTroi(strcmp(chNfo.DK_lobe,'Occipital')) = deal("visual");
% chNfo.KTroi(ismember(chNfo.DK,[8 10]) & strcmp(chNfo.Yeo7,'Visual')) = deal("visual");
% chNfo.KTroi(chNfo.sbjID=="38" & ismember(chNfo.ch,[33 43])) = deal("visual");
% %chNfo.KTroi(chNfo.sbjID=="57" & ismember(chNfo.ch,[33 105:128])) = deal("visual");
% chNfo.KTroi(chNfo.sbjID=="57" & ismember(chNfo.ch,[33 105:127])) = deal("visual");
%
%
%
% TPJish
%
% Dest:
% S_intrapariet_and_P_trans
% G_pariet_inf-Angular
% S_interm_prim-Jensen
%
% Yep17 lateral parietal:
% 17/16/15/13
% ----
%
% DK
% bankssts - 2
% superiortemporal - 31
% middletemporal - 16 (y < 40)
% inferiorparietal - 9
% supramarginal - 32
%
% Not these:
% MNI_coord(:,2)<=-30
% MNI_coord(:,3)>0
% not yeo17_1, yeo17_2, yeo17_5, yeo17_6, yeo17_12
%
% ----
% dmPFC
% chDataAll.KTroi(chDataAll.DK == 29 & chDataAll.MNI_coord(:,2)>6) = deal("dmPFC");
% chDataAll.KTroi(chDataAll.DK == 3 & chDataAll.MNI_coord(:,2)>6) = deal("dmPFC");
% & chDataAll.MNI_coord(:,2)>30 (34 at SANS)
%
% visual
% ----
% occipital DKlobb not Yeo which is surface based not native
%
% 36 = [58 60 61 62 63 64]
% 38 = [33 41* 42* 43 49* 50* 57* 58* 65* 81* 105 106]
% 42 = [33 34 35* 41 42 43*]
% 46 = [44 45 46 47* 48* 61 62*]
% 47 = [49 50]
% 53 = 9
% 56 = [81 89]
% 57 = [1* 2 3 4 5 33 105:126]
% 60 = [65:70 81:86]
% 76 = [121 122*]
% 83 = [10:16 24:32]
% 96 = [1 2 9 10 17* 18* 25 26* 27*];
%
%
% --
% PMC
%
% DK = 11 24 26 (y <-30)
% Not these: yeo_1, yeo_2
% --
% vmPFC
%
% DK = 15,27,33
%
% amPFC::::::::::::::
% chDatF.KTroi(chDatF.sbj=="33" & ismember(chDatF.ch,[97 98 99 100 101])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="34" & ismember(chDatF.ch,[52 53 54 55 88 89])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="38" & ismember(chDatF.ch,[99 100])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="42" & ismember(chDatF.ch,[66 68])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="46" & ismember(chDatF.ch,[33])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="47" & ismember(chDatF.ch,[17 18])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="53" & ismember(chDatF.ch,[116 117 118 119])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="60" & ismember(chDatF.ch,[97 98 99 100 105 106 107])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="76" & ismember(chDatF.ch,[4 5 6 7])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="78" & ismember(chDatF.ch,[33 34 35 41 42 43 44 150 151 152 153 154])) = deal("amPFC");
% chDatF.KTroi(chDatF.sbj=="81" & ismember(chDatF.ch,[92 93])) = deal("amPFC");
%
%
% chDatF.KTroi(chDatF.sbj=="81" & ismember(chDatF.ch,[65 71 83])) = deal("");
