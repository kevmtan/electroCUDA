function [logs,chNfoA] = ec_condConChs_perm(o,logs)
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
dirs = ec_getDirs(o.proj,o.task); % get directories
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
    logs.st(:) = string(missing);
    logs.n(:) = string(missing);
end

% Preallocate subject chan
chNfoA = cell(height(logs));
% sLog=logs(5,:); %sbj38
% sLog=logs(9,:); %sbj42
% sLog=logs(21,:); %sbj60


%% Run subjects
for s = 1:height(logs)
    if ~logs.fin(s)
        %% Run subject
        try
            [logs(s,:),chNfoA{s}] = runSbj_lfn(o,logs(s,:));
            logs.fin(s) = true;
        catch ME; warning(getReport(ME));
            logs.error{s} = ME;
            logs.fin(s) = false;
        end

        %% Save logs
        logs.time(s) = datetime("now",TimeZone="local",Format="yyMMdd_HHmm");
        save(o.outDir+"logs_"+o.analName,"logs","-v7");

    else
        disp("SKIPPING: "+logs.sbj(s));
    end
end


%% Finalize & save
chNfoA = vertcat(chNfoA{:}); % concatenate sbjChs

% Save sbjChs
if o.save
    save(o.outDir+"chNfoA_"+o.analName,"chNfoA");
end




function [sLog,chNfo] = runSbj_lfn(o,sLog)
%%% Run subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                               sLog=logs(5,:);
disp("STARTING: "+sLog.sbj);
tt = tic;
nCons = numel(o.contrasts);

% Subject directories/info
dirs = ec_loadSbj(sbj=sLog.sbj,proj=o.proj,task=o.task,sfx=o.p.sfx);
sLog.sbjID = dirs.sbjID;
sLog.dir = o.outDir+"s"+dirs.sbjID+filesep;
sLog.st = sLog.dir+"st";
sLog.n = sLog.dir+"n";

% Make subject output dir
if o.save && ~exist(sLog.dir,"dir")
    mkdir(sLog.dir);
end

% Convert o.condx cells to nContrasts-by-maxWidth string array (pad with missing)
if iscell(o.cond1)
    cond = repmat(string(missing),nCons,max(cellfun(@numel,o.cond1)));
    for c = 1:nCons
        cnd = string(o.cond1{c});
        cond(c,1:numel(cnd)) = cnd;
    end
    o.cond1 = cond;
end
if ~isempty(o.cond0) && iscell(o.cond0)
    cond = repmat(string(missing),nCons,max(cellfun(@numel,o.cond0)));
    for c = 1:nCons
        cnd = string(o.cond0{c});
        cond(c,1:numel(cnd)) = cnd;
    end
    o.cond0 = cond;
end

% Preallocate stats table
st = cell(nCons,1);


%% Prepare subject data
oo = namedargs2cell(o.p);               % expand name-value arguments
[x,ep,n] = ec_analPrep(dirs,tt,oo{:});  % run data prep
if isfield(n,"timesG"); n=rmfield(n,"timesG"); end % remove time group var
%if numel(dbstack)<2; n0=n; x0=x; end %#ok<NASGU>  % Copy origs for testing
% n=n0; x=x0; tt=tic; disp("Restored original sbj vars");


%% Reshape EEG data with epoch dimension
[x,ob,n] = ec_epoch2dim(x,ep,n,tt,trialVars=o.trialVars,test=o.test);


%% Run contrasts
for c = 1:nCons
    st{c} = contrast_lfn(x,ob,n,o,c,tt);
end


%% Finalize & save
chNfo = n.chNfo;

% Organize stats table
st = vertcat(st{:});
st.sbjID(:) = n.sbjID;
st = movevars(st,"sbjCh",Before=1);
st = movevars(st,["sbjID" "ch"],After=width(st));

% Save stats table
save(sLog.st,"st");
disp("[ec_condConChs] Saved: "+sLog.st+ " | toc="+toc(tt));

% Save subject/recording metadata
save(sLog.n,"n");
disp("[ec_condConChs] Saved: "+sLog.n+ " | toc="+toc(tt));






function sc = contrast_lfn(x,ob,n,o,c,tt)
%%% Run contrast wrapper %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run contrast
[sc,t,p,mu,ci,q,df] = ec_contrast_perm(x,ob,n,o,c,tt);
szOg = size(p); % size of 'p' before channel concatenation 

%% Organize

% Concatenate channels 
t = catChs_lfn(t,false);
p = catChs_lfn(p,false);
mu = catChs_lfn(mu,false);
ci = catChs_lfn(ci,height(ci)==2);

% Repeat table rows: full time column per channel block
sc = repmat(sc,n.xChs,1);
rowCh = repelem((1:n.xChs)',n.nTimes);
sc.sbjCh = n.chNfo.sbjCh(rowCh);
sc.ch = n.chNfo.ch(rowCh);

% Fill stats results table
sc.t = t;
sc.p = p;
sc.mu = mu;
if o.nPerm
    sc.ciL = ci(1,:,:);
    sc.ciH = ci(2,:,:);
else
    sc.se = ci;
end
if ~isempty(q)
    sc.q = catChs_lfn(q,false);
    sc = movevars(sc,"q",After="p");
end
if ~isempty(df)
    if isscalar(df)
        sc.df(size(p)) = df;
    elseif isequal(size(df),szOg)
        sc.df = catChs_lfn(df,false);
    else
        warning("[ec_condConChs_perm] df size mismatch vs [time×channel]; omitting sc.df");
    end
end




function z = catChs_lfn(v,ciBounds)
% Concatenate channels along the time dimension for long-format analyses
sz = size(v);
if ciBounds
    z = reshape(v,[2,sz(2)*sz(3),sz(4:end)]);
else
    if isvector(v)
        z = v(:);
    else
        z = reshape(v,[sz(1)*sz(2),sz(3:end)]);
    end
end