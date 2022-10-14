function chNfo = ec_mkChNfo(subjVar,saveDir,sbj,sbjID,gradVerts)
arguments
    subjVar struct
    saveDir {mustBeText}
    sbj {mustBeText}
    sbjID {mustBeNumeric} = []
    gradVerts table = []
end
if isempty(gradVerts); load("marguilesGradients_fsaverage.mat","gradVerts"); end

%% Initialize
chNfo = subjVar.elinfo;
chNfo.sbjID(:) = sbjID;
if height(chNfo) < numel(subjVar.channame)
    chNfo.sbjID(end+1:numel(subjVar.channame)) = sbjID;
elseif height(chNfo) > numel(subjVar.channame)
    chNfo(chNfo.ch==0,:) = [];
end
chNfo.sbjCh(:) = "s"+sbjID+"_ch"+chNfo.ch;
chNfo.channame = string(subjVar.channame);
chNfo.PTD = single(chNfo.PTD);
chNfo.GMvox = single(chNfo.GMvox);
chNfo.WMvox = single(chNfo.WMvox);
chNfo = movevars(chNfo, 'sbjCh', 'Before', 'ch');
try chNfo.Properties.RowNames = chNfo.sbjCh; catch; end

% Missing locs
idx = chNfo.pialVrt==0 & chNfo.infVrt==0 & ismissing(chNfo.lobe);
vars = ["PTD" "GMvox" "WMvox" "pialAvgVrt" "pialVrt" "infAvgVrt" "infVrt"];
chNfo{idx, vars} = nan;

vars = ["MNI" "pialRAS" "INF" "infRAS"];
chNfo{idx, vars} = nan(size(chNfo{idx,vars}));

%% Location info

% Channels with no hemisphere label
if any(~ismember(chNfo.hem,["L" "R"]))
    hemN = [nnz(chNfo.hem=="L") nnz(chNfo.hem=="R")];
    chNoHem = ~ismember(chNfo.hem,["L" "R"]);
    if hemN(1) >= hemN(2)
        chNfo.hem(chNoHem) = "L";
    else
        chNfo.hem(chNoHem) = "R";
    end
end

% Determine if medial/lateral
chNfo.lat(:) = "";
idx = ismember(chNfo.DK,[2 3 5 6 7 8 11 14 15 17 18 22 24 26 27 33]) |...
    (chNfo.DK==29 & abs(chNfo.MNI(:,1))<10);
chNfo.lat(idx) = "medial";
idx = ismember(chNfo.DK,[4 9 10 12 13 16 19 20 21 23 25 28 30 31 32 35 36]) |...
    (chNfo.DK==29 & abs(chNfo.MNI(:,1))>=10);
chNfo.lat(idx) = "lateral";
chNfo.lat(ismember(chNfo.DK,[0 34])|~chNfo.ECoG) = "both";
chNfo = movevars(chNfo,"lat","After","hem");

% Gradient
idxL = ~isnan(chNfo.pialAvgVrt) & chNfo.hem=="L";
idxR = ~isnan(chNfo.pialAvgVrt) & chNfo.hem=="R";
for g = 1:height(gradVerts)
    vn = "grad"+g;
    chNfo.(vn)(:) = nan;
    chNfo.(vn)(idxL) = gradVerts.L{g}(chNfo.pialAvgVrt(idxL));
    chNfo.(vn)(idxR) = gradVerts.R{g}(chNfo.pialAvgVrt(idxR));
end

% Yeo7
chNfo.Y7(:) = "";
chNfo.Y7(chNfo.Yeo7=="Somatomotor") = "SMN";
chNfo.Y7(chNfo.Yeo7=="Default") = "DMN";
chNfo.Y7(chNfo.Yeo7=="Limbic") = "Limbic";
chNfo.Y7(chNfo.Yeo7=="Frontoparietal") = "FPCN";
chNfo.Y7(chNfo.Yeo7=="Ventral Attention") = "VAN";
chNfo.Y7(chNfo.Yeo7=="Dorsal Attention") = "DAN";
chNfo.Y7(chNfo.Yeo7=="Visual") = "Visual";

% Yeo17
chNfo.Yeo17i = [];
chNfo.Yeo17 = uint8(double(extractAfter(chNfo.Yeo17,"_")));
chNfo.Y17(:) = "";
chNfo.Y17(chNfo.Yeo17==1) = "vis2";
chNfo.Y17(chNfo.Yeo17==2) = "vis1";
chNfo.Y17(chNfo.Yeo17==3) = "smn1";
chNfo.Y17(chNfo.Yeo17==4) = "smn2";
chNfo.Y17(chNfo.Yeo17==5) = "dan1";
chNfo.Y17(chNfo.Yeo17==6) = "dan2";
chNfo.Y17(chNfo.Yeo17==7) = "van1";
chNfo.Y17(chNfo.Yeo17==8) = "van2";
chNfo.Y17(chNfo.Yeo17==9) = "lim1";
chNfo.Y17(chNfo.Yeo17==10) = "lim2";
chNfo.Y17(chNfo.Yeo17==11) = "fp1";
chNfo.Y17(chNfo.Yeo17==12) = "fp2";
chNfo.Y17(chNfo.Yeo17==13) = "fp3";
chNfo.Y17(chNfo.Yeo17==14) = "dmn4";
chNfo.Y17(chNfo.Yeo17==15) = "dmn3";
chNfo.Y17(chNfo.Yeo17==16) = "dmn1";
chNfo.Y17(chNfo.Yeo17==17) = "dmn2";

chNfo = movevars(chNfo, {'sbjID','sbj','fsLabel','channame'}, 'After', 'Y17');
chNfo = movevars(chNfo, ["Y7" "Y17"], "After", "sulc");

%% Save
save([saveDir 'chNfo_' sbj '.mat'],'chNfo','-v7');
disp(['SAVED: ' saveDir 'chNfo_' sbj '.mat'])
end