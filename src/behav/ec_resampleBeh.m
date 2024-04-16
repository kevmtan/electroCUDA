function [errors,n,trialNfo,psy] = ec_resampleBeh(n,a)
% Check inputs
arguments
    n struct
    a.dsTarg double = [] % Downsampling target freq
    a.save logical = false
    a.redo logical = false
end
sbj = n.sbj;
task = n.task;
dirs = n.dirs;
dsTarg = a.dsTarg;

if ~isfield(n,'dirOut'); n.dirOut=dirs.procSbj; end % Output directory
if ~isfield(n,'fnStr');  n.fnStr="s"+dirs.sbjID+"_"+task; end % Filename ending string
if ~isfolder(n.dirOut); mkdir(n.dirOut); end
errors={};
% arg.save=0; arg.redoCh=0; arg.redoTr=0; arg.redoPsy=1;

%% Initialize info struct

% Add file strings
n.fnStr = n.fnStr;
n.suffix = n.suffix;
hz = n.hz;

% Figure out downsampling factor
if dsTarg>0; ds=floor(n.hz_og/dsTarg); else; ds=1; end
if ds~=1; hz=dsTarg; disp(sbj+": downsampling task events...");
else; dsTarg=0; disp(sbj+": dsT <= 1, not downsampling..."); end
if hz==n.hz_og; hz_s=""; else; hz_s=num2str(hz); end


%% Get task events
fn = n.dirOut+"trialNfo"+hz_s+"_"+n.fnStr;
if ~isfile(fn) || a.redo
    % Run
    [trialNfo,n,errorsEvent] = ec_getEventIdx(sbj,n,dsTarg);
    if nnz(~cellfun(@isempty,errorsEvent)); errors{end+1,1} = errorsEvent; end
else
    load(fn,"trialNfo");
end

%% Align task events & neural data
fn = n.dirOut+"psy"+hz_s+"_"+n.fnStr;
if ~isfile(fn) || a.redo
    try
        times = (1:n.nFrames)'/hz;
        [psy,trialNfo] = ec_alignNeuroBehav(trialNfo,sbj,n.runs,n.runIdx,times,hz,n);
    catch ME; warning("psy ERROR: "+sbj); getReport(ME)
        errors{end+1,1} = ME;
        psy = [];
    end
else
    load(fn,"psy");
end

%% Finalize
n.hz = hz; % changed if downsampled
n.errorPsy = errors;

% Save to disk
if a.save
    fn = n.dirOut+"trialNfo"+hz_s+"_"+n.fnStr;
    if ~isfile(fn) || a.redo
        save(fn,"trialNfo","-v7"); disp("SAVED: "+fn)
    end

    fn = n.dirOut+"psy"+hz_s+"_"+n.fnStr;
    if ~isfile(fn) || a.redo
        save(fn,"psy","-v7"); disp("SAVED: "+fn)
    end
end
disp([sbj ': finished trialNfo & psy']);