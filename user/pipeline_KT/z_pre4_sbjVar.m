sbjs = {'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_38_LK','S12_39_RT','S12_40_MJ',...
    'S12_41_KS','S12_42_NC','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
    'S15_87_RL','S16_95_JOB','S16_96_LF'}';
%sbjs = {'S13_51_MTL','S14_74_OD'}';

%%
proj = 'lbcn';
task = 'MMR';
center = 'Stanford';
isRedo = 0;
correction_factor = 5;
plotChs = 0;

pathsDMN('lbcn')
[dirServer,dirComp,dirCode,dirFS] = AddPaths('Kevin_DMN');

%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/preproc/logs/sbjVar_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('statusSV','var')
    statusSV = table;
    statusSV.sbj = sbjs;
    statusSV.error = cell(height(statusSV),1);
    statusSV.errorCh = cell(height(statusSV),1);
    statusSV.errorPlot = cell(height(statusSV),1);
    statusSV.sv(:) = nan; % = nan(length(sbjs),2);
    statusSV.ch(:) = nan;
end
statusT = cell(height(statusSV),1);
for s = 1:height(statusSV)
    statusT{s} = statusSV(s,:);
end

load("marguilesGradients_fsaverage.mat","gradVerts");

chNfoA = cell(height(statusSV),1);
% global globalFsDir; %#ok<GVMIS>
% globalFsDir = dirFS;

try parpool('local2',ceil(length(sbjs)/2)); catch; end
%try parpool('local4',12); catch; end

%% Subject loop
%for s = 14
parfor s = 1:length(sbjs)
    % sbj = 'S12_38_LK';
    sbj = sbjs{s};
    sbjID = uint16(str2double(extractBetween(sbj,"_","_")));
    dirs = ec_getDirs(proj,sbj,task,dirServer,dirComp,dirCode,dirFS);
    datFormat = GetFSdataFormat(sbj,center);
    block_names = BlockBySubj(sbj,task);
    saveDir = [dirs.origDat filesep sbj filesep];
    statusS = statusT{s};

    %% Create SubjVar
    if statusS.sv~=1; disp(['SKIPPING: ' sbj]); continue; end
    try
        [subjVar,statusS.sv] = ec_mkSubjVar(sbj,datFormat,dirs,isRedo);
        if subjVar.nChs~=subjVar.nchan
            warning(['subjVar.nChs~=subjVar.nchan for: ' sbj]);
            statusS.error = {'subjVar.nChs~=subjVar.nchan'};
        end
    catch ME; warning(['subjVar error for: ' sbj]); getReport(ME)
        statusS.sv = 0;
        statusS.error = ME; continue;
    end

    %% Create chNfo
    try
        chNfo = ec_mkChNfo(subjVar,saveDir,sbj,sbjID,gradVerts);
        chNfoA{s} = chNfo;
        statusS.ch = 1;
    catch ME; warning(['subjVar error for: ' sbj]); getReport(ME)
        statusS.ch = 0;
        statusS.errorCh = ME;
    end

    %% Plot electrodes
    if plotChs
        try PlotCoverageElect_KT(subjVar,correction_factor,1,dirs.anal); %#ok<UNRCH> 
        catch ME; warning(['subjVar plot error for: ' sbj]); getReport(ME)
            warning(['subjVar plot error for: ' sbj])
            statusS.errorPlot = ME;
        end
    end

    %% Copy status
    statusT{s} = statusS;
    %try statusSV{s,:} = statusS; catch; statusT{s} = statusS; end
end

%% Save status
statusSV = vertcat(statusT{:});
save(sbjFinFn,'statusSV','-v7');

%%
chNfoA = vertcat(chNfoA{:});
%try delete(gcp('nocreate')); catch; end

%% Depreciated
% function chNfo = mkChNfo_lfn(sbj,subjVar,sbjID,gradL,gradR,gradLims,saveDir)
% chNfo = subjVar.elinfo;
% chNfo.sbjID(:) = sbjID;
% if height(chNfo) < numel(subjVar.channame)
%     chNfo.sbjID(end+1:numel(subjVar.channame)) = sbjID;
% elseif height(chNfo) > numel(subjVar.channame)
%     chNfo(chNfo.ch==0,:) = [];
% end
% chNfo.sbjCh(:) = "s"+sbjID+"_ch"+chNfo.ch;
% chNfo.channame = string(subjVar.channame);
% chNfo.PTD = single(chNfo.PTD);
% chNfo.GMvox = single(chNfo.GMvox);
% chNfo.WMvox = single(chNfo.WMvox);
% chNfo = movevars(chNfo, 'sbjCh', 'Before', 'ch');
% try chNfo.Properties.RowNames = chNfo.sbjCh; catch; end
% 
% % Channels with no hemisphere label
% if any(~ismember(chNfo.hem,["L" "R"]))
%     hemN = [nnz(chNfo.hem=="L") nnz(chNfo.hem=="R")];
%     chNoHem = ~ismember(chNfo.hem,["L" "R"]);
%     if hemN(1) >= hemN(2)
%         chNfo(chNoHem).hem = "L";
%     else
%         chNfo(chNoHem).hem = "R";
%     end
% end
% 
% % Determine if medial/lateral
% chNfo.lat(:) = "";
% idx = ismember(chNfo.DK,[2 3 5 6 7 8 11 14 15 17 18 22 24 26 27 33]) |...
%     (chNfo.DK==29 & abs(chNfo.MNI(:,1))<10);
% chNfo.lat(idx) = "medial";
% idx = ismember(chNfo.DK,[4 9 10 12 13 16 19 20 21 23 25 28 30 31 32 35 36]) |...
%     (chNfo.DK==29 & abs(chNfo.MNI(:,1))>=10);
% chNfo.lat(idx) = "lateral";
% chNfo.lat(ismember(chNfo.DK,[0 34])|~chNfo.ECoG) = "both";
% chNfo = movevars(chNfo,"lat","After","hem");
% 
% % Gradient
% chNfo.grad1(:) = deal(nan);
% chNfo.grad1s(:) = deal(nan);
% for ch = 1:height(chNfo)
%     if chNfo.pialAvgVrt(ch)>0
%         if chNfo.hem(ch)=="L"
%             chNfo.grad1(ch) = gradL(chNfo.pialAvgVrt(ch));
%         elseif chNfo.hem(ch)=="R"
%             chNfo.grad1(ch) = gradR(chNfo.pialAvgVrt(ch));
%         end
%     end
% end
% chNfo.grad1s = rescale(chNfo.grad1,0,100,'InputMin',gradLims(1),'InputMax',gradLims(2));
% chNfo = movevars(chNfo,["grad1s" "grad1"], "Before", "MNI");
% 
% % Yeo7
% chNfo.Y7(:) = "";
% chNfo.Y7(chNfo.Yeo7=="Somatomotor") = "SMN";
% chNfo.Y7(chNfo.Yeo7=="Default") = "DMN";
% chNfo.Y7(chNfo.Yeo7=="Limbic") = "Limbic";
% chNfo.Y7(chNfo.Yeo7=="Frontoparietal") = "FPCN";
% chNfo.Y7(chNfo.Yeo7=="Ventral Attention") = "VAN";
% chNfo.Y7(chNfo.Yeo7=="Dorsal Attention") = "DAN";
% chNfo.Y7(chNfo.Yeo7=="Visual") = "Visual";
% 
% % Yeo17
% chNfo.Yeo17 = uint8(double(extractAfter(chNfo.Yeo17,"_")));
% chNfo.Y17i = chNfo.Yeo17i;
% chNfo.Y17i(chNfo.Y17i==1) = 19;
% chNfo.Y17i = chNfo.Y17i - 1;
% chNfo.Y17(:) = "";
% chNfo.Y17(chNfo.Y17i==1) = "vis2";
% chNfo.Y17(chNfo.Y17i==2) = "vis1";
% chNfo.Y17(chNfo.Y17i==3) = "smn1";
% chNfo.Y17(chNfo.Y17i==4) = "smn2";
% chNfo.Y17(chNfo.Y17i==5) = "dan1";
% chNfo.Y17(chNfo.Y17i==6) = "dan2";
% chNfo.Y17(chNfo.Y17i==7) = "van1";
% chNfo.Y17(chNfo.Y17i==8) = "van2";
% chNfo.Y17(chNfo.Y17i==9) = "ls1";
% chNfo.Y17(chNfo.Y17i==10) = "ls2";
% chNfo.Y17(chNfo.Y17i==11) = "fp1";
% chNfo.Y17(chNfo.Y17i==12) = "fp2";
% chNfo.Y17(chNfo.Y17i==13) = "fp3";
% chNfo.Y17(chNfo.Y17i==14) = "dmn4";
% chNfo.Y17(chNfo.Y17i==15) = "dmn3";
% chNfo.Y17(chNfo.Y17i==16) = "dmn1";
% chNfo.Y17(chNfo.Y17i==17) = "dmn2";
% 
% % Finalize & save
% chNfo = movevars(chNfo, {'sbjID','sbj','fsLabel','channame'}, 'After', 'Y17');
% chNfo = movevars(chNfo, ["Y7" "Y17"], "After", "sulc");
% save([saveDir 'chNfo_' sbj '.mat'],'chNfo');
% disp(['SAVED: ' saveDir 'chNfo_' sbj '.mat'])
% end