load("/01/lbcn/anal/chNfoA_260218.mat","chNfoA");

dirs = ec_loadSbj(proj="lbcn",task="MMR");
load("cdcol_2018.mat","cdcol");


%% Make plot data table
d = chNfoA;
d.bad = [];
d = renamevars(d,"MNI","pos");

% Non-ROI
d.marker(:) = "."; % marker shape/line style (string) -- see LineStyle in MATLAB line properties
d.col(:,1:3) = 0; % marker face color (numeric): [R G B]  -- see MarkerFaceColor in MATLAB line properties
d.bCol(:,1:3) = nan; % marker border color (numeric): [R G B] -- see MarkerEdgeColor in MATLAB line properties)
d.sz(:) = 6; % marker size (numeric) -- see MarkerSize in MATLAB line properties
d.bSz(:) = 0; % marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
d.order(:) = 0;

% ROI
id = d.roi~="";
d.marker(id) = "o";
d.sz(id) = 8;
d.order(id) = 1;

% Visual
id = d.roi=="Visual";
d.col(id,:) = repmat(cdcol.brown,nnz(id),1);

% TPJ
id = d.roi=="TPJ";
d.col(id,:) = repmat(cdcol.gold_cadmium_yellow,nnz(id),1);

% PCC
id = d.roi=="PCC";
d.col(id,:) = repmat(cdcol.spruce_green,nnz(id),1);

% ATL
id = d.roi=="ATL";
d.col(id,:) = repmat(cdcol.indian_red,nnz(id),1);

% amPFC
id = d.roi=="amPFC";
d.col(id,:) = repmat(cdcol.pastel_blue,nnz(id),1);

% dmPFC
id = d.roi=="dmPFC";
d.col(id,:) = repmat(cdcol.ultramarine,nnz(id),1);

% vmPFC
id = d.roi=="vmPFC";
d.col(id,:) = repmat(cdcol.purple_violet,nnz(id),1);


%% Plot

% Initialize figure
h = figure(Position=[0 0 1980 1080],Visible=1,WindowStyle="docked",...
    Theme="light",Color="w");

% Plot cortex
ec_plotCortex("L",["lateral","medial"],d,h,sbjDir=dirs.freesurfer,...
    surfType="pial_avg",opacity=0.9,pullF=15,visible=1,align=1,...
    labelVars="sbjCh",flip=true,order="ascend");



%% Scrap

% d.roi(:) = "";
% 
% % TPJ
% id = contains(d.HCP,"_PGs") | contains(d.HCP,"_PGi") | contains(d.HCP,"_PFm") |...
%     contains(d.HCP,"_PSL") | contains(d.HCP,"_STV") | contains(d.HCP,"_TPOJ1") |...
%     contains(d.HCP,"_TPOJ2") | contains(d.HCP,"_TPOJ3");
% d.roi(id) = "TPJ";
% 
% % PCC
% id = contains(d.HCP,"_POS1") | contains(d.HCP,"_POS2") | contains(d.HCP,"_7Pm") |...
%     contains(d.HCP,"_7m") | contains(d.HCP,"_v23ab") | contains(d.HCP,"_PCV") |...
%     contains(d.HCP,"_31pd") | contains(d.HCP,"_31pv") | contains(d.HCP,"_d23ab") |...
%     contains(d.HCP,"_31a") | contains(d.HCP,"_RSC");
% d.roi(id) = "PCC";
% 
% % ATL
% id = contains(d.HCP,"_STGa") | contains(d.HCP,"_TGd") | contains(d.HCP,"_TGv") |...
%     contains(d.HCP,"_STSda") | contains(d.HCP,"_STSva") | contains(d.HCP,"_TE1a") |...
%     (contains(d.HCP,"_TE2a") & d.MNI(:,2)>-19);
% d.roi(id) = "ATL";
% 
% % amPFC
% id = d.HCP=="L_a24" | d.HCP=="R_a24" | d.HCP=="L_p32" | d.HCP=="R_p32" |...
%     contains(d.HCP,"_10r") | (contains(d.HCP,"_10d") & abs(d.MNI(:,1))<=10);
% d.roi(id) = "amPFC";
% 
% % dmPFC
% id = contains(d.HCP,"_9m") | contains(d.HCP,"_d32") | contains(d.HCP,"_a32pr") |...
%     contains(d.HCP,"_8BM") | (contains(d.HCP,"_8BL") & abs(d.MNI(:,1))<=10);
% id(id) = d.MNI(id,2)>28;
% d.roi(id) = "dmPFC";
% %d.HCP=="L_p24" | d.HCP=="R_p24" | 
% 
% % vmPFC
% id = contains(d.HCP,"_OFC") | contains(d.HCP,"_25") | contains(d.HCP,"_s32") |...
%     contains(d.HCP,"_10v");
% d.roi(id) = "vmPFC";
% 
% % Corrections
% d.roi(ismember(d.sbjCh,["s33_ch97" "s47_ch17"])) = "amPFC";
% d.roi(ismember(d.sbjCh,["s53_ch68" "s33_ch1"])) = "dmPFC";
% d.roi(ismember(d.sbjCh,["s82_ch2" "s82_ch3" "s82_ch53" "s82_ch54"])) = ""; % ex-dmPFC


% d.col(d.roi=="ATL",:) = cdcol.scarlet;
% d.col(d.roi=="TPJ",:) = cdcol.gold_cadmium_yellow;
% d.col(d.roi=="PCC",:) = cdcol.emerald_green;
% d.col(d.roi=="amPFC",:) = cdcol.pastel_blue; 
% d.col(d.roi=="dmPFC",:) = cdcol.royal_blue; 
% d.col(d.roi=="vmPFC") = [.8 0 .8];

% cols = nan(size(chDatW, 1),3);
% for ch = 1:size(chDatW, 1)
%     mSz(ch) = markerSize;
%     shape{ch} = 'o';
%     bSz(ch) = .001;
%     if chDatW.KTroi(ch) == "visual"
%         cols(ch,:) = cdcol.brown; %cdcol.blue;
%     elseif chDatW.KTroi(ch) == "ATL"
%         cols(ch,:) = cdcol.scarlet; %cdcol.fast_orange;
%     elseif chDatW.KTroi(ch) == "TPJ"
%         cols(ch,:) = cdcol.gold_cadmium_yellow; %cdcol.fast_orange;
%     elseif chDatW.KTroi(ch) == "PMC"
%         cols(ch,:) = cdcol.emerald_green; %cdcol.emerald_green;
%     elseif chDatW.KTroi(ch) == "amPFC"
%         cols(ch,:) = cdcol.pastel_blue; %cdcol.light_cadmium_red;%pink;
%     elseif chDatW.KTroi(ch) == "dmPFC"
%         cols(ch,:) = cdcol.royal_blue; %carmine;%ruby_red;
%     elseif chDatW.KTroi(ch) == "vmPFC"
%         cols(ch,:) = [.8 0 .8]; %cdcol.light_purple; %cdcol.violet;
%     else
%         mSz(ch) = 3;
%         cols(ch,:) = [0 0 0];
%     end
% end
