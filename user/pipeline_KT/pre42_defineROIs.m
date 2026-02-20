sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";...
    "S12_40_MJ";"S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";...
    "S13_50_LGM";"S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";...
    "S13_57_TVD";"S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";...
    "S14_74_OD";"S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";...
    "S15_83_RR";"S15_87_RL";"S16_95_JOB";"S16_96_LF"];
proj = "lbcn";
task = "MMR";
%load("parcellationIdx.mat","atlaz");


%% Main
chNfoA = cell(numel(sbjs),1); % preallocate

% Subject loop
for s = 1:numel(sbjs)
    chNfoA{s} = defineROI_lfn(sbjs(s),proj,task);
end


%% Finalize
chNfoA = vertcat(chNfoA{:});

fn = "/01/lbcn/anal/chNfoA_"+string(datetime('now','TimeZone','local','Format','yyMMdd'));
save(fn,"chNfoA","-v7"); disp("SAVED: "+fn)


%% Main function
function chNfo = defineROI_lfn(sbj,proj,task)
try
    [chNfo,dirs] = ec_loadSbj(sbj=sbj,proj=proj,task=task,vars="chNfo");
catch ME
    chNfo = [];
    disp(ME);
    return
end


%%
chNfo.roi(:) = "";

% Visual
id = (contains(chNfo.HCP,"_V") & ~contains(chNfo.HCP,"_VIP")) |...
    contains(chNfo.HCP,"_ProS") | contains(chNfo.HCP,"_LO") |...
    contains(chNfo.HCP,"_FFC") | chNfo.HCP=="R_PH" | chNfo.HCP=="L_PH" |...
    contains(chNfo.HCP,"_FST") | contains(chNfo.HCP,"_MST") | contains(chNfo.HCP,"_MT") |...
    contains(chNfo.HCP,"_LO3") | contains(chNfo.HCP,"_IP0") | contains(chNfo.HCP,"_IPS1") |...
    contains(chNfo.HCP,"_PIT") | contains(chNfo.HCP,"_LO1") | contains(chNfo.HCP,"_LO2");
chNfo.roi(id) = "Visual";

% TPJ
id = contains(chNfo.HCP,"_PGs") | contains(chNfo.HCP,"_PGi") | contains(chNfo.HCP,"_PFm") |...
    contains(chNfo.HCP,"_STV") | contains(chNfo.HCP,"_TPOJ1") | contains(chNfo.HCP,"_TPOJ2") |...
    contains(chNfo.HCP,"_TPOJ3") | (contains(chNfo.HCP,"_PSL") & chNfo.MNI(:,2)<-44);
chNfo.roi(id) = "TPJ";

% PCC
id = contains(chNfo.HCP,"_POS1") | contains(chNfo.HCP,"_POS2") | contains(chNfo.HCP,"_7Pm") |...
    contains(chNfo.HCP,"_7m") | contains(chNfo.HCP,"_v23ab") | contains(chNfo.HCP,"_PCV") |...
    contains(chNfo.HCP,"_31pd") | contains(chNfo.HCP,"_31pv") | contains(chNfo.HCP,"_d23ab") |...
    contains(chNfo.HCP,"_31a") | contains(chNfo.HCP,"_RSC");
chNfo.roi(id) = "PCC";

% ATL
id = contains(chNfo.HCP,"_STGa") | contains(chNfo.HCP,"_TGd") | contains(chNfo.HCP,"_TGv") |...
    contains(chNfo.HCP,"_STSda") | contains(chNfo.HCP,"_STSva") | contains(chNfo.HCP,"_TE1a") |...
    (contains(chNfo.HCP,"_TE2a") & chNfo.MNI(:,2)>-19);
chNfo.roi(id) = "ATL";

% amPFC
id = chNfo.HCP=="L_a24" | chNfo.HCP=="R_a24" |...
    chNfo.HCP=="L_p32" | chNfo.HCP=="R_p32" | contains(chNfo.HCP,"_10r") |...
    (contains(chNfo.HCP,"_10d") & chNfo.MNI(:,3)<=9 & abs(chNfo.MNI(:,1))<12);
chNfo.roi(id) = "amPFC";

% dmPFC
id = contains(chNfo.HCP,"_9m") | contains(chNfo.HCP,"_d32") | contains(chNfo.HCP,"_a32pr") |...
    ((contains(chNfo.HCP,"_9p") | contains(chNfo.HCP,"_9a")) & abs(chNfo.MNI(:,1))<12) |...
    (contains(chNfo.HCP,"_10d") & chNfo.MNI(:,3)>9 & abs(chNfo.MNI(:,1))<12) |...
    contains(chNfo.HCP,"_8BM") | (contains(chNfo.HCP,"_8BL"));
%chNfo.HCP=="L_p24" | chNfo.HCP=="R_p24" | 
id(id) = chNfo.MNI(id,2) > 28;
chNfo.roi(id) = "dmPFC";

% vmPFC
id = contains(chNfo.HCP,"_OFC") | contains(chNfo.HCP,"_25") | contains(chNfo.HCP,"_s32") |...
    contains(chNfo.HCP,"_10v");
chNfo.roi(id) = "vmPFC";

% Corrections
chNfo.roi(ismember(chNfo.sbjCh,["s33_ch97" "s47_ch17"])) = "amPFC";
chNfo.roi(ismember(chNfo.sbjCh,["s53_ch68" "s33_ch1"])) = "dmPFC"; % ex-dmPFC
chNfo.roi(ismember(chNfo.sbjCh,["s59_ch50" "s59_ch51" "s59_ch52"])) = ""; % ex-TPJ, not in brain sEEG?
chNfo.roi(ismember(chNfo.sbjCh,["s82_ch2" "s82_ch3" "s82_ch53" "s82_ch54"])) = "";


%% ROI groups
chNfo.roiGrp(:) = "";

% Visual
chNfo.roiGrp(chNfo.roi=="Visual") = "Visual";

% Temporoparietal DMN (tpDMN)
chNfo.roiGrp(ismember(chNfo.roi,["ATL" "TPJ" "PCC"])) = "tpDMN";

% Medial Prefrontal Cortex (mPFC)
chNfo.roiGrp(ismember(chNfo.roi,["dmPFC" "amPFC" "vmPFC"])) = "mPFC";


%% Finalize

% Organize
chNfo = movevars(chNfo,["ECoG" "roi" "roiGrp"],"After","gyrus");

% Save
fn = dirs.procSbj+"chNfo_s"+dirs.sbjID+"_"+task;
save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
end



%% Scrap

% % ATL
% chNfo.roi(ismember(chNfo.destr,[35 44]) | chNfo.dk==34) = deal("ATL");
% chNfo.roi(chNfo.dk==7 & chNfo.MNI(:,2)>-8) = deal("ATL");
% chNfo.roi(chNfo.dk==31 & chNfo.MNI(:,2)>5) = deal("ATL"); %superior temporal
% chNfo.roi(chNfo.dk==16 & chNfo.MNI(:,2)>0) = deal("ATL"); % middle temporal
% chNfo.roi(chNfo.sbjID==34 & ismember(chNfo.ch,[14 18 19 64])) = deal("ATL");
% chNfo.roi(chNfo.sbjID==46 & ismember(chNfo.ch,[65 66])) = deal("ATL"); %%%%
% chNfo.roi(chNfo.sbjID==56 & ismember(chNfo.ch,25:28)) = deal("ATL");
% 
% % TPJ
% TPJinds = (ismember(chNfo.dk,[2 9 31 32]) & chNfo.MNI(:,2)<=-40 & chNfo.MNI(:,3)>= 0 &...
%     ~ismember(chNfo.Yeo17,[1 2 5 6 12]));
% chNfo.roi(TPJinds) = deal("TPJ");
% %chNfo.roi(chNfo.sbjID==34 & ismember(chNfo.ch,[73 74 75])) = deal("TPJ"); %%%
% chNfo.roi(chNfo.sbjID==34 & ismember(chNfo.ch,[74 75])) = deal("TPJ");
% chNfo.roi(chNfo.sbjID==38 & ismember(chNfo.ch,36)) = deal("TPJ");
% chNfo.roi(chNfo.sbjID==46 & ismember(chNfo.ch,72)) = deal("TPJ");
% 
% % PCC
% PCCinds = (ismember(chNfo.dk,[11 24 26]) & chNfo.MNI(:,2)<=-30 & ~ismember(chNfo.Yeo17,[1 2]));
% chNfo.roi(PCCinds) = deal("PCC");
% 
% % vmPFC
% chNfo.roi(ismember(chNfo.dk,[15 27 33]) & chNfo.lat=="medial") = deal("vmPFC");
% chNfo.roi(chNfo.sbjID==81 & ismember(chNfo.ch,[65 71 83])) = deal(""); % ultra early mOFC response
% 
% % dmPFC
% chNfo.roi(ismember(chNfo.dk,[3 29]) & chNfo.MNI(:,2)>=30 & chNfo.lat=="medial")...
%     = deal("dmPFC"); %>=35
% chNfo.roi(chNfo.sbjID==75 & ismember(chNfo.ch,37)) = deal("dmPFC");
% %chNfo.roi(chNfo.sbjID==34 & ismember(chNfo.ch,52)) = deal("");
% 
% % amPFC
% chNfo.roi(chNfo.sbjID==33 & ismember(chNfo.ch,[97 98 99 100 101])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==34 & ismember(chNfo.ch,[53 54 55 88 89 90])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==38 & ismember(chNfo.ch,[99 100])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==41 & ismember(chNfo.ch,[123 124])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==42 & ismember(chNfo.ch,[66 67 68])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==46 & chNfo.ch == 33) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==47 & ismember(chNfo.ch,[17 18])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==52 & ismember(chNfo.ch,[115 123 124])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==53 & ismember(chNfo.ch,[116 117 118 119])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==60 & ismember(chNfo.ch,[97 98 99 100 105 106 107])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==75 & ismember(chNfo.ch,[35 36])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==76 & ismember(chNfo.ch,[4 5 6 7])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==78 & ismember(chNfo.ch,[33 34 35 41 42 43 149 150 151 152 153 154])) = deal("amPFC");
% chNfo.roi(chNfo.sbjID==81 & ismember(chNfo.ch,[91 92])) = deal("amPFC");
% 
% % Visual
% chNfo.roi(chNfo.lobe=="Occipital") = deal("Visual");
% chNfo.roi(ismember(chNfo.dk,[8 10]) & chNfo.Y7=="Visual") = deal("Visual");
% chNfo.roi(chNfo.sbjID==38 & ismember(chNfo.ch,[33 43])) = deal("Visual");
% chNfo.roi(chNfo.sbjID==57 & ismember(chNfo.ch,[33 105:127])) = deal("Visual");
% %chNfo.roi(chNfo.sbjID=="57" & ismember(chNfo.ch,[33 105:128])) = deal("Visual");



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
% chDataAll.roi(chDataAll.dk == 29 & chDataAll.MNI(:,2)>6) = deal("dmPFC");
% chDataAll.roi(chDataAll.dk == 3 & chDataAll.MNI(:,2)>6) = deal("dmPFC");
% & chDataAll.MNI(:,2)>30 (34 at SANS)
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
% chDatF.roi(chDatF.sbj=="33" & ismember(chDatF.ch,[97 98 99 100 101])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="34" & ismember(chDatF.ch,[52 53 54 55 88 89])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="38" & ismember(chDatF.ch,[99 100])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="42" & ismember(chDatF.ch,[66 68])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="46" & ismember(chDatF.ch,[33])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="47" & ismember(chDatF.ch,[17 18])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="53" & ismember(chDatF.ch,[116 117 118 119])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="60" & ismember(chDatF.ch,[97 98 99 100 105 106 107])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="76" & ismember(chDatF.ch,[4 5 6 7])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="78" & ismember(chDatF.ch,[33 34 35 41 42 43 44 150 151 152 153 154])) = deal("amPFC");
% chDatF.roi(chDatF.sbj=="81" & ismember(chDatF.ch,[92 93])) = deal("amPFC");
%
%
% chDatF.roi(chDatF.sbj=="81" & ismember(chDatF.ch,[65 71 83])) = deal("");
