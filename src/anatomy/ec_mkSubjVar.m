function [subjVar,subjVar_created] = ec_mkSubjVar(sbj,datFormat,dirs,isRedo)
if 0
    %% TEST
    sbj = 'S13_54_KDH'; %#ok<UNRCH>
    [~,~,datFormat] = GetFSdataFormat(sbj,'Stanford');
    [dirServer,dirComp,dirCode,dirFS] = AddPaths('Kevin_DMN');
    dirs = ec_getDirs('MMR',sbj,dirServer,dirComp,dirCode,dirFS);
    isRedo = false;
else % CHECK INPUTS
    if nargin<2; [~,~,datFormat] = GetFSdataFormat(sbj,'Stanford'); end
    if nargin<3
        [dirServer,dirComp,dirCode,dirFS] = AddPaths('Kevin_DMN');
        dirs = ec_getDirs('MMR',sbj,dirServer,dirComp,dirCode,dirFS);
    end
    if nargin<4; isRedo = false; end
end
sprintf('creating subjVar for subject %s', sbj);

%% Setup

% Load globalVar
gvDir = struct2table(dir([dirs.data filesep 'orig/' sbj]));
gvDir(gvDir.isdir|~startsWith(gvDir.name,'global'),:) = [];
load([gvDir.folder{1} filesep gvDir.name{1}],'globalVar');

% sub2AvgBrain config
cfg.fsDir = dirs.fsDir_local;
cfg.plotEm = 0;
cfg.outputTextfile = false;

% Initialize variables
subjVar = struct;
elinfo = table;
global globalFsDir; %#ok<GVMIS>
globalFsDir = dirs.fsDir_local;

%% Transform native to average elec coords

% Proximal tissue density
ptd = getPtdIndex_KT(sbj);
elinfo.ch(1:height(ptd)) = uint16(0);
elinfo.fsLabel = extractBefore(ptd.elec,"_");
elinfo.hem = extractAfter(extractAfter(ptd.elec,"_"),"_");
elinfo.lobe(:) = "";
elinfo.sulc = extractBetween(ptd.elec,"_","_");
elinfo.ECoG(:) = false;
elinfo.PTD = ptd.PTD;
elinfo.GMvox = ptd.GMvox;
elinfo.WMvox = ptd.WMvox;

% Pial
cfg.isInf = false;
[~,~,elinfo.ECoG,elinfo.MNI,elinfo.pialRAS,elinfo.pialAvgVrt,elinfo.pialVrt]=...
    sub2AvgBrain_KT(sbj,cfg);

% Inflated
cfg.isInf = true;
[~,~,~,elinfo.INF,elinfo.infRAS,elinfo.infAvgVrt,elinfo.infVrt]=...
    sub2AvgBrain_KT(sbj,cfg);

% Setup
elinfo.fsLabel = string(elinfo.fsLabel);
elinfo.hem = string(elinfo.hem);
elinfo.ECoG = logical(elinfo.ECoG);
fsChs = elinfo.fsLabel;
nChFS = height(elinfo);

%% Map electrode to brain atlases
[DOCID,GID] = getGoogleSheetInfo('chan_names_ppt', 'chan_names_ppt_log');
gSheet = GetGoogleSpreadsheet(DOCID, GID);
gSheet.DK_index = uint8(str2double(gSheet.DK_index));
gSheet.DK_short = string(gSheet.DK_short);
gSheet.DK_lobe = string(gSheet.DK_lobe);
gSheet.D_index = uint8(str2double(gSheet.D_index));
gSheet.D_short = string(gSheet.D_short);
gSheet.D_long = string(gSheet.D_long);
gSheet.Yeo7_index = uint8(str2double(gSheet.Yeo7_index));
gSheet.Yeo17_index = uint8(str2double(gSheet.Yeo17_index));

% Desikan_Killian
elecParc = string(ec_elec2Parc(sbj,'DK',0));
if all(elecParc(:,1)==elinfo.fsLabel)
    elinfo.Desikan_Killiany = elecParc(:,2);
    for i = 1:36
        idx = elinfo.Desikan_Killiany==gSheet.DK_short(i);
        elinfo.DK(idx) = gSheet.DK_index(i);
        elinfo.lobe(idx) = gSheet.DK_lobe(i);
    end
else; warning("DK error for "+sbj);
end

% Destrieux
elecParc = string(ec_elec2ParcT(sbj,'D',0));
if all(elecParc(:,1)==elinfo.fsLabel)
    elinfo.destrieux = elecParc(:,2);
    for i = 1:75
        idx = elinfo.destrieux==gSheet.D_short(i);
        elinfo.Destr(idx) = gSheet.D_index(i);
        elinfo.DestrL(idx) = gSheet.D_long(i);
    end
else; warning("Destrieux error for "+sbj);
end

% Yeo7
if isRedo; createIndivYeoMapping(sbj); end
elecParc = string(ec_elec2ParcT(sbj,'Y7',0));
if all(elecParc(:,1)==elinfo.fsLabel)
    elinfo.Yeo7 = elecParc(:,2);
    for i = 1:19
        idx = elinfo.Yeo7==gSheet.Yeo7_labels(i);
        elinfo.Yeo7i(idx) = gSheet.Yeo7_index(i);
    end
else; warning("Yeo7 error for "+sbj);
end

% Yeo17
elecParc = string(ec_elec2ParcT(sbj,'Y17',0));
elecParc = string(elecParc);
if all(elecParc(:,1)==elinfo.fsLabel)
    elinfo.Yeo17 = elecParc(:,2);
    for i = 1:19
        idx = elinfo.Yeo17==gSheet.Yeo17_labels(i);
        elinfo.Yeo17i(idx) = gSheet.Yeo17_index(i);
    end
else; warning("Yeo17 error for "+sbj);
end

% HCP
if isRedo; createIndivHCPMapping(sbj); end
[elecParc,HCP] = ec_elec2ParcT(sbj,'HCP',0);
elecParc = string(elecParc);
if all(elecParc(:,1)==elinfo.fsLabel)
    elinfo.HCP = elecParc(:,2);
    elinfo.hcpRGB(:,3) = uint8(0);
    HCP.name = string(HCP.name);
    HCP.RGB = uint8(HCP.RGB);
    for i = 1:height(HCP)
        idx = elinfo.HCP==HCP.name(i);
        if ~nnz(idx); continue; end
        elinfo(idx,'hcpRGB') = HCP(i,'RGB');
    end
    elinfo.HCP = strrep(elinfo.HCP,"_ROI","");
else; warning("HCP-MMP error for "+sbj);
end

%% Correct channel name

% Load naming from google sheet
if strcmp(datFormat, 'edf') && ~strcmp(sbj, 'S17_118_TW')
    [DOCID,GID] = getGoogleSheetInfo('chan_names_ppt', 'chan_names_fs_figures');
else
    [DOCID,GID] = getGoogleSheetInfo('chan_names_ppt', 'chan_names_ppt_log');
end
gSheet = GetGoogleSpreadsheet(DOCID, GID);
if strcmp(sbj,'S14_78_RS')
    pptChs = gSheet.('S14_78_RSa');
else
    pptChs = gSheet.(sbj);
end
pptChs = string(pptChs);
pptChs = pptChs(pptChs~="");

if strcmp(sbj, 'S17_117_MC')
    chan_comp = globalVar.channame;
    nchan_cmp = length(globalVar.channame);
else
    %globalVar=[];
    chan_comp = pptChs;
    nchan_cmp = length(pptChs);
end

% channels in EDF/TDT which are not in FS
% this could be because those channels were not recorded, but only implanted (EDF)
%               because somebody forgot to paste the correspondent .mat TDT file
%(this would indicate an error, and could potentially vary across block)
in_chan_cmp = false(1,nChFS);
for i = 1:nChFS
    in_chan_cmp(i) = ismember(fsChs(i),chan_comp);
end

in_fs = false(1,nchan_cmp);
for i = 1:nchan_cmp
    in_fs(i) = ismember(chan_comp(i),fsChs);
end

% See if number of channels matches
if sum(in_chan_cmp)==length(in_chan_cmp) && sum(in_fs)==length(in_fs)
    disp(['Equal channels freesurfer & iEEG: ' sbj]);
elseif sum(in_chan_cmp) < length(in_chan_cmp) && sum(in_fs) == length(in_fs)
    disp(['More channels in freesurfer: ' sbj]);
    fsChs = fsChs(in_chan_cmp);
    elinfo = elinfo(in_chan_cmp,:);
elseif sum(in_chan_cmp)==length(in_chan_cmp) && sum(in_fs)<length(in_fs)
    disp(['More channels in iEEG: ' sbj]);
    fs_chan_names_tmp = repmat("",nchan_cmp,1);
    fs_chan_names_tmp(in_fs) = fsChs;
    fs_chan_names_tmp(~in_fs) = chan_comp(~in_fs);
    fsChs = fs_chan_names_tmp;
    elinfoTmp = table;
    elinfoTmp.fsLabel = fsChs;
    elinfoTmp(in_fs,elinfo.Properties.VariableNames) = elinfo;
    elinfo = elinfoTmp;
elseif sum(in_chan_cmp)<length(in_chan_cmp) && sum(in_fs)<length(in_fs)
    disp(['Remove fs-only chans & add iEEG only chans: ' sbj]);
    disp('channels in EDF/TDT which are not in FS')
    disp(chan_comp(in_fs == 0));
    disp('channels in FS which are not in EDF/TDT')
    disp(fsChs(in_chan_cmp == 0));
    warning('this exception is not automatically fixable, please decide:')

    % Remove the FS which are not in EDF/TDT
    fsChs = fsChs(in_chan_cmp);
    elinfo = elinfo(in_chan_cmp,:);

    % Add the EDF/TDT which are not in FS
    fs_chan_names_tmp = repmat("",nchan_cmp,1);
    fs_chan_names_tmp(in_fs) = fsChs;
    fs_chan_names_tmp(~in_fs) = chan_comp(~in_fs);
    fsChs = fs_chan_names_tmp;
    elinfoTmp = table;
    elinfoTmp.fsLabel = fsChs;
    elinfoTmp(in_fs,elinfo.Properties.VariableNames) = elinfo;
    elinfo = elinfoTmp;

    % More than 1 empty channels at the end
    if ~in_fs(end)
        trailing_empty_count = length(in_fs)-find(in_fs,1,'last'); % in several cases there are more than 1 empty channels at the end, adding only one line of NaNs wasn't enough
        if height(elinfo)+trailing_empty_count > globalVar.nchan
            elinfo.fsLabel(end+1:end+trailing_empty_count,:) = "";
        end
    end
else
    error([sbj ': channel labels not fixed, please double check PPT/FS']);
end

% Reorder and save in subjVar
new_order = nan(1,nchan_cmp);
for i = 1:nchan_cmp
    tmp = find(ismember(fsChs, chan_comp(i)));
    if ~isempty(tmp)
        new_order(i) = tmp(1);
    end
end
elinfo = elinfo(new_order,:);

% Warn if inconsistent
if height(elinfo)~=globalVar.nchan
    warning([sbj ': height(elinfo)~=globalVar.nchan']);
    if height(elinfo)<globalVar.nchan
        elinfo.fsLabel(end+1:globalVar.nchan) = "";
    end
end

%% Gather info

% elinfo
elinfo.ch = uint16(1:globalVar.nchan)';
if height(elinfo)>globalVar.nchan; elinfo(elinfo.ch==0,:) = []; end
elinfo.sbj(:) = string(sbj);
% elinfo.badCh = ismember(elinfo.ch,globalVar.badChan);
% elinfo.refCh = ismember(elinfo.ch,globalVar.refChan);
% elinfo.emptyCh = ismember(elinfo.ch,globalVar.emptyChan);
% elinfo.epiCh = ismember(elinfo.ch,globalVar.epiChan);
% elinfo.susCh = ismember(elinfo.ch,globalVar.altBadChan);
% elinfo.noisyCh = ismember(elinfo.ch,globalVar.noisyChan);

% subjVar
subjVar.sbj_name = sbj;
subjVar.iEEG_rate = globalVar.iEEG_rate;
subjVar.Pdio_rate = globalVar.Pdio_rate;
subjVar.elinfo = elinfo;
subjVar.labels = chan_comp;
if isfield(globalVar,'channame'); subjVar.channame = globalVar.channame'; end
subjVar.nChs = height(elinfo);
subjVar.nchan = globalVar.nchan;
subjVar.badChan = globalVar.badChan;
subjVar.refChan = globalVar.refChan;
subjVar.emptyChan = globalVar.emptyChan;
subjVar.epiChan = globalVar.epiChan;
subjVar.noisyChan = globalVar.noisyChan;
subjVar.susChan = globalVar.altBadChan;

% Demographics
subjVar.demographics = GetDemographics(sbj);
if isempty(subjVar.demographics)
    warning(['There is no demographic info for ' sbj '. Please add it to the google sheet.']);
end

% Load cortical surface
try
    cortex = getcort(dirs);
    V = importVolumes(dirs);
    subjVar.cortex = cortex;
    subjVar.V = V;
catch ME; getReport(ME)
end

%% Save subjVar
if ~exist([dirs.origDat filesep sbj],'dir'); mkdir([dirs.origDat filesep sbj]); end

if exist([dirs.origDat filesep sbj filesep 'subjVar_' sbj '.mat'], 'file')
    save([dirs.origDat filesep sbj filesep 'subjVar_' sbj '.mat'], 'subjVar')
    disp(['Overwrote subjVar for ' sbj])
    subjVar_created = 1;
    %if isRedo
    %    save([dirs.origDat filesep sbj filesep 'subjVar_' sbj '.mat'], 'subjVar')
    %    disp(['Overwrote subjVar for ' sbj])
    %    subjVar_created = 1;
    %else
    %    warning(['subjVar NOT saved for ' sbj])
    %    subjVar_created = 0;
    %end
else
    save([dirs.origDat filesep sbj filesep 'subjVar_' sbj '.mat'], 'subjVar')
    disp(['subjVar saved for ' sbj])
    subjVar_created = 1;
end




