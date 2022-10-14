function [x,errors,chMissing] = load_iEEG_LBCN(sbj,proj,blocks,dirs,errors,arg)
%% Input validation
arguments
    sbj % Subject name
    proj {mustBeText} = 'MMR' % Project name
    blocks {mustBeText} = []
    dirs {isstruct,isstring,ischar} = 'Kevin_DMN'
    errors cell = {}
    arg.blockOut logical = false
end

% Load missing
if ~isstruct(dirs) || isempty(dirs)
    dirs = ec_getDirs(dirs,sbj,proj);
end
if isempty(blocks); blocks = BlockBySubj(sbj,proj); end

%% Main
nBlocks = numel(blocks);
x = cell(nBlocks,1);
blockLength = nan(nBlocks,1);
chMissing = [];
for b = 1:nBlocks
    bn = blocks{b};
    fn = dirs.origSbj+filesep+"global_"+proj+"_"+sbj+"_"+bn;
    load(fn,'globalVar');
    
    % Format the data
    chFn = dirs.origSbj+bn+filesep+"iEEG"+bn+"_";
    try
        blockLength(b) = globalVar.chanLength;
    catch ME; getReport(ME)
        load([chFn '01.mat'],'wave')
        blockLength(b) = size(wave,2);
        clear wave
    end
    
    % Load channel data
    x1 = zeros(blockLength(b),globalVar.nchan); % initialize data variable
    for ch = 1:globalVar.nchan
        % lame hack-around for channel names
        if ch<10; nl = "0"+ch;
        else; nl = string(ch); end
        
        % Load iEEG data
        try load(chFn+nl,'wave');
            %disp(['Loaded electrode ' nl ' out of ' num2str(globalVar.nchan)]);
        catch ME; getReport(ME)
            warning("Load error, filling with NaNs: "+chFn+nl+".mat");
            errors{end+1,1} = {lastwarn,ME}; %#ok<AGROW>
            chMissing(end+1) = ch; %#ok<AGROW> 
        end
        wave = wave'; %because has incorrect ordering for efficiency, should be time x 1
        x1(:,ch) = -wave; % invert: data are recorded inverted
    end
    x{b,1} = x1;
    disp("Loaded electrodes: "+bn);
end

if ~arg.blockOut
    x = vertcat(x{:});
end
chMissing = unique(chMissing);
disp("Finished loading elecs all blocks: "+sbj);