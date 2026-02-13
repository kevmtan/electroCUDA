function [sbjNfo,chNfo,msg] = ec_mkChNfo_lbcn(sbj,proj,task,a)
arguments
    sbj char
    proj string
    task string
    a.redo (1,1) logical = false
    a.save (1,1) logical = true
end
% sbj='S14_74_OD'; proj="lbcn"; task="MMR"; a.redo=0; a.save=0;

%% Setup
sbjNfo=[]; chNfo=[]; msg=[]; %#ok<NASGU>
dirs = ec_getDirs(proj,task,sbj);
fsDir = char(dirs.freesurfer);
blocks = string(BlockBySubj(sbj,task));
load("parcellationIdx.mat","atlaz");
load("marguilesGradients_fsaverage.mat","gradVerts");

% Load globalVar
gvFn = struct2table(dir(dirs.origSbj));
gvFn = gvFn(~gvFn.isdir & startsWith(gvFn.name,'global'),:);
for i = 1:height(gvFn)
    load(fullfile(gvFn.folder{i},gvFn.name{i}),'globalVar');
    gvFn.nchan(i) = globalVar.nchan;
end
[nChs,i] = max(gvFn.nchan);
load(fullfile(gvFn.folder{i},gvFn.name{i}),'globalVar');
chsG = string(globalVar.channame)';
[~,~,datFmt] = GetFSdataFormat(sbj,globalVar.center);

% Load naming from google sheet
if strcmp(datFmt, 'edf') && ~strcmp(sbj, 'S17_118_TW')
    [DOCID,GID] = getGoogleSheetInfo('chan_names_ppt', 'chan_names_fs_figures');
else
    [DOCID,GID] = getGoogleSheetInfo('chan_names_ppt', 'chan_names_ppt_log');
end
gSheet = GetGoogleSpreadsheet(DOCID, GID);
if strcmp(sbj,'S14_78_RS')
    chsP = gSheet.('S14_78_RSa');
elseif strcmp(sbj,'S12_41_KS')
    chsP = readtable("s41.csv",ReadVariableNames=false);
elseif strcmp(sbj,'S16_95_JOB')
    chsP = readtable("s95.csv",ReadVariableNames=false);
else
    chsP = gSheet.(sbj);
end
if istable(chsP); chsP = chsP{:,1}; end
chsP = string(chsP);
chsP = chsP(chsP~="");
chsP1 = chsP;
nChP = height(chsP);

% sub2AvgBrain config
cfg.fsDir = char(dirs.freesurfer);
cfg.plotEm = 0;
cfg.outputTextfile = false;


%% Get anatomical info

% Proximal tissue density
ptd = ec_getPtdIndex(sbj,fsDir);
tmp = split(ptd.elec,"_");
nChF = height(ptd);
msg = "eegChs="+nChs+" pptChs="+nChP+" fsChs="+nChF;

% Fill
fsNfo = table;
fsNfo.ch(1:nChF) = nan;
fsNfo.fs = tmp(:,1);
fsNfo.hem = tmp(:,3);
fsNfo.lobe(:) = "";
fsNfo.gyrus = tmp(:,2)=="G";
fsNfo.ECoG(:) = false;
fsNfo.fsFull = ptd.elec;
fsNfo.PTD = ptd.PTD;
fsNfo.GMvox = ptd.GMvox;
fsNfo.WMvox = ptd.WMvox;

% Pial coordinates
cfg.isInf = false;
[~,~,fsNfo.ECoG,fsNfo.MNI,fsNfo.pialRAS,fsNfo.pialAvgVrt,fsNfo.pialVrt]=...
    ec_sub2AvgBrain(sbj,cfg);
fsNfo.ECoG = logical(fsNfo.ECoG);

% Inflated coordinates
cfg.isInf = true;
[~,~,~,fsNfo.INF,fsNfo.infRAS,fsNfo.infAvgVrt,fsNfo.infVrt]=...
    ec_sub2AvgBrain(sbj,cfg);

%% Anatomical parcellations

% Desikan_Killian
elecParc = ec_elec2Parc(sbj,'DK',fsDir);
if all(elecParc(:,1)==fsNfo.fs)
    fsNfo.anat = elecParc(:,2);
    fsNfo.DK = fsNfo.anat;
    fsNfo.DK = replace(fsNfo.DK,"Left-","");
    fsNfo.DK = replace(fsNfo.DK,"Right-","");
    fsNfo.DK = replace(fsNfo.DK,"ctx-lh-","");
    fsNfo.DK = replace(fsNfo.DK,"ctx-rh-","");

    for i = 1:36
        idx = fsNfo.DK==atlaz.DK_short(i);
        fsNfo.dk(idx) = atlaz.DK_index(i);
        fsNfo.lobe(idx) = atlaz.DK_lobe(i);
    end
else; warning("DK error for "+sbj);
end

% Destrieux
elecParc = ec_elec2Parc(sbj,'D',fsDir);
if all(elecParc(:,1)==fsNfo.fs)
    fsNfo.destrieux(:) = "";
    fsNfo.Destr = elecParc(:,2);
    for i = 1:75
        tmp = split(atlaz.D_short(i)," ")';
        idx = any(fsNfo.Destr==tmp,2);
        fsNfo.destr(idx) = atlaz.D_index(i);
        fsNfo.destrieux(idx) = atlaz.D_long(i);
    end
else; warning("Destrieux error for "+sbj);
end

% Yeo7
if a.redo; createIndivYeoMapping(sbj); end
elecParc = ec_elec2Parc(sbj,'Y7',fsDir);
if all(elecParc(:,1)==fsNfo.fs)
    fsNfo.Yeo7 = elecParc(:,2);
else; warning("Yeo7 error for "+sbj);
end

% Yeo17
elecParc = ec_elec2Parc(sbj,'Y17',fsDir);
if all(elecParc(:,1)==fsNfo.fs)
    fsNfo.Yeo17 = str2double(extractAfter(elecParc(:,2),"17Networks_"));
else; warning("Yeo17 error for "+sbj);
end

% HCP
if a.redo; createIndivHCPMapping(sbj); end
[elecParc,HCP] = ec_elec2Parc(sbj,'HCP',fsDir);
if all(elecParc(:,1)==fsNfo.fs)
    fsNfo.HCP = elecParc(:,2);
    fsNfo.hcpRGB(:,1:3) = uint8(0);
    HCP.name = string(HCP.name);
    HCP.RGB = uint8(HCP.RGB);
    for i = 1:height(HCP)
        idx = fsNfo.HCP==HCP.name(i);
        if ~nnz(idx); continue; end
        fsNfo(idx,'hcpRGB') = HCP(i,'RGB');
    end
    fsNfo.HCP = strrep(fsNfo.HCP,"_ROI","");
else; warning("HCP-MMP error for "+sbj);
end

% Medial/Lateral
idx = ismember(fsNfo.dk,[2 3 5 6 7 8 11 14 15 17 18 22 24 26 27 33]) |...
    (fsNfo.dk==29 & abs(fsNfo.MNI(:,1))<10);
fsNfo.lat(idx) = "medial";
idx = ismember(fsNfo.dk,[4 9 10 12 13 16 19 20 21 23 25 28 30 31 32 35 36]) |...
    (fsNfo.dk==29 & abs(fsNfo.MNI(:,1))>=10);
fsNfo.lat(idx) = "lateral";
fsNfo.lat(ismember(fsNfo.dk,[0 34])|~fsNfo.ECoG) = "both";
fsNfo = movevars(fsNfo,"lat","After","hem");

% Convert
fsNfo = convertvars(fsNfo,["PTD" "GMvox" "WMvox"],"single");
fsNfo = convertvars(fsNfo,["dk" "destr" "Yeo17"],"uint8");
fsNfo = convertvars(fsNfo,["pialVrt" "pialAvgVrt" "infVrt" "infAvgVrt" ],"uint32");
fsNfo = movevars(fsNfo,"fsFull","After",width(fsNfo));

% Deal with unequal chans
if nChs~=nChP; warning("[ec_mkChNfo_lbcn] "+sbj+": unequal EEG & PPT channels"); end
disp("[ec_mkChNfo_lbcn] "+sbj+": eegChs="+nChs+" pptChs="+nChP+" fsChs="+nChF)
if nChs>nChP
    chsP = vertcat(chsP,strings(nChs-nChP,1));
end


%% SubjVar
sbjNfo = struct;
sbjNfo.sbj = sbj;
sbjNfo.hz = floor(globalVar.iEEG_rate);
sbjNfo.hz_Pdio = floor(globalVar.Pdio_rate);
sbjNfo.nCh = nChs;
sbjNfo.nChPPT = nChP;
sbjNfo.nChFS = nChF;
sbjNfo.chs = chsG;
sbjNfo.chsPPT = chsP1;
sbjNfo.chsFS = fsNfo.fs;
sbjNfo.badChan = globalVar.badChan;
sbjNfo.refChan = globalVar.refChan;
sbjNfo.emptyChan = globalVar.emptyChan;
sbjNfo.epiChan = globalVar.epiChan;
sbjNfo.noisyChan = globalVar.noisyChan;
sbjNfo.susChan = globalVar.altBadChan;
sbjNfo.fsNfo = fsNfo;
sbjNfo.nBlocks = numel(blocks);
sbjNfo.blocks = blocks;
sbjNfo.center = globalVar.center;
sbjNfo.format = datFmt;
sbjNfo.dirs = dirs;
sbjNfo.demographics = GetDemographics(sbj);

%% Align EEG, freesurfer & powerpoint chans
chNfo = table;
chNfo.ch(1:nChs) = uint16(1:nChs)';
chNfo.fs = chsP;

% Find fs chans
for ch = uint16(1:height(chNfo))
    i = fsNfo.fs==chNfo.fs(ch);
    if ~any(i); continue; end
    fsNfo.ch(i) = ch;
end

% Sort and copy
fsNfo = sortrows(fsNfo,"ch","ascend");
sbjNfo.chsFS = fsNfo.fs;
sbjNfo.fsNfo = fsNfo;

% Copy to chNfo
tmp = fsNfo(fsNfo.ch>0,:);
i = string(tmp.Properties.VariableNames);
chNfo(tmp.ch,i) = tmp;

% Gradient
idxL = chNfo.pialAvgVrt>0 & chNfo.hem=="L";
idxR = chNfo.pialAvgVrt>0  & chNfo.hem=="R";
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

% Yeo
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

% Subject
chNfo.sbj(:) = string(sbj);
chNfo.sbjID(:) = uint16(dirs.sbjID);
chNfo.sbjCh = "s"+dirs.sbjID+"_ch"+chNfo.ch;
chNfo.name = chsG(1:height(chNfo));
chNfo.Properties.RowNames = chNfo.sbjCh;

% Missing locs
idx = ismissing(chNfo.hem) | chNfo.hem=="";
vars = ["PTD" "GMvox" "WMvox" "pialAvgVrt" "pialVrt" "infAvgVrt" "infVrt"];
chNfo{idx, vars} = nan;
vars = ["MNI" "pialRAS" "INF" "infRAS"];
chNfo{idx, vars} = nan(size(chNfo{idx,vars}));

% Finalize
chNfo = movevars(chNfo, "sbjID", "Before", "ch");
chNfo = movevars(chNfo,["sbj" "name"], 'After', 'Y17');
chNfo = movevars(chNfo, ["Y7" "Y17"], "After", "gyrus");


%% Save
if a.save
    fn = dirs.origSbj+"chNfo_s"+dirs.sbjID+"_"+task+".mat";
    save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
    fn = dirs.origSbj+"sbjNfo_s"+dirs.sbjID+"_"+task+".mat";
    save(fn,"sbjNfo","-v7"); disp("SAVED: "+fn)
end






