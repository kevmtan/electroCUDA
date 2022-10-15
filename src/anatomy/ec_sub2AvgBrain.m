function [elecNames,hemisphere,isSubdural,avgCoord,subCoord,avgVids,subVids]=sub2AvgBrain_KT(subj,cfg)
% Modified by Kevin Tan to get inflated coords (github.com/kevmtan/electroCUDA)
%
% This function maps electrodes from patient space to the FreeSurfer average
% brain. For subdural electrodes, it takes RAS "pial" coordinates (snapped
% to the pial surface) and maps it to the corresponding location on the pial
% surface of FreeSurfer's average brain. Depth electrodes are mapped to
% MNI305 space with an affine transformation; these coordinates too can be
% visualized on the FreeSurfer average brain.
%
% Input:
%   subj = FreeSurfer subject name
%
% Optional Inputs: passed as fields in a configuration structure
%   plotEm = 1 or 0.  If nonzero, a figure is created illustrating
%            electrode locations on subject and average pial surface.
%            Click on electrodes to see names. Depth electrodes are not
%            shown. {default: 1}
%   elecCoord = N-by-3 numeric array with RAS electrode coordinates.
%               {default: not used; the function looks into the subject's
%               Freesurfer folder for electrode coordinate file instead}
%   elecNames = cell array of strings with electrode names, corresponding
%               to the rows of elecCoord. This argument is required
%               if elecCoord is used. {default: not used; the function
%               looks into the subject's Freesurfer folder for electrode
%               name file instead}
%   isLeft    = N-dimensional binary vector where N is the # of electrodes.
%               0 indicates that an electrode is on/in the right hemisphere.
%               1 indicates a left hemisphere location. This argument is
%               required if elecCoord is used. Otherwise this information
%               is read from the participant's electrodeNames file.
%   isSubdural= N-dimensional binary vector where N is the # of electrodes.
%               0 indicates that an electrode is a depth electrode. 1
%               indicates a subdural electrode. This argument is only used
%               if elecNames is used. Otherwise this information is read
%               from the participant's electrodeNames file {default:
%               all electrodes are assumed to be subdural}
%   rmDepths = 1 or 0. If nonzero, depth electrodes are ignored. {default: 0}
%   outputTextfile = 1 or 0. If nonzero, electrode locations are stored as a
%                  text file (*.FSAVERAGE) in the elec_recon subfolder of
%                  subj's FreeSurfer folder. Note, you cannot use both this
%                  option and rmDepths as removing depths will cause the
%                  coordinates to not correspond to *.electrodeNames. {default: 1}
%   isInf = inflated or pial coords (true=inflated, false=pial)
%
% Outputs:
%   avgCoord = Electrode coordinates on FreeSurfer avg brain pial/inf surface
%   elecNames = electrode channel names
%   hemisphere = electrode hemisphere (left or right)
%   avgVids   = Index of subject pial/inf surface vertices corresponding to each electrode
%   subVids   = Index of average pial/inf surface vertices corresponding to each electrode
%   elecCoord = native-space coordinates (RAS)
%
%
% Author:
% David Groppe
% Mehtalab
% March, 2012
%

% History
% 2015-6 Made compatible with Yang brain shift correction algorithm

% parse input parameters in cfg structure and set defaults
%if ~isfield(cfg,'fsDir'); fsDir=getFsurfSubDir();    else; fsDir=cfg.fsDir; end
if ~isfield(cfg,'plotEm');         plotEm=1;         else; plotEm=cfg.plotEm; end
if ~isfield(cfg,'elecCoord');      subCoord=[];     else; subCoord=cfg.elecCoord; end
if ~isfield(cfg,'elecNames');      elecNames=[];     else; elecNames=cfg.elecNames; end
if ~isfield(cfg,'isLeft');         isLeft=[];        else; isLeft=cfg.isLeft; end
if ~isfield(cfg,'isSubdural');     isSubdural=[];    else; isSubdural=cfg.isSubdural; end
if ~isfield(cfg,'rmDepths');       rmDepths=0;       else; rmDepths=cfg.rmDepths; end
if ~isfield(cfg,'outputTextfile'); outputTextfile=0; else; outputTextfile=cfg.outputTextfile; end
if ~isfield(cfg,'isInf');          isInf=false;      else; isInf=cfg.isInf; end
%checkCfg(cfg,'sub2AvgBrain.m');

if universalYes(outputTextfile) && universalYes(rmDepths)
    error('You cannot set both rmDepths and outputTextfile to 1.');
end

% FreeSurfer Subject Directory
fsDir=getFsurfSubDir();
avgDir=fullfile(fsDir,'fsaverage');
subDir=fullfile(fsDir,subj);
if ~exist(avgDir,'dir')
    error('Folder for fsaverage is not present in FreeSurfer subjects directory (%s). Download it from here https://osf.io/qe7pz/ and add it.', ...
        fsDir);
end
if ~exist(subDir,'dir')
    error('Folder for %s is not present in FreeSurfer subjects directory (%s).',subj,fsDir);
end


% Take care of electrode names, hemisphere, and type
if isempty(elecNames)
    % Import electrode names
    chFn=fullfile(subDir,'elec_recon',[subj '.electrodeNames']);
    chNfo=csv2Cell(chFn,' ',2);
    hemisphere = chNfo(:,3);
    elecNames=chNfo(:,1);
    nElec=size(chNfo,1);
    isLeft=zeros(nElec,1);
    isSubdural=zeros(nElec,1);
    for a = 1:nElec
        if ~strcmpi(chNfo{a,2},'D')
            isSubdural(a)=1;
        end
        if strcmpi(chNfo{a,3},'L')
            isLeft(a)=1;
        end
    end
else
    nElec=length(elecNames);
    if isempty(isLeft)
        error('You need to specify cfg.isLeft when using cfg.elecNames');
    else
        if length(isLeft)~=nElec
            error('elecNames and isLeft do not have the same # of electrodes.');
        end
    end
    if isempty(isSubdural)
        % assume all electrodes are subdural
        isSubdural=ones(nElec,1);
    else
        if length(isSubdural)~=nElec
            error('isSubdural and isLeft do not have the same # of electrodes.');
        end
    end
end


% Take care of electrode coordinates in participant space
if isempty(subCoord) % no electrode coordinates have been passed in the function call:
    % Import electrode PIAL/inf coordinates
    if isInf; coordFname=fullfile(subDir,'elec_recon',[subj '.INF']);
    else; coordFname=fullfile(subDir,'elec_recon',[subj '.PIAL']);
    end

    coordCsv=csv2Cell(coordFname,' ',2);
    subCoord=zeros(nElec,3);
    for a=1:nElec
        for b=1:3
            subCoord(a,b)=str2double(coordCsv{a,b});
        end
    end
else
    if size(subCoord,1)~=nElec
        error('Electrode coordinates need to have the same number of rows as electrode names.');
    end
end

% Remove depths (optional)
if universalYes(rmDepths)
    keepIds=find(isSubdural);
    isLeft=isLeft(keepIds);
    elecNames=elecNames(keepIds);
    subCoord=subCoord(keepIds,:);
    nElec=length(elecNames);
    isSubdural=isSubdural(keepIds);
else
    [avgCoordsDepths, elecNamesDepths]=depths2AvgBrain(subj);
end

% Get electrode coordinates on average brain
avgCoord=zeros(nElec,3);
avgVids=zeros(nElec,1);
subVids=zeros(nElec,1);
plotCtOffset=0; % counts the # of electrodes that have been displayed
for hemLoop=1:2
    if hemLoop==1
        % Do left hemisphere elecs
        hemElecIds=find(isLeft);
        hem='l';
    else
        % Do right hemisphere elecs
        hemElecIds=find(~isLeft);
        hem='r';
    end

    if ~isempty(hemElecIds)
        fprintf('Working on hemisphere: %s\n',hem);
        if isInf; cortFn=fullfile(subDir,'surf',[ hem 'h.inflated']);
        else; cortFn=fullfile(subDir,'surf',[ hem 'h.pial']);
        end
        cort=readSurfHelper(cortFn);

        nHemElec=length(hemElecIds);
        nVertsCort=size(cort.vert,1);
        for a=1:nHemElec
            df=cort.vert-repmat(subCoord(hemElecIds(a),:),nVertsCort,1);
            dst=sum(df.^2,2);
            [~, subVids(hemElecIds(a))]=min(dst);
            %if isSubdural(hemElecIds(a))
            %    df=cort.vert-repmat(subCoord(hemElecIds(a),:),nVertsCort,1);
            %    dst=sum(df.^2,2);
            %   [~, subVids(hemElecIds(a))]=min(dst);
            %else
            %    subVids(hemElecIds(a))=1; %dummy vertex
            %end
        end

        sphFnameSub=fullfile(subDir,'surf',[hem 'h.sphere.reg']);
        sph=readSurfHelper(sphFnameSub);

        sphFnameAvg=fullfile(avgDir,'surf',[hem 'h.sphere.reg']);
        avg_sph=readSurfHelper(sphFnameAvg);
        nAvgVert=length(avg_sph.vert);
        for a=1:nHemElec
            df=avg_sph.vert-repmat(sph.vert(subVids(hemElecIds(a)),:),nAvgVert,1);
            dst=sum(df.^2,2);
            [~, avgVids(hemElecIds(a))] = min(dst);
            %if isSubdural(hemElecIds(a))
            %    df=avg_sph.vert-repmat(sph.vert(subVids(hemElecIds(a)),:),nAvgVert,1);
            %    dst=sum(df.^2,2);
            %    [~, avgVids(hemElecIds(a))]=min(dst);
            %else
            %    avgVids(hemElecIds(a))=1; %dummy vertex
            %end
        end

        if isInf; avgFn=fullfile(avgDir,'surf',[ hem 'h.inflated']);
        else; avgFn=fullfile(avgDir,'surf',[ hem 'h.pial']);
        end
        avg=readSurfHelper(avgFn);
        for a=1:nHemElec
            if isSubdural(hemElecIds(a))
                avgCoord(hemElecIds(a),:)=avg.vert(avgVids(hemElecIds(a)),:);
            else
                % Get depth coordinates in MNI305 space
                %[avgCoordsDepths, elecNamesDepths, isLeftDepths]=depths2AvgBrain(subj);
                depthId=findStrInCell(elecNames{hemElecIds(a)},elecNamesDepths,1);
                avgCoord(hemElecIds(a),:)=avgCoordsDepths(depthId,:);
            end
        end


        % Plot results (optional)
        if universalYes(plotEm)
            % LATERAL VIEW
            hFig=figure;
            set(hFig,'position',[360 335 829 360]);

            elecColors=distinguishable_colors(nHemElec,[1 1 1]*.7);

            % Plot Electrodes on Avg Brain
            subplot(1,2,1);
            map=[1 1 1]*.7;
            tripatchDG(avg,hFig,map);
            shading interp; lighting gouraud; material dull; axis off, hold on
            if strcmp(hem,'r')
                light('Position',[1 0 0]);
                view(90,0);
            else
                light('Position',[-1 0 0]);
                view(270,0);
            end
            for a=1:nHemElec
                h=plot3(avgCoord(a+plotCtOffset,1),avgCoord(a+plotCtOffset,2),avgCoord(a+plotCtOffset,3),'r.');
                clickText(h,elecNames{a+plotCtOffset});
                set(h,'markersize',20,'color',elecColors(a,:));
            end
            if universalNo(rmDepths)
                alpha(0.5); % Make surface transparent so that depths are visible
            end
            rotate3d off;

            % Plot Electrodes on Participant Brain
            subplot(1,2,2);
            tripatchDG(cort,hFig,map);
            shading interp; lighting gouraud; material dull; axis off, hold on
            if strcmp(hem,'r')
                l=light('Position',[1 0 0]);
                view(90,0);
            else
                l=light('Position',[-1 0 0]);
                view(270,0);
            end
            for a=1:nHemElec
                h=plot3(subCoord(hemElecIds(a),1),subCoord(hemElecIds(a),2), ...
                    subCoord(hemElecIds(a),3),'r.');
                clickText(h,elecNames{a+plotCtOffset});
                set(h,'markersize',20,'color',elecColors(a,:));
            end
            if universalNo(rmDepths)
                alpha(0.5); % Make surface transparent so that depths are visible
            end
            rotate3d off;
            set(gcf,'name',subj);

            % MEDIAL VIEW
            hFig=figure;
            set(hFig,'position',[350 315 829 360]);

            % Plot Electrodes on Avg Brain
            subplot(1,2,1);
            map=[1 1 1]*.7;
            tripatchDG(avg,hFig,map);
            shading interp; lighting gouraud; material dull; axis off, hold on
            if strcmp(hem,'r')
                light('Position',[-1 0 0]);
                view(270,0)
            else
                light('Position',[1 0 0]);
                view(90,0);
            end
            for a=1:nHemElec
                h=plot3(avgCoord(a+plotCtOffset,1),avgCoord(a+plotCtOffset,2), ...
                    avgCoord(a+plotCtOffset,3),'r.');
                clickText(h,elecNames{a+plotCtOffset});
                set(h,'markersize',20,'color',elecColors(a,:));
            end
            if universalNo(rmDepths)
                alpha(0.5); % Make surface transparent so that depths are visible
            end
            rotate3d off;

            % Plot Electrodes on Participant Brain
            subplot(1,2,2);
            tripatchDG(cort,hFig,map);
            shading interp; lighting gouraud; material dull; axis off, hold on
            if strcmp(hem,'r')
                light('Position',[-1 0 0]);
                view(270,0)
            else
                light('Position',[1 0 0]);
                view(90,0);
            end
            for a=1:nHemElec
                h=plot3(subCoord(hemElecIds(a),1),subCoord(hemElecIds(a),2), ...
                    subCoord(hemElecIds(a),3),'r.');
                clickText(h,elecNames{a+plotCtOffset});
                set(h,'markersize',20,'color',elecColors(a,:));
            end
            if universalNo(rmDepths)
                alpha(0.5); % Make surface transparent so that depths are visible
            end
            rotate3d off;
            set(gcf,'name',subj);

            drawnow;
            plotCtOffset=nHemElec+plotCtOffset;
        end
    end
end

%% Add subject name as prefix to electrode names:
% for a=1:nElec
%     elecNames{a}=[subj '-' elecNames{a}];
% end

%% Write electrode locations to text file (if requested)
if universalYes(outputTextfile)
    cortFn=fullfile(subDir,'elec_recon',[subj '.PIAL']);
    % Import brain shift correction method
    fid=fopen(cortFn,'r');
    firstLine=fgetl(fid);
    fclose(fid);
    splitHdr=strsplit(firstLine,'\t'); % split on tabs
    if length(splitHdr)>=2
        % method is specified in header
        brainShiftCorrectMethod=splitHdr{2};
    else
        % figure out which brain shift correction method was used based on log
        splitHdr2=strsplit(firstLine,'\t');
        dateGenerated=datetime(splitHdr2{1});
        logDate=datestr(dateGenerated,'yyyy-mm-dd');
        logFname=sprintf('localization_process_%s.log',logDate);
        elecReconDir=fullfile(subDir,'elec_recon');
        logFname=fullfile(elecReconDir,logFname);
        if exist(logFname,'file')
            fid=fopen(logFname,'r');
            tempLine=fgetl(fid);
            if contains('Dykstra',tempLine)
                brainShiftCorrectMethod='dykstra-preIeegBids';
            else
                brainShiftCorrectMethod='yangWang-preIeegBids';
            end
            fclose(fid);
        else
            brainShiftCorrectMethod='BrainShiftCorrectionMethodUnknown';
        end
    end

    xyzFname=fullfile(subDir,'elec_recon',[subj '.FSAVERAGE']);
    fprintf('Storing electrode coordinates in FreeSurfer Average Brain space to %s\n',xyzFname);
    fidXyz=writeElecCoordHeader(xyzFname,brainShiftCorrectMethod,subj);
    for a=1:nElec
        fprintf(fidXyz,'%f %f %f\n',avgCoord(a,1),avgCoord(a,2),avgCoord(a,3));
    end
    fclose(fidXyz);
end