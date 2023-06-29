sbj_names = {'S13_60_DY','S12_38_LK','S12_42_NC','S13_46_JDB','S12_33_DA','S12_34_TC',...
    'S12_35_LM','S12_36_SrS','S12_39_RT','S12_40_MJ',...
    'S12_41_KS','S12_45_LR','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
    'S16_95_JOB','S16_96_LF'}';
%sbj_names = {'S12_38_LK','S12_42_NC'};

conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"];
projectN = 'MMR';

o = struct;
o.fnString = 'evAvg_220613';
o.band = 'rHFB';
o.BLpre = [-.2 0]; %[-0.1 0]; % baseline before stim onset
o.BLend = []; %[-0.1 0]; % baseline before next stim onset
o.trL = 3.009;
o.smWin = 0.05; % smoothing gaussian width in secs
o.rmBadCh = true;
o.decimate = false;
o.fsTarg = 1000;
o.clustSize = 0.05; % secs
o.minAnalSize = 20;
o.timeBins = 0.01; % secs
o.noiseFields = {'HFO'};%{'HFO','raw_jump','diff_jump'}; % ['HFO','raw_HF_spike']
o.outlierCenter = 'median';
o.OLthr = 3; %[5 5]; % Lower and upper quantiles for outlier
o.missingInterp = 'linear';
o.k = 12; % Max Number of clustering components across timepoints
o.bin2 = 75; % an.bin2 (reduced unique bins) must be divisible by this variable
o.binP_max = 100;

% Preallocate
if ~exist('sbjStatus','var')
    sbjStatus = table;
    sbjStatus.sbj = sbj_names;
    sbjStatus.stats(:) = nan;
    sbjStatus.plot(:) = nan;
    sbjStatus.error = cell(numel(sbj_names),2);
    sbjStatus.errorFn = cell(numel(sbj_names),1);
    sbjStatus.complete(:) = false;
end
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/evoked/logs/'...
    o.fnString char(datetime('now','TimeZone','local','Format','_HHmm')) '_errors.mat'];

%load('evRobLME_220401_0813_errors.mat')
%sbjFinFn = '/home/kevin/Google Drive/UCLA/Studies/MMR/anal/evoked/logs/evSTblc_220419_0044__errors.mat';

%% Loop
pathsDMN('lbcn')
for s = 1:height(sbjStatus) %find(complete==0|isnan(complete))
    sbj = sbjStatus.sbj{s};
    blocks = BlockBySubj(sbj,projectN);

    if sbjStatus.complete(s)
        continue
    else
        try delete(gcp('nocreate')); catch; end
    end

    % Statistical analysis
    if sbjStatus.stats(s)~=1
        try
            [sbjStatus.stats(s),sbjStatus.plot(s),sbjStatus.errorFn{s}] =...
                evokeAvg3_lme(sbj,blocks,projectN,o);
        catch ME
            warning(['DID NOT COMPLETE: ' sbj])
            sbjStatus.error{s,1} = ME;
            getReport(ME)
        end
    end

    if sbjStatus.stats(s)==1 && sbjStatus.plot(s)==1
        sbjStatus.complete(s) = true;
        disp(['::: FINISHED ' sbj ' :::']);
    end

    % Save sbj log
    save(sbjFinFn,'sbjStatus','-v7');
end

try delete(gcp('nocreate')); catch; end

%% Concactenate
if ~exist('o','var')
    o.fnString = 'evAvg_220613';
end
cd(['/proj/lbcn/d/Results/stats/' o.fnString '/dat/']);
fnLat = strsplit(string(ls(['*_latency_' o.fnString '.mat'])))';
fnPct = strsplit(string(ls(['*_pctRT_' o.fnString '.mat'])))';
fnLat(fnLat=="") = []; fnPct(fnPct=="") = [];

% Load
aLat = table; aPrt = table;
for s = 1:height(fnLat)
    load(fnLat(s),"latS");
    load(fnPct(s),"pctS");

    if isempty(aLat)
        aLat = latS;
    else
        aLat = [aLat;latS]; %#ok<AGROW> 
    end

    if isempty(aPrt)
        aPrt = pctS;
    else
        aPrt = [aPrt;pctS]; %#ok<AGROW> 
    end
end

% Organize latA
aLat.Properties.RowNames = aLat.sbjCh+": "+aLat.latency+"ms";
if ~any(aLat.Properties.VariableNames=="ch")
    aLat.ch = uint8(str2double(extractAfter(aLat.sbjCh,"ch")));
    aLat = movevars(aLat,"ch","After","sbjID");
end
if ~any(aLat.Properties.VariableNames=="ms")
    aLat.Properties.VariableNames{'latency'} = 'ms';
end
aLat = movevars(aLat, 'sbjCh', 'After', width(aLat));
aLat = sortrows(aLat,["sbjID" "ch" "ms"]);

% Organize pctA
aPrt.Properties.RowNames = aPrt.sbjCh+": "+(double(aPrt.pct)./10)+"%";
if ~any(aPrt.Properties.VariableNames=="ch")
    aPrt.ch = uint8(str2double(extractAfter(aPrt.sbjCh,"ch")));
    aPrt = movevars(aPrt,"ch","After","sbjID");
end
aPrt = sortrows(aPrt,["sbjID" "ch" "pct"]);
aPrt = movevars(aPrt, 'sbjCh', 'After', width(aPrt));

% Convert datatype for smaller file sizes
idx = contains(aLat.Properties.VariableNames,("_SE"|"_p"|"_q"));
aLat = convertvars(aLat,idx,'single');
aLat.sbjID = uint8(aLat.sbjID);
aLat.ms = int16(aLat.ms);

idx = contains(aPrt.Properties.VariableNames,("_SE"|"_p"|"_q"));
aPrt = convertvars(aPrt,idx,'single');
aPrt.sbjID = uint8(aPrt.sbjID);

% Save
save(['/proj/lbcn/d/Results/stats/' o.fnString '/latA_' o.fnString '.mat'],'aLat','-v7');
save(['/proj/lbcn/d/Results/stats/' o.fnString '/pctA_' o.fnString '.mat'],'aPrt','-v7');

%%
if ~exist('o','var')
    o.fnString = 'evAvg_220613';
end
cd(['/proj/lbcn/d/Results/stats/' o.fnString]);

sbjDirs = struct2table(dir);
sbjDirs = convertvars(sbjDirs,["name" "folder"],"string");
sbjDirs(~startsWith(sbjDirs.name,"s") | ~sbjDirs.isdir,:) = [];

trs = table; chs = table;
for s = 1:height(sbjDirs)
    try fn = strtrim(ls(sbjDirs.folder(s)+"/"+sbjDirs.name(s)+"/*_misc.mat"));
    catch; warning(num2str(s)); continue;
    end
    load(fn,"trialNfo","chNfo");
    if isempty(trs); trs = trialNfo;
        else; trs = [trs;trialNfo]; %#ok<AGROW> 
    end
    if isempty(chs); chs = chNfo;
    else; chs = [chs;chNfo]; %#ok<AGROW> 
    end
end

trs = convertvars(trs,["sbjID" "r2"],"uint8");
chs = convertvars(chs,["sbjID" "ch"],"uint8");

save(['/proj/lbcn/d/Results/stats/' o.fnString '/trs_' o.fnString '.mat'],'trs','-v7');
save(['/proj/lbcn/d/Results/stats/' o.fnString '/chs_' o.fnString '.mat'],'chs','-v7');

%%
% %% Concactenate subjects
% plotO = ecu_genPlotParams('MMR','timecourse');
% avgLat = cell(height(sbjStatus),1);
% avgPct = cell(height(sbjStatus),1);
% 
% 
% for s = 1:height(sbjStatus)
%     if ~sbjStatus(s,:).complete; continue; end
%     %%
%     sbj = sbjStatus(s,:).sbj{1};
%     sbjID = string(extractBetween(sbj,"_","_"));
%     dirs = InitializeDirs(projectN, sbj, server_root, comp_root, code_root, fsDir_local);
%     dirSave = [dirs.result_root '/stats/' o.fnString '/s' num2str(sbjID) '/']; 
%     sbjLat = load(string(dirSave)+sbjID+"_latency_"+o.fnString+".mat","sbjLat");
%     sbjLat = sbjLat.sbjLat;
%     sbjPct = load(string(dirSave)+sbjID+"_pctRT_"+o.fnString+".mat","sbjPct");
%     sbjPct = sbjPct.sbjPct;
%     sbjChs = unique(sbjLat.sbjCh,"stable");
% 
%     %% FDR per ch 
%     for ch = 1:numel(sbjChs)
%         sbjCh = sbjChs(ch);
%         idxL = sbjLat.sbjCh==sbjCh;
%         idxP = sbjPct.sbjCh==sbjCh;
%         for ii = 1:2
%             if ii==1
%                 sbjLat(idxL,:) = doFDR(sbjLat(idxL,:),conds,sbjID,false);
%             else
%                 sbjPct(idxP,:) = doFDR(sbjPct(idxP,:),conds,sbjID,false);
%             end
%         end
%     end
% 
%     %% All ch FDR
%     for ii = 1:2
%         if ii==1
%             sbjLat = doFDR(sbjLat,conds,sbjID,true);
%         else
%             sbjPct = doFDR(sbjPct,conds,sbjID,true);
%         end
%     end
% 
%     %% Cluster correct
%     for ch = 1:numel(sbjChs)
%         sbjCh = sbjChs(ch);
%         idxL = sbjLat.sbjCh==sbjCh;
%         sbjLat(idxL,:) = clustCorrectLocal(sbjLat(idxL,:),conds,o);
%         disp(sbjCh+": cluster correct")
%     end
%     avgLat{s} = sbjLat;
%     avgPct{s} = sbjPct;
%     
% end
% 
% %% Save
% dirs = InitializeDirs(projectN, sbjStatus.sbj(1), server_root, comp_root, code_root, fsDir_local); 
% 
% avgLat = vertcat(avgLat{:});
% avgPct = vertcat(avgPct{:});
% avgLat.ch = uint16(str2double(extractAfter(avgLat.sbjCh,"ch")));
% avgPct.ch = uint16(str2double(extractAfter(avgPct.sbjCh,"ch")));
% avgLat = sortrows(avgLat,["sbjID" "ch" "latency"]);
% avgPct = sortrows(avgPct,["sbjID" "ch" "pct"]);
% 
% save([dirs.result_root '/stats/' o.fnString '/avgLat_' extractAfter(o.fnString,'_') '.mat'],'avgLat');
% save([dirs.result_root '/stats/' o.fnString '/avgPct_' extractAfter(o.fnString,'_') '.mat'],'avgPct');
% 
% 
% %% Subfunctions
% 
% function dat = doFDR(dat,conds,sbjID,isRepeat)
% %% FDR and organize trial info
% for c = 1:length(conds)
%     cond = conds(c);
%     disp(sbjID+" "+cond+": FDR");
%     dat.(cond+"_hA")(:) = false;
%     dat.(cond+"_hD")(:) = false;
%     if ~isRepeat
%         dat.(cond+"_q") = dat.(cond+"_p");
%     else
%         dat.(cond+"_q")(dat.(cond+"_q")>1) = 1;
%     end
% 
%     [hFDR,~,~,dat.(cond+"_q")] = fdr_bh(dat.(cond+"_q"),0.05,'pdep','no');
%     dat.(cond+"_hA")(dat.(cond+"_b")>0) = hFDR(dat.(cond+"_b")>0);
%     dat.(cond+"_hD")(dat.(cond+"_b")<0) = hFDR(dat.(cond+"_b")<0);
%     if isRepeat
%         dat.(cond+"_q") = single(dat.(cond+"_q"));
%     end
% end
% end
% 
% 
% function chLat = clustCorrectLocal(chLat,conds,o)
% %% Find contiguous clusters of significance
% numConds = numel(conds);
% clustSz = floor(o.clustSize / o.timeBins);
% 
% for c = 1:numConds
%     cond = conds(c);
% 
%     % Active
%     sigs = contiguousKT(chLat.(cond+"_hA"),true);
%     sigIdx = [];
%     for s = 1:height(sigs)
%         if sigs.sz(s)<clustSz; continue; end
%         sigIdx = [sigIdx, sigs.idx(s,1):sigs.idx(s,2)]; %#ok<AGROW>
%     end
%     h = false(height(chLat),1);
%     if ~isempty(sigIdx)
%         h(sigIdx) = true;
%     end
%     chLat.(cond+"_hA") = h;
% 
%     % Deactive
%     sigs = contiguousKT(chLat.(cond+"_hD"),true);
%     sigIdx = [];
%     for s = 1:height(sigs)
%         if sigs.sz(s)<clustSz; continue; end
%         sigIdx = [sigIdx, sigs.idx(s,1):sigs.idx(s,2)]; %#ok<AGROW>
%     end
%     h = false(height(chLat),1);
%     if ~isempty(sigIdx)
%         h(sigIdx) = true;
%     end
%     chLat.(cond+"_hD") = h;
% end
% end
% 
% 
% function plotChLocal(chLat,chPct,conds,dirSave,plotO,o) %#ok<DEFNU> 
% tic
% 
% sbjCh = chLat.sbjCh(1);
% numConds = numel(conds);
% lineprops = struct;
% lineprops.style= ':';
% lineprops.width = 2;
% lineprops.edgestyle = ':';
% 
% disp("FIGURE: "+sbjCh);
% fig = figure('Position',[0 0 1280 1280],'MenuBar','none','ToolBar','none','visible','off');
% tiledlayout(fig,2,1,'TileSpacing','compact','Padding','compact');
% for ii = 1:2
%     nexttile
%     if ii==1
%         dat = chLat; 
%     else
%         dat = chPct;
%         dat.latency = dat.pct;
%     end
% 
%     lats = unique(dat.latency)';
%     lats = repmat(lats,numel(conds),1);
% 
%     y = nan(numel(conds),length(lats));
%     ySE = y;
%     ySig = y;
%     for c = 1:numConds
%         cond = conds(c);
%         lineprops.col{c} = plotO.col(c,:);
%         idxP = find(ismember(lats(c,:),dat.latency));
%         idxSig = dat.(cond+"_hA") | dat.(cond+"_hD");
%         y(c,idxP) = dat.(cond+"_b");
%         ySig(c,idxP) = dat.(cond+"_b");
%         ySig(c,idxP(~idxSig)) = nan;
%         ySE(c,idxP) = dat.(cond+"_SE");
%     end
%     mseb(lats,y,ySE,lineprops);
%     hold on
%     axis tight
%     lgd = legend(conds);
%     lgd.AutoUpdate = 'off';
% 
%     for c = 1:length(conds)
%         plot(lats(c,:), ySig(c,:),'LineWidth',4,'color',plotO.col(c,:));
%     end
%     plot([0 0],ylim,'k-','LineWidth',3)
%     plot(xlim,[0 0],'k-','LineWidth',3)
%     if ii==1
%         title(sbjCh,'Interpreter','none');
%         xlabel('Latency (ms)')
%     else
%         xlabel('Latency/RT (%)')
%     end
%     ylabel('HFB power coefficient (beta)')    
%     set(gca,'fontsize',plotO.textsize)
% end
% 
% imgFn = dirSave+sbjCh+"_"+o.fnString+".jpg";
% exportgraphics(fig,imgFn)
% toc
% end
