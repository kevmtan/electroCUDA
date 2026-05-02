function n = ec_resampleBadFrames(n,a)
% ec_resampleBadFrames - resamples bad frames table (n.xBad), call this
% function from 'ec_initialize'

%% Input validation
arguments
    n struct % nfo struct for analysis
    a.hzTarget double = n.hz % Target sampling rate (hz)
end
if ~isany(a.hzTarget)
    a.hzTarget = n.hz; end

% Check for errors
if height(n.xBad)==n.xFrames
    warning("[ec_resampleBadFrames] n"+n.suffix+"_"+n.fnStr+": EEG data already same height as bad frames table");
    return
elseif a.hzTarget==n.hz_og
    warning("[ec_resampleBadFrames] n"+n.suffix+"_"+n.fnStr+": Target & original sampling rate are equal");
    return
end


%% Prep

% Load original nfo struct for runIdxOg
nOg = ec_loadSbj(n.dirs,sfx="",vars="n");
if height(n.xBad)~=nOg.xFrames; error("Height of n"+n.suffix+".xBad ~= n.xFrames"); end

% Run indices
id = 1:nOg.xFrames;
id = mat2cell(id',nOg.runIdxOg);

% Downsample factors
[ds1,ds2] = rat(a.hzTarget/n.hz_og);

% Bad frame metric variable names
varNames = string(n.xBad.Properties.VariableNames);

% Initialize resampled bad frames table
xBad = table; 


%% Resample metrics
for v = varNames
    % Metric prep
    x = double(full(n.xBad.(v))); % convert metric to nonsparse double for max accuracy
    y = cell(n.nRuns,1); % preallocate resampled metric

    % Resample by run (avoids edge artifacts)
    for r = 1:n.nRuns
        z = resample(x(id{r},:,:),ds1,ds2); % resample w antialiasing filter
        y{r} = sparse(z >= 0.5); % convert back to sparse logical
    end

    % Concatenate runs, store in table
    xBad.(v) = vertcat(y{:});
end


%% Finalize

% Check if # frames matches 
if height(xBad)~=n.nFrames
    error("[ec_resampleBadFrames] n"+n.suffix+"_"+n.fnStr+": Mismatched height between resampled bad frames & EEG data");
end

% Save resampled table to nfo struct
n.xBad = xBad;