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
nOg = ec_loadSbj(n.dirs,sfx="",vars="n"); % Load original nfo struct
varNames = string(n.xBad.Properties.VariableNames); % Bad frame metric names
[ds1,ds2] = rat(a.hzTarget/n.hz_og); % Downsample factors
if ds1==1 && ds2==1
    warning("[ec_resampleBadFrames] n"+n.suffix+"_"+n.fnStr+": Target & original sampling rates are equal");
    return
end


%% Main
xBad = table; % Create new bad frames table

% Loop across metrics
for v = varNames
    % Convert metric array to nonsparse double for max accuracy
    x = double(full(n.xBad.(v)));
    x = mat2cell(x,nOg.runIdxOg); % Split array by run

    % Resample by run (avoids edge artifacts)
    for r = 1:n.nRuns
        x{r} = resample(x{r},ds1,ds2,max([ds1 ds2 10])); % Resample w antialiasing filter
        x{r} = sparse(x{r}>=0.5); % Convert back to sparse logical
    end

    % Concactenate runs, store in table
    xBad.(v) = vertcat(x{:});
end


%% Finalize

% Check if # frames matches 
if height(xBad)~=n.nFrames
    error("[ec_resampleBadFrames] n"+n.suffix+"_"+n.fnStr+": Mismatched height between resampled bad frames & EEG data");
end

% Save resampled table to nfo struct
n.xBad = xBad;