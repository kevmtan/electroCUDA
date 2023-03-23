function ec_dykstraElecPjct(sub,minimizeChange,bidsRootDir,sessionId,elecHem)
%function dykstraElecPjct(sub,minimizeChange,bidsRootDir,sessionId,elecHem)
%
% Corrects intracranial electrode locations for brain shift using the
% following method:
%  Dykstra, A.R., Chan, A.M., Quinn, B.T., Zepeda, R., Keller, C.J.,
%  Cormier, J., Madsen, J.R., Eskandar, E.N., Cash, S.S., 2011.
%  Individualized localization and cortical surface-based registration of
%  intracranial electrodes. NeuroImage 1-42.
%
% Required Input:
%  sub - Freesurfer subject name (e.g., 'TWH001')
%
% Optional Inputs:
%  minimizeChange - [0 | 1] If 0, subdural electrodes are simply projected
%        to the closest leptomeningeal surface vertex to correct for brain shift. If
%        non-zero, an interative optimization algorithm is used to project
%        electrodes to the leptomeningeal surface in a way tha minimizes their
%        change in spatial location and change in the Euclidean distance
%        between electrode neighbors. Turning off the optimization may help
%        if the optimization peforms poorly. {default: 1}
%  bidsRootDir - [string] The root BIDS directory into which electrode and
%               neuroimaging info will be stored {default: not used}
%  sessionId - [integer] A number indicating the "session" in which the
%                corresponding iEEG data have been recorded. This will be
%                used to create filenames of electrode locations as it is
%                possible that data may be recorded in multiple sessions and
%                the electrodes recorded from may differ across sessions.
%                {default: 1}
%  elecHem - 'L', 'R', or 'FirstChar': If 'L' all electrodes are assumed to lie on
%        the left hemisphere. If 'R' all electrodes are assumed to lie
%        onthe right hemisphere. 'FirstChar' means that each electrode's
%        name begins with 'L' or 'R', which specifies the hemisphere. If
%        empty, the electrode's hemisphere assignment is automatically
%        deteremined using its anatomical location. Automatic assignment
%        may fail for medial electrodes and can be corrected by manually
%        editing the patient's *.electrodeNames file. This ONLY HAS AN EFFECT
%        if NOT importing electrode locations from an mgrid file. Default: elecHem=[]
%
% Outputs:
%  The following files are created in the elec_recon subfolder of the
%  Freesufer subject folder:
%     *.POSTIMPLANT: The RAS coordinates of electrodes before any correction for
%           postimplant brain shift
%     *.LEPTO: The leptomeningeal surface RAS coordinates of electrodes after
%           correction for postimplant brain shift. Depth electrode
%           coordinates are the same as in *.CT
%     *.LEPTOVOX: The leptomeningeal surface voxel coordinates of electrodes after
%           correction for postimplant brain shift. Voxel coordinates
%           are for brainmask.nii.gz file also in the elec_recon folder.
%           Depth electrode coordinates are the same as in *.CT
%     *.INF: The pial RAS coordinates of electrodes on the inflated pial
%           surface after correcting for brain shift. Depths have NaN coordinates.
%     *.PIAL: The pial surface RAS coordinates of electrodes after
%           correction for postimplant brain shift. Depth electrode coordinates
%           are the same as in *.CT
%     *.PIALVOX: The pial surface voxel coordinates of electrodes after
%           correction for postimplant brain shift. Voxel coordinates are
%           for brainmask.nii.gz file also in the elec_recon folder. Depth
%           electrode coordinates are the same as in *.CT
%     *.electrodeNames: A text file that indicates the name, type of
%           electrode (strip, grid, depth), and hemisphere in which each
%           electrode lies. The ith row of this file corresponds to the ith
%           row of coordinate files.
%    localization_process_date.log - Record of command line output produced
%                                    when this function is run
%
% In the above, *=Freesurfer subject name and
% date=the date on which those files were generated
%
% Note, depth electrode coordinates are not affected by this function. They
% are kept the same as in the postimplant CT or MRI scan.
%
%
% Authors:
% Andrew Dykstra & David M. Groppe
% June 2015

% To Do
% -Create text files of avg brain coordinates too?

% Modified: fix filepath issues --Kevin Tan (github.com/kevmtan/electroCUDA) 

if nargin<2
    minimizeChange=1;
end
if nargin<3
    bidsRootDir=[];
end
if nargin<4
    sessionId=1;
end
if nargin<5
    elecHem=[];
end
if ~isempty(elecHem)
    ids=findStrInCell(elecHem,{'L','R','FirstChar'},0);
    if isempty(ids)
        error('Illegal value of elecHem.');
    end
end

fsDir=getFsurfSubDir();

%% Get version of code to store with electrode coordinates:
brainShiftMethod=['dykstra-' iELVis_getGitInfo];

%%
elecReconDir=fullfile(fsDir,sub,'elec_recon');
mniInfoFname=fullfile(elecReconDir,'mniElecInfo.tsv');
mniPairsFname=fullfile(elecReconDir,'mniElecPairs.tsv');
if exist(mniInfoFname,'file') && exist(mniPairsFname,'file')
    % import from mni
    [elecMatrix,elecLabels,elecRgb,elecPairs,elecPresent] = mni2Matlab(sub,elecHem);
else
    % import from mgrid
    [elecMatrix,elecLabels,elecRgb,elecPairs,elecPresent] = mgrid2matlab(sub);
end

% Remove electrodes that were disabled in bioimagesuite
presentIds=find(elecPresent);
elecMatrix=elecMatrix(presentIds,:);
elecMatrix=elecMatrix-1;
elecLabels=elecLabels(presentIds);
elecRgb=elecRgb(presentIds,:);
nElec=length(elecLabels);

elecHem=zeros(nElec,1); %Which hemisphere each electrode is in/over, Left=1, Right=0;
elecStems=cell(nElec,1);
elecNums=zeros(nElec,1);
elecType=cell(nElec,1);
for a=1:nElec
    if strcmpi(elecLabels{a}(1),'L')
        elecHem(a)=1;
    end
    if ~sum(upper(elecLabels{a}(2))=='GSD')
        error('2nd character of electrode label %s needs to be a G, S, or D.', ...
            elecLabels{a});
    else
        elecType{a}=upper(elecLabels{a}(2));
    end
    underIds=find(elecLabels{a}=='_');
    elecStems{a}=elecLabels{a}(underIds(1)+1:underIds(2)-1);
    elecNums(a)=str2double(elecLabels{a}(underIds(2)+1:end));
end


%% Start diary
elecReconPath=fullfile(fsDir,sub,'elec_recon');

diary_file = fullfile(elecReconPath,['localization_process_' datestr(now,29) '.log']);
fprintf('Recording command line output in file: \n%s\n',diary_file);
diary(diary_file)

fprintf('\n================================================================\n');
fprintf('Starting Dykstra et al. localization process for %s at %s\n',sub,datestr(now,31));
fprintf('Freesurfer Recon dir: %s\n',elecReconPath);
fprintf('Initial location mgrid file: %s.mgrid\n',sub);

% Dykstra code uses RAS coordinates (not VOX)
VOX2RAS=[-1 0 0 128; 0 0 -1 128; 0 -1 0 128; 0 0 0 1];
ctRAS=(VOX2RAS*[elecMatrix'; ones(1, size(elecMatrix,1))])';
ctRAS=ctRAS(:,1:3);

%% Find depth electrodes
isDepth=ones(nElec,1);
for a=1:nElec
    if lower(elecLabels{a}(2))~='d'
        isDepth(a)=0;
    end
end
depthIds=find(isDepth);
sduralIds=find(~isDepth);
fprintf('%d Depth electrodes\n',length(depthIds));
fprintf('%d Subdural electrodes\n',length(sduralIds));


%% Initialize Coordinate Variables
leptoRAS=ctRAS;
leptoVOX=zeros(nElec,3);
infRAS=zeros(nElec,3)*NaN;
pialRAS=ctRAS;
pialVOX=zeros(nElec,3);


%% Correct subdurals for brain shift
% The optimset function used by Dykstra's code can't deal with initial
% coordinates that have a value of 0. If you add a tiny amount it
% runs. -DG
jit=zeros(size(ctRAS,1),1);
jitCtRAS=ctRAS;
for a=1:3
    ids=find(ctRAS(:,a)==0);
    if ~isempty(ids)
        jitCtRAS(ids,a)=.000000000000001;
        jit(ids)=1;
    end
end
if sum(jit)
    fprintf('A small value was added to %d electrodes to prevent their CT coordinates from having a zero.\n', ...
        sum(jit));
end

%surfPath=sprintf('/Applications/freesurfer/subjects/%s/surf/',sub);
surfPath=fullfile(fsDir,sub,'surf');
for hemLoop=0:1
    hemIds=find(elecHem==hemLoop);

    if ~isempty(hemIds)
        if hemLoop==0
            hem='r';
        else
            hem='l';
        end

        %% Load Leptomeningeal Surface
        surftype='pial-outer-smoothed';
        [surf.vert,surf.tri]=read_surf(fullfile(surfPath,[hem 'h.' surftype]));

        %% Brain Shift Correction
        useIds=intersect(hemIds,sduralIds);
        if ~isempty(useIds)
            if universalYes(minimizeChange)
                % Project subdural electrodes to leptomeningeal surface while minimizing
                % distortion
                coordLepto=snap2duralEnergy_lfn(jitCtRAS(useIds,:),surf);
            else
                %Simply assign subdural electrodes to the nearest leptomeningeal vertex
                coordLepto=get_loc_snap_mgh(jitCtRAS(useIds,:),surfPath,hem,'pial-outer-smoothed');
            end
            leptoRAS(useIds,:)=coordLepto;

            %% Project leptomeningeal locations to pial surface
            pialRAS(useIds,:)=get_loc_snap_mgh(coordLepto,surfPath,hem,'pial');
        end
    end
end


%% Save the electrodes locations and labels as text files

%%%%%% Output Electrode Names to Text Files %%%%%%%%%
fnameLabels=fullfile(elecReconPath,[sub '.electrodeNames']);
fprintf('Saving electrode labels to: %s\n',fnameLabels);
fidLabels=fopen(fnameLabels,'w');
fprintf(fidLabels,'%s\n',datestr(now));
fprintf(fidLabels,'Name, Depth/Strip/Grid, Hem\n');
for a=1:nElec
    if elecHem(a)
        hem='L';
    else
        hem='R';
    end
    fprintf(fidLabels,'%s%d %s %s\n',elecStems{a},elecNums(a),elecType{a},upper(hem(1)));
end
fclose(fidLabels);

%%%%%% Output RAS Coordinates to Text Files %%%%%%%%%
% POSTIMPLANT (CT or MRI) RAS COORDINATES
fnamePostImpRAS = fullfile(elecReconPath,[ sub '.POSTIMPLANT']);
fprintf('Saving CT RAS electrode locations to: %s\n',fnamePostImpRAS);
fidPostImp=writeElecCoordHeader(fnamePostImpRAS,brainShiftMethod,sub);
for a=1:nElec
    fprintf(fidPostImp,'%f %f %f\n',ctRAS(a,1),ctRAS(a,2),ctRAS(a,3));
end
fclose(fidPostImp);

% Lepto RAS COORDINATES
fnameLeptoRAS = fullfile(elecReconPath,[sub '.LEPTO']);
fprintf('Saving Lepto RAS electrode locations to: %s\n',fnameLeptoRAS);
fidLepto=writeElecCoordHeader(fnameLeptoRAS,brainShiftMethod,sub);
for a=1:nElec
    fprintf(fidLepto,'%f %f %f\n',leptoRAS(a,1),leptoRAS(a,2),leptoRAS(a,3));
end
fclose(fidLepto);

% Pial RAS COORDINATES
fnamePialRAS = fullfile(elecReconPath,[sub '.PIAL']);
fprintf('Saving Pial RAS electrode locations to: %s\n',fnamePialRAS);
fidPial=writeElecCoordHeader(fnamePialRAS,brainShiftMethod,sub);
for a=1:nElec
    fprintf(fidPial,'%f %f %f\n',pialRAS(a,1),pialRAS(a,2),pialRAS(a,3));
end
fclose(fidPial);

%%%%%% Output VOX Coordinates to Text Files %%%%%%%%%
% Lepto VOX COORDINATES
%RAS2VOX=inv(VOX2RAS);
leptoVOX=(VOX2RAS\[leptoRAS'; ones(1, nElec)])';
fnameLeptoVOX = fullfile(elecReconPath,[sub '.LEPTOVOX']);
fprintf('Saving lepto VOX electrode locations to: %s\n',fnameLeptoVOX);
fidLeptoVox=writeElecCoordHeader(fnameLeptoVOX,brainShiftMethod,sub);
for a=1:nElec
    fprintf(fidLeptoVox,'%f %f %f\n',leptoVOX(a,1),leptoVOX(a,2),leptoVOX(a,3));
end
fclose(fidLeptoVox);

% Pial VOX COORDINATES
pialVOX=(VOX2RAS\[pialRAS'; ones(1, nElec)])';
fnamePialVOX = fullfile(elecReconPath,[sub '.PIALVOX']);
fprintf('Saving pial VOX electrode locations to: %s\n',fnamePialVOX);
fidPialVox=writeElecCoordHeader(fnamePialVOX,brainShiftMethod,sub);
for a=1:nElec
    fprintf(fidPialVox,'%f %f %f\n',pialVOX(a,1),pialVOX(a,2),pialVOX(a,3));
end
fclose(fidPialVox);

%% Created text file of Inflated Pial Surface Coordinates (relies on just created text files)
infRAS=pial2InfBrain(sub,[]);
fnameInfRAS = fullfile(elecReconPath,[sub '.INF']);
fprintf('Saving inflated pial RAS electrode locations to: %s\n',fnameInfRAS);
fidInf=writeElecCoordHeader(fnameInfRAS,brainShiftMethod,sub);
for a=1:nElec
    fprintf(fidInf,'%f %f %f\n',infRAS(a,1),infRAS(a,2),infRAS(a,3));
end
fclose(fidInf);


%% Plot results to double check
plotPostImpVsLepto_lfn(sub,1,1);

% close diary
fprintf('\nElectrodes Localization finished for %s',sub);
fprintf('\n================================================================\n');
diary off

% Copy electrode and anatomical info to an iEEG-BIDS folder
if ~isempty(bidsRootDir)
    iELVisFsurf2BIDS(sub,bidsRootDir,sessionId);
end
end







%% Subfunctions

function [coord_snapped,pairs]=snap2duralEnergy_lfn(coord,surf,pairs)
% snap2dural_energy - uses energy minimization to snap electrodes to dural
%                     surface
%
% usage:
%   >> coord_snapped = snap2dural_energy(coord,surf);
%   >> [coord_snapped,pairs] = snap2dural_energy(coord,surf,pairs);
%
% inputs:
%   coord    Nx3 matrix of original RAS coordinates of electrodes
%   surf     Surface structure (single hemisphere) with .vert and .tri
%            fields.  Only pass in the surface of the appropriate
%            hemisphere (e.g. cortex.lh or cortex.rh)
%   pairs    Mx2 matrix of M pairs of electrode indices for which the deformation
%            energy is computed.  If not supplied, the 4 nearest neighbors
%            of each electrode are used.
%
% outputs:
%   coord_snapped  Nx3 matrix of coordinates snapped to dural surface
%   pairs          Mx2 matrix of the electrode pairs used in the
%                  deformation energy
%
% algorithm details: This function performs a constrained optimization
% using an energy function which accounts for the distance the electrodes
% move away from their starting point, and the change in distance of the
% electrodes from their neighbors.  The constraint that the electrodes need
% to lie on the dural surface is satisfied.

% set starting coordinates
coord0=coord;

% compute pairs of neighbors
try
    if(nargin<3 || isempty(pairs))
        pairs = knn_pairs_lfn(coord,4); %knn_pairs_lfn(coord,4);
    end

    % anonymous function handles
    efun=@(coord_snapped)energy_electrodesnap_lfn(coord_snapped,coord,pairs);
    cfun=@(coord_snapped)surface_constraint_lfn(coord_snapped,surf);

    % options
    history.coords=[];
    last_handle=[];
    options=optimset('Algorithm','active-set',...
        'Display','iter',...
        'MaxIter',50,... % 'MaxIter',50
        'MaxFunEvals',Inf,...
        'UseParallel',true,...
        'GradObj','off',...
        'TypicalX',reshape1d(coord),...
        'DiffMaxChange',2,...
        'DiffMinChange',0.3,...
        'TolFun',0.3,...
        'TolCon',0.01*size(coord0,1),...
        'TolX',0.5,...
        'Diagnostics','off',...
        'RelLineSrchBnd',1,...
        'PlotFcns',{@optimplotfval,@optimplotstepsize,@optimplotfirstorderopt,@plotCoordFun_lfn});

    % run minimization
    coord_snapped = fmincon(efun,coord0,[],[],[],[],[],[],cfun,options);
catch
    if(nargin<3 || isempty(pairs))
        pairs = knn_pairs_lfn(coord); 
        %pairs = knn_pairs_old_lfn(coord); %knn_pairs_old_lfn(coord,4);
    end

    % anonymous function handles
    efun=@(coord_snapped)energy_electrodesnap_lfn(coord_snapped,coord,pairs);
    cfun=@(coord_snapped)surface_constraint_lfn(coord_snapped,surf);

    % options
    history.coords=[];
    last_handle=[];
    options=optimset('Algorithm','active-set',...
        'Display','iter',...
        'MaxIter',50,... % 'MaxIter',50
        'MaxFunEvals',Inf,...
        'UseParallel',true,...
        'GradObj','off',...
        'TypicalX',reshape1d(coord),...
        'DiffMaxChange',2,...
        'DiffMinChange',0.3,...
        'TolFun',0.3,...
        'TolCon',0.01*size(coord0,1),...
        'TolX',0.5,...
        'Diagnostics','off',...
        'RelLineSrchBnd',1,...
        'PlotFcns',{@optimplotfval,@optimplotstepsize,@optimplotfirstorderopt,@plotCoordFun_lfn});

    % run minimization
    coord_snapped = fmincon(efun,coord0,[],[],[],[],[],[],cfun,options);
end


%% energy function
    function energy=energy_electrodesnap_lfn(coord,coord_orig,pairs)
        % energy from change in electrode positions
        energy_eshift=sum((coord-coord_orig).^2,2);

        % energy from deformation of grid shape
        dist=sqrt(sum((coord(pairs(:,1),:)-coord(pairs(:,2),:)).^2,2));
        dist_orig=sqrt(sum((coord_orig(pairs(:,1),:)-coord_orig(pairs(:,2),:)).^2,2));
        energy_deform=(dist-dist_orig).^2;

        % total energy
        energy=mean(energy_eshift)+10*mean(energy_deform.^2);
    end

%% constraint function
    function [c,ceq]=surface_constraint_lfn(coord,surf)
        ind=knnsearch(coord,surf.vert,1);
        dist=sqrt(sum((coord-surf.vert(ind,:)).^2,2));
        c=[];
        ceq=dist;
    end

%% nearest neighbor function
    function pairs=knn_pairs_lfn(coord,k)
        % compute pairs
        if(nargin<2 || isempty(k))
            k=5;
        end
        knn_ind=knnsearch(coord,coord,k);
        firstofpair=repmat((1:size(coord,1))',1,k);
        kdist=reshape(sqrt(sum((coord(knn_ind(:),:)-coord(firstofpair(:),:)).^2,2)),size(knn_ind));

        pairs_all=cat(3,knn_ind,firstofpair);
        pairs_all=permute(pairs_all,[3 1 2]);
        pairs_all=sort(reshape(pairs_all,2,[]),1)';
        pairs_all=unique(pairs_all,'rows');

        dist_pairs=sqrt(sum((coord(pairs_all(:,1),:)-coord(pairs_all(:,2),:)).^2,2));
        dist_pairs=round(dist_pairs*20)/20;
        dist_standard=mode(dist_pairs);

        pairs=[];
        for i=1:size(knn_ind,1)
            numvalid=sum(kdist(i,:)<(dist_standard*1.25));
            if(numvalid==0)
                numvalid=sum(kdist(i,:)<(kdist(i,1)*1.25));
            end
            pairs=cat(1,pairs,[i*ones(numvalid,1),knn_ind(i,1:numvalid)']);
        end
        pairs=sort(pairs,2);
        pairs=unique(pairs,'rows');
    end

%% nearest neighbor function old
    function pairs=knn_pairs_old_lfn(coord,k)
        % compute pairs
        if(nargin<2 || isempty(k))
            k=4;
        end
        knn_ind=knnsearch(coord,coord,k);
        pairs=cat(3,knn_ind,repmat((1:size(coord,1))',1,k));
        pairs=permute(pairs,[3 1 2]);
        pairs=sort(reshape(pairs,2,[]),1)';
        pairs=unique(pairs,'rows');

        % compute threshold
        dist=pdist(coord,'euclidean');
        dist=sort(dist,'ascend');
        threshold=mean(dist(1:(size(coord,2)*3)));
        threshold=threshold*1.5;

        % take pairs less than threshold
        dist_pairs=sqrt(sum((coord(pairs(:,1),:)-coord(pairs(:,2),:)).^2,2));
        pairs=pairs(dist_pairs<=threshold,:);
    end

%% plotting function
    function stop = plotCoordFun_lfn(coord,optimValues,state) %#ok<INUSL>
        switch state
            case 'init'
                hold on; axis vis3d; view([3 1 -0.5]);
                last_handle=scatter3(coord(:,1),coord(:,2),coord(:,3),'marker','o','markerfacecolor','r','markeredgecolor','r','sizedata',15);
                history.coords=coord;
            case 'iter'
                set(last_handle,'marker','.','sizedata',10,'markerfacecolor','b','markeredgecolor','b');
                last_handle=scatter3(coord(:,1),coord(:,2),coord(:,3),10,'marker','o','markerfacecolor','r','markeredgecolor','r','sizedata',15);
                plot3([coord(:,1) history.coords(:,1,end)]',[coord(:,2) history.coords(:,2,end)]',[coord(:,3) history.coords(:,3,end)]','k');
                history.coords=cat(3,history.coords,coord);
            case 'done'
                hold off;
            otherwise
        end
        stop = false;
    end
end

%%
function [figH,axH] = plotPostImpVsLepto_lfn(sub,printEm,plotPial)
%function [figH, axH]=plotPostImpVsLepto(sub,printEm,plotPial)
%
% This function creates two plots to illustrate the effect of brain shift
% correction:
%  1: A plot of the distance between each electrode's pre and post
%  correction positions and a 3D scatter plot of these positions
%
%  2: Post-correction positions overlayed on pial surface and color coded
%  to represent distance between pre and post correction locations
%
% This function is called by interpStripElec.m, dykstraElecPjct.m, and yangWangElecPjct.m
%
% Inputs:
%  sub - Subject's FreeSurfer name/folder
%  printEm  - If nonzero, copies of the images are output the
%             "elec_recon/PICS" subfolder of the subject's FreeSurfer folder
%  plotPial - If nonzero, a figure is created that illustrateds
%             post-brainshift corrected electrodes color coded by the extent of
%             brainshift correction.
%
% Author: David Groppe
% Honeylab, Univ. of Toronto
% June 2015

% Load lepto and CT coordinates
fsDir=getFsurfSubDir();
%erPath=[fsDir sub '/elec_recon/'];
erPath=fullfile(fsDir,sub,'elec_recon');
leptoFname=fullfile(erPath,[sub '.LEPTO']);
%leptoFname=[erPath sub '.LEPTO'];
leptoCsv=csv2Cell(leptoFname,' ',2);
nChan=size(leptoCsv,1);

% Load elec names etc..
chanFname=fullfile(erPath,[sub '.electrodeNames']);
chanInfo=csv2Cell(chanFname,' ',2);
chanName=chanInfo(:,1);
chanType=chanInfo(:,2);
chanHem=chanInfo(:,3);

postImpFname=fullfile(erPath,[sub '.POSTIMPLANT']);
postImpCsv=csv2Cell(postImpFname,' ',2);

leptoRAS=zeros(nChan,3);
ctRAS=zeros(nChan,3);
for a=1:nChan
    for b=1:3
        ctRAS(a,b)=str2double(postImpCsv{a,b});
        leptoRAS(a,b)=str2double(leptoCsv{a,b});
    end
end


%% Plot results to double check
shiftDist=sqrt(sum( (leptoRAS-ctRAS).^2,2)); %units are mm

%rgb=zeros(nElec,3);
rgb=vals2Colormap(shiftDist,'justpos');
if printEm; figH(1)=figure('Visible','off');
else; figH(1)=figure; end

%set(figH(1),'position',[104 285 1114 410]);
axH(1)=subplot(121);
plot(shiftDist,'.-'); hold on;
last_type=[];
marker='o';
non_depth=ones(1,nChan);
leftHem=ones(1,nChan);
for a=1:nChan
    if chanType{a}=='D'
        non_depth(a)=0;
        marker='s';
    else
        marker='o';
    end
    if chanHem{a}=='R'
        leftHem(a)=0;
    end
    h=plot(a,shiftDist(a),marker);
    set(h,'color',rgb(a,:));
    clickText(h,[num2str(a) ': ' chanName{a}]);
    xlabel('Channel');
    ylabel('Pre vs. Post Brain Shift Corrected Distance (mm)');
end
non_depth_ids=find(non_depth);
title(sprintf('%s Median=%.1f, SIQR=%.1f (depths ignored)',sub,median(shiftDist(non_depth_ids)), ...
    iqr(shiftDist(non_depth_ids))/2));
v=axis;
axis([1 length(shiftDist) v(3:4)]);

%3D plot of and pre vs. post shift correction locations
axH(2)=subplot(122);
for a=1:nChan
    h=plot3(leptoRAS(a,1),leptoRAS(a,2),leptoRAS(a,3),'r.'); hold on;
    set(h,'color',rgb(a,:),'markersize',25);
    clickText(h,chanName{a});
    h=plot3(ctRAS(a,1),ctRAS(a,2),ctRAS(a,3),'bo');
    %clickText(h,rm_substring(labels{a},'_'));
    clickText(h,chanName{a});
    plot3([leptoRAS(a,1) ctRAS(a,1)],[leptoRAS(a,2) ctRAS(a,2)],[leptoRAS(a,3) ctRAS(a,3)],'k-');
end
if mean(leftHem)>=0.5
    % Left electrode majority
    view([-76 12]);
else
    view([100 16]);
end
axis tight;
axis square;
title('Red=Postcorrection, Blue=Precorrection');
xlabel('Left- Right+');
ylabel('Pos- Ant+');
zlabel('Inf- Sup+');

if universalYes(printEm)
    % Make sure PICS directory exists
    outPath = fullfile(erPath,['PICS_' char(datetime('now','TimeZone','local','Format','yyMMdd'))]);
    if ~exist(outPath,'dir')
        dirSuccess=mkdir(outPath);
        if ~dirSuccess
            error('Could not create directory %s',dirSuccess);
        end
    end
    outFigFname=fullfile(outPath,sprintf('%s_ShiftDist.jpg',sub));
    print(figH(1),'-djpeg',outFigFname);
    outFigFname=fullfile(outPath,sprintf('%s_ShiftDist',sub));
    saveas(figH(1),[outFigFname '.fig']); % PM edit 20160405
end

% Plot shift distances on pial surface
if ~isempty(non_depth_ids)
    if universalYes(plotPial)
        if sum(leftHem)
            if sum(~leftHem)
                vw='omni';
            else
                vw='lomni';
            end
        else
            vw='romni';
        end
        if printEm; figH(2)=figure('Visible','off');
        else; figH(2)=figure; end
        cfg=[];
        cfg.view=vw;
        cfg.figId=figH(2);
        cfg.elecColors=shiftDist;
        cfg.elecColorScale='justpos';
        cfg.elecUnits='mm';
        cfg.elecNames=chanName;
        cfg.showLabels='n';
        cfg.title=sprintf('%s: CT to Leptomeningeal distance',sub);
        plotPialSurf(sub,cfg);

        if universalYes(printEm)
            outFigFname=fullfile(outPath,sprintf('%s_ShiftDistOnBrain.jpg',sub));
            print(figH(2),'-djpeg',outFigFname);
        end
    end
end
end
