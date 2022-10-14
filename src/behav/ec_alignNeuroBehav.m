function [psy,trialNfo] = ec_alignNeuroBehav(trialNfo,sbj,runs,blockIdx,times,fs,o)
% Check inputs
if ~isfield(o,'BLpre'); o.BLpre = [-.2 0]; end % Pre-stimulus (default: [-.2 0])
if ~isfield(o,'BLend'); o.BLend = []; end      % Post-stimulus (default: [])

%%
numTrials = height(trialNfo);

idx = find(~isnan(trialNfo.idxRT)); idx = idx(idx<height(trialNfo));
if nnz(trialNfo.idxRT(idx)==trialNfo.idxITI(idx+1))/height(idx) > 0.25
    idxITIadd = 1; idxITImin = 0; disp(sbj+": idxRT(t) = idxITI(t+1)");
else
    idxITIadd = 0; idxITImin = 1; disp(sbj+" NOT EQUAL: idxRT(t) & idxITI(t+1)");
end

% Convert BL time to points
idxBLpre = floor(o.BLpre * fs);
idxBLpre = idxBLpre(1):idxBLpre(2)-1;
if ~isempty(o.BLend)
    idxBLend = floor(o.BLend * fs);
else
    idxBLend = floor([-0.1 0] * fs);
end
idxBLend = idxBLend(1):idxBLend(2);

% Prepare psy
psy = table;
psy.time = times;
psy.run(:) = uint8(0);
psy.trialA(:) = uint16(0);
psy.cond(:) = "";
psy.frame(:) = int32(0);
psy.latency(:) = nan;
psy.pct(:) = nan;
psy.stim(:) = false;
psy.RT(:) = nan;
psy.postRT(:) = uint16(0);
psy.BLpre(:) = uint16(0);
psy.BLend(:) = uint16(0);
psy.idx(:) = uint32(1:height(psy));
for b = 1:length(runs)
    psy.run(blockIdx(b,1):blockIdx(b,2)) = runs(b);
end

for t = 1:numTrials
    % idxStim
    idxStim = trialNfo.idxStim(t);
    if idxStim>blockIdx(runs==trialNfo.run(t),2)
        warning("idxStim > blockIdx(runs==trialNfo.run(t),2)");
        idxStim=blockIdx(runs==trialNfo.run(t),2);
    end

    % idxITI
    if t==1 || trialNfo.run(t-1)~=trialNfo.run(t)
        idxITI = trialNfo.idxITI(t);
    else; idxITI = trialNfo.idxITI(t) + idxITIadd;
    end
    if idxITI>blockIdx(runs==trialNfo.run(t),2)
        warning("idxITI > blockIdx");
        idxITI=blockIdx(runs==trialNfo.run(t),2);
    end

    % IdxEnd
    if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
        if trialNfo.resp(t)=="none" || isundefined(trialNfo.resp(t)) || trialNfo.RT(t)==0
            idxEnd = idxStim + 15.3*fs;
        else; idxEnd = trialNfo.idxRT(t) + 0.3*fs;
        end
    else; idxEnd = trialNfo.idxStim(t+1)-1;
    end
    if idxEnd>blockIdx(runs==trialNfo.run(t),2)
        warning("idxEnd > blockIdx");
        idxEnd = blockIdx(runs==trialNfo.run(t),2);
    end

    % idxRT
    if trialNfo.resp(t)=="none" || isundefined(trialNfo.resp(t)) || trialNfo.RT(t)==0
        if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
            idxRT = idxEnd;
        else; idxRT = trialNfo.idxITI(t+1) - idxITImin;
        end
    else; idxRT = trialNfo.idxRT(t);
    end
    if idxRT>blockIdx(runs==trialNfo.run(t),2)
        warning("idxRT > blockIdx");
        idxRT = blockIdx(runs==trialNfo.run(t),2);
    end

    % idxTr
    if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
        idxTr = idxITI:idxEnd;
    else; idxTr = idxITI:idxRT;
    end
    trialNfo.durITI(t) = times(idxStim) - times(idxITI);
    trialNfo.durTrial(t) = times(idxTr(end)) - times(idxStim);
    trialNfo.idxITI(t) = idxITI;
    trialNfo.idxRT(t) = idxRT;
    trialNfo.idxEnd(t) = idxEnd;

    % Fill
    psy.trialA(idxTr) = trialNfo.trialA(t);
    psy.cond(idxTr) = trialNfo.cond(t);
    psy.latency(idxTr) = times(idxTr) - times(idxStim);
    psy.stim(idxStim:idxRT) = true;
    psy.RT(idxTr) = trialNfo.RT(t);
    psy.postRT(idxRT+1:idxEnd) = trialNfo.trialA(t);
    psy.BLpre(idxStim+idxBLpre) = trialNfo.trialA(t);
    psy.BLend(idxEnd+idxBLend) = trialNfo.trialA(t);
    psy.pct(idxStim:idxRT) = psy.latency(idxStim:idxRT) ./ psy.latency(idxRT);
    psy.pct(idxITI:idxStim-1) = psy.latency(idxITI:idxStim-1) ./ trialNfo.durITI(t);
    psy.pct(idxITI:idxStim-1) = psy.pct(idxITI:idxStim-1) ./ 10;
end
psy.frame = int16(psy.latency*fs);
disp(['Aligned task data to neural data: ' sbj]);
end