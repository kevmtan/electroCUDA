function [sbjROIs,logs] = ec_epoch2dim_ROIs(o,logs)
% Reshapes EEG data from ec_analPrep() to have epoch as the first dimension.
% Epochs are treated as observations; timepoints with multiple frames
% (i.e., timebins) are concatenated along the first dimension per epoch.
%
% ROIs are saved as separate arrays, with observations from channels/ICs
% within an ROI concatenated along the first dimension.
%
% INPUTS: see next section
% OUTPUTS:
%   x = cell array of reshaped EEG data arrays per ROI
%   n = subject/recording metadata struct
%
% Part of the electroCUDA package (https://github.com/kevmtan/electroCUDA)

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" section)
    logs table = table % subjects run log
end


%% Prep

% Get directories
dirs = ec_getDirs(o.proj,o.task);
o.outDir = dirs.anal+o.analDir+filesep+o.analName+filesep;

% Make analysis output dir
if o.save && ~exist(o.outDir,"dir")
    mkdir(o.outDir);
end

% Save options struct
if o.save
    save(o.outDir+"o_"+o.analName+".mat","o");
end

% Make log table
if ~exist("logs","var") || isempty(logs)
    logs = table;
    logs.sbj = string(o.sbjs);
    logs.sbjID(:) = uint16(0);
    logs.nROIs(:) = nan;
    logs.fin(:) = false;
    logs.time(:) = string(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
    logs.error = cell(numel(o.sbjs),1);
    logs.dir(:) = string(missing);
    logs.ROIs(:) = string(missing);
    logs.n(:) = string(missing);
end

% Preallocate subject ROI table
sbjROIs = cell(height(logs));
% sLog=logs(5,:); %sbj38
% sLog=logs(9,:); %sbj42
% sLog=logs(21,:); %sbj60


%% Run subjects
for s = 1:height(logs)
    if ~logs.fin(s)
        %% Run subject
        try
            [sbjROIs{s},logs(s,:)] = runSbj_lfn(o,logs(s,:));
            logs.fin(s) = true;
        catch ME; getReport(ME)
            logs.error{s} = ME;
            logs.fin(s) = false;
        end

        %% Save logs
        logs.time(s) = datetime("now",TimeZone="local",Format="yyMMdd_HHmm");
        save(o.outDir+"logs.mat","logs","-v7");

    else
        disp("SKIPPING: "+logs.sbj(s));
    end
end


%% Finalize & save
sbjROIs = vertcat(sbjROIs{:}); % concatenate sbjROIs

% Save sbjROIs
if o.save
    save(o.outDir+"sbjROIs_"+o.analName+".mat","sbjROIs");
end






function [ROIs,sLog] = runSbj_lfn(o,sLog)
%%% Run subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("STARTING: "+sLog.sbj);
tt = tic;
rv = o.p.roiVar;

% Subject directories/info
dirs = ec_loadSbj(sbj=sLog.sbj,proj=o.proj,task=o.task,sfx=o.p.sfx);
sLog.sbjID = dirs.sbjID;
sLog.dir = o.outDir+"s"+dirs.sbjID+filesep;

% Make subject output dir
if o.save && ~exist(sLog.dir,"dir")
    mkdir(sLog.dir);
end


%% Prepare subject data
oo = namedargs2cell(o.p);               % expand name-value arguments
[x,ep,n] = ec_analPrep(dirs,tt,oo{:});  % run data prep
if numel(dbstack)<2; n0=n; x0=x; end %#ok<NASGU>  % Copy origs for testing
% n=n0; x=x0; tt=tic; disp("Restored original sbj vars");


%% Reshape EEG data with epoch dimension
[x,ob,n] = ec_epoch2dim(x,ep,n,tt,trialVars=o.trialVars,test=o.test);


%% Make ROI table
if ~isfield(n,"ROIs")
    % Get ROIs within subject
    if ~isany(o.p.ROIs)
        o.p.ROIs = string(unique(n.chNfo.(rv))); end
    ROIs = table;
    ROIs.roi = intersect(o.p.ROIs,string(unique(n.chNfo.(rv))));
    ROIs.roi = categorical(ROIs.roi,o.p.ROIs,Ordinal=true);
    ROIs = sortrows(ROIs,"roi");
    n.nROIs = height(ROIs);

    % Preallocate ROI table vars
    ROIs.nChs(:) = cast(0,like=n.chNfo.ch);
    ROIs.chs = cell(n.nROIs,1);
    ROIs.sbjChs = cell(n.nROIs,1);
    ROIs.sbjROI = "s"+n.sbjID+"_"+string(ROIs.roi);
    ROIs.sbjID(:) = n.sbjID;
    ROIs = movevars(ROIs,"sbjROI",Before=1);
else
    ROIs = n.ROIs;
end
sLog.nROIs = n.nROIs;

% Preallocate save locations (filepaths)
ROIs.xr(:) = string(missing);  % reshaped ROI EEG data
ROIs.obr(:) = string(missing); % reshaped ROI observations table


%% Run ROIs
for r = 1:n.nROIs
    % Find ROI chans
    id = ismember(n.chNfo.(rv),ROIs.roi(r));
    if ~isfield(n,"ROIs")
        ROIs.nChs(r) = nnz(id);
        ROIs.chs{r} = n.chNfo.ch(id);
        ROIs.sbjChs{r} = n.chNfo.sbjCh(id);
    end

    %% Reshape & save ROI data
    ROIs(r,:) = runROI_lfn(ROIs(r,:),x(:,:,id,:),ob,sLog,tt); 
end


%% Save

% ROI table
sLog.ROIs = sLog.dir+"s"+n.sbjID+"_ROIs.mat";
save(sLog.ROIs,"ROIs");

% Subject/recording info
sLog.n = sLog.dir+"s"+n.sbjID+"_n.mat";
save(sLog.n,"n");






function ROI = runROI_lfn(ROI,xr,ob,sLog,tt)
%%% Concatenate ROI chans, observations table & save %%%%%%%%%%%%%%%%%%%%%%
%                                                    xr=x(:,:,id,:); ROI=ROIs(r,:);
sz = size(xr);
nObs = sz(1);       % number of observations
nTime = sz(2);      % number of timepoints
nCh = sz(3);        % num chans/ICs
nSpec = sz(4:end);  % number of spectral frequencies or components


%% Reshape ROI EEG data
% Concatenate chans/ICs into epoch/observations dimension:
% (obs,time,ch,...) -> (obs*ch,time,...)
xr = permute(xr,[1 3 2 4:ndims(xr)]);
xr = reshape(xr,[nObs*nCh nTime nSpec]); %#ok<NASGU>


%% Generate ROI observations table
% Repeat original observations table to match EEG ROI chan/IC concatenation
obr = repmat(ob,nCh,1);
obr.ch = repelem(ROI.chs{1},nObs);
obr.sbjCh = repelem(ROI.sbjChs{1},nObs);
obr.roi(:) = ROI.roi;
obr.sbjROI(:) = ROI.sbjROI;
obr = movevars(obr,["sbjROI" "sbjCh"],Before=1);
obr = movevars(obr,["sbjID" "roi" "ch"],After=width(obr));


%% Save

% Save reshaped EEG data
ROI.xr = sLog.dir+"s"+ROI.sbjID+"_xr_"+string(ROI.roi)+".mat";
savefast(ROI.xr,'xr');
disp("SAVED: "+ROI.xr+" toc="+toc(tt));


% Save reshaped observations table
ROI.obr = sLog.dir+"s"+obr.sbjID(1)+"_obr_"+string(ROI.roi)+".mat";
save(ROI.obr,'obr');
disp("SAVED: "+ROI.obr+" toc="+toc(tt));

