function [trialNfo,n,errors] = ec_getEventIdx(sbj,n,dsTarg)
arguments
    sbj string
    n struct
    dsTarg double = []
end

% Vars
blocks = n.blocks;
nBlocks = n.nBlocks;
dirs = n.dirs;
task = n.task;
doDS = dsTarg>1;

% Preallocate
errors = {};
runIdx = nan(nBlocks,2);
runIdxOg = nan(nBlocks,2);
runTimes = nan(nBlocks,2);
runTimesOg = nan(nBlocks,2);
blockEndIdx = nan(nBlocks,1);
blockEndTime = nan(nBlocks,1);
trialNfoB = cell(nBlocks,1);

% Get events per block
for b = 1:nBlocks
    bn = blocks(b);
    fn = dirs.origSbj+"global_"+task+"_"+sbj+"_"+bn+".mat";
    load(fn,'globalVar');
    hz = floor(globalVar.iEEG_rate);
    if doDS; ds = floor(hz/dsTarg); end
    
    % Load trialNfo
    fn = dirs.psychSbj+filesep+bn+filesep+"trialNfo_"+sbj+"_"+bn+".mat";
    load(fn, "trialNfo");
    lockStim = trialNfo.lockStim; % Stimulus onsets
    lockRT = trialNfo.lockRT; % RT onsets

    % Get last block index
    if doDS
        iDS = 1:ds:globalVar.chanLength; % Downsample
        blockEndIdx(b) = length(iDS);
        hz = dsTarg;
    else
        blockEndIdx(b) = globalVar.chanLength;
    end

    % Calculate block indices and timing
    blockEndTime(b) = blockEndIdx(b)/hz;
    if b==1
        runIdx(b,:) = [1 blockEndIdx(b)]; 
    else
        runIdx(b,1) = runIdx(b-1,2) + 1;
        runIdx(b,2) = runIdx(b-1,2) + blockEndIdx(b);
    end
    runIdxOg(b,:) = [1 blockEndIdx(b)];
    runTimes(b,:) = runIdx(b,:) ./ hz;
    runTimesOg(b,:) = runIdxOg(b,:) ./ hz;
    
    % Figure out ITI after trials with no RT
    noRTtrials = find(trialNfo.resp=="none" | isundefined(trialNfo.resp) |...
        trialNfo.cond=="rest" | isnan(trialNfo.RT) | trialNfo.RT==0);
    noRTtrials(noRTtrials > height(trialNfo)-1) = []; % if last trial has no RT
    noRTrest = trialNfo.cond(noRTtrials)=="rest";

    % Make estimated ITI durations
    noRTnextITIdur = nan(length(noRTtrials),1);
    noRTnextITIdur(noRTrest) = 0.3;
    noRTnextITIdur(~noRTrest) = 0.2; % who knows when trial end, 0.2s is min ITI

    % Check if ITI timings inconsistent
    noRTdiff = lockStim(noRTtrials+1) - lockStim(noRTtrials);
    noRTnextITIdur(noRTnextITIdur>noRTdiff) = noRTdiff(noRTnextITIdur>noRTdiff);
    
    % Prep timing & indices table fields
    trialNfo.durITI(:) = nan;
    trialNfo.durTrial(:) = nan; % Duration of stimulus + next ITI
    trialNfo.durRT(:) = nan;
    trialNfo.onsITI(:) = nan;
    trialNfo.onsStim = lockStim;
    trialNfo.onsRT = lockRT;
    
    % Calculate event timings
    trialNfo.durITI(1) = 0.3;
    trialNfo.durITI(2:end) = trialNfo.onsStim(2:end) - trialNfo.onsRT(1:end-1);
    trialNfo.durITI(noRTtrials+1) = noRTnextITIdur;
    trialNfo.onsITI = trialNfo.onsStim - trialNfo.durITI;
    trialNfo.durTrial(1:end-1) = trialNfo.onsStim(2:end) - trialNfo.onsStim(1:end-1);
    if isnan(trialNfo.RT(end))
        trialNfo.durTrial(end) = 15.3;
    else
        trialNfo.durTrial(end) = (trialNfo.onsRT(end) - trialNfo.onsStim(end)) + 0.3;
    end
    if trialNfo.onsStim(end)+trialNfo.durTrial(end) > blockEndTime(b)
        trialNfo.durTrial(end) = blockEndTime(b);
    end
    
    % Calculate event indices
    trialNfo.idxITI = round(trialNfo.onsITI * hz);
    trialNfo.idxStim = round(trialNfo.onsStim * hz);
    trialNfo.idxRT = round(trialNfo.onsRT * hz);
    trialNfo.idxEnd(:) = nan;
    trialNfo.idxEnd(1:end-1) = trialNfo.idxStim(2:end)-1;
    trialNfo.idxEnd(end) = trialNfo.idxStim(end) + round(trialNfo.durTrial(end) * hz);
    
    %% Warnings
    errorsB = {};
    idx = trialNfo{:,["onsITI" "onsStim" "onsRT"]} > blockEndTime(b);
    if nnz(idx)
        warning("[onsITI onsStim onsRT] > blockEndTime "+sbj+" "+bn);
        errorsB{end+1,1} = {"[onsITI onsStim onsRT] > blockEndTime ",idx}; %#ok<*AGROW> 
        trialNfo.onsITI(idx(:,1)) = blockEndTime(b);
        trialNfo.onsStim(idx(:,2)) = blockEndTime(b);
        trialNfo.onsRT(idx(:,3)) = blockEndTime(b);
    end
    idx = trialNfo{:,["idxITI","idxStim","idxRT","idxEnd"]} > blockEndIdx(b);
    if nnz(idx)
        warning("[idxITI idxStim idxRT idxEnd] > blockEndTime: "+sbj+" "+bn);
        errorsB{end+1,1} = {"[idxITI idxStim idxRT idxEnd] > blockEndTime: ",idx};
        trialNfo.idxITI(idx(:,1)) = blockEndIdx(b);
        trialNfo.idxStim(idx(:,2)) = blockEndIdx(b);
        trialNfo.idxRT(idx(:,3)) = blockEndIdx(b);
        trialNfo.idxEnd(idx(:,4)) = blockEndIdx(b);
    end
    idx = trialNfo{:,["idxITI","idxStim","idxRT","idxEnd"]} < 1;
    if nnz(idx)
        warning("[idxITI,idxStim,idxRT,idxEnd] < 1: "+sbj+" "+bn);
        errorsB{end+1,1} = {"[idxITI,idxStim,idxRT,idxEnd] < 1: ",idx};
        trialNfo.idxITI(idx(:,1)) = 1;
        trialNfo.idxStim(idx(:,2)) = 1;
        trialNfo.idxRT(idx(:,3)) = 1;
        trialNfo.idxEnd(idx(:,4)) = 1;
    end
    idx = trialNfo.idxITI > trialNfo.idxStim;
    if nnz(idx)
        warning("idxITI > idxStim for: "+sbj+" "+bn);
        errorsB{end+1,1} = {"idxITI > idxStim",idx};
    end
    idx = trialNfo.idxStim > trialNfo.idxRT;
    if nnz(idx); warning("idxStim > idxRT for: "+sbj+" "+bn);
        errorsB{end+1,1} = {"idxITI > idxStim",idx};
    end
    idx = trialNfo.idxRT > trialNfo.idxEnd;
    if nnz(idx); warning("idxRT > idxEnd for: "+sbj+" "+bn);
        errorsB{end+1,1} = {"idxITI > idxStim",idx};
    end
    idx = trialNfo.idxStim > trialNfo.idxEnd;
    if nnz(idx); warning("idxStim > idxEnd: "+sbj+" "+bn);
        errorsB{end+1,1} = {"idxStim > idxEnd",idx};
    end

    %% Organize

    % Delete redundant vars
    trialNfo(:,["key","Operand1","Operand2","OperandMin","OperandMax","Operator","CorrectResult",...
        "PresResult","Deviant","AbsDeviant","StimulusOnsetTime","Accuracy","lockStim","lockRT"]) = [];
    
    if b>1 % Add last time & index for previous block     
        trialNfo{:,["onsITI","onsStim","onsRT"]} = trialNfo{:,["onsITI","onsStim","onsRT"]} + runTimes(b-1,2);
        trialNfo{:,["idxITI","idxStim","idxRT","idxEnd"]} = trialNfo{:,["idxITI","idxStim","idxRT","idxEnd"]} + runIdx(b-1,2);
    end

    trialNfoB{b} = trialNfo; % Copy to cell
    if nnz(~cellfun(@isempty,errorsB)); errors{end+1,1} = vertcat(errorsB{:}); end
end

%% Finalize
trialNfo = vertcat(trialNfoB{:});
trialNfo.trialA = uint16(1:height(trialNfo))';
trialNfo = movevars(trialNfo,'trialA','Before','run');
if nnz(~cellfun(@isempty,errors)); errors = vertcat(errors{:}); end


% n struct
n.nFrames = runIdx(end,2);
n.nRuns = length(unique(trialNfo.run));
n.nTrials = height(trialNfo);
n.runs = unique(trialNfo.run);
n.runIdx = runIdx;
n.runIdxOg = runIdxOg;
n.runTimes = runTimes;
n.runTimesOg = runTimesOg;

