function dirs = ecu_paths(proj)
arguments
    proj (1,1) string % Project name
end
dirs.proj = proj;

%% User-editable section
%   directory paths must end with a slash (filesep)

% Paths to executables
dirs.cudaica = "/home/kt/bin/cudaica-kt/cudaica"; % CUDAICA binary file
dirs.thundersvm = "/home/kt/bin/thundersvm-gpu/build/bin"; % ThunderSVM binary folder

% electroCUDA code directory
dirs.code = "/home/kt/Gdrive/Git/electroCUDA/";

% Project directories (add new case per project)
switch proj
    case "ov"
        % Root dir of project data
        dirs.data = "/01/ov/";
        % Freesurfer subjects dir (can be in freesurfer install location)
        dirs.freesurfer = "/01/ov/freesurfer/";
        % Get subject numeric ID from text string "sbj" (e.g., subject's directory name)
        dirs.getSbjID = @(sbj) double(sbj); % ex: "007" = 7

    case "lbcn"
        % Root dir of project data
        dirs.data = "/01/lbcn/";
        % Freesurfer subjects dir (can be in freesurfer install location)
        dirs.freesurfer = "/01/lbcn/freesurfer/";
        % Get subject numeric ID from text string (ex: "eeg_034_2025" = 34)
        dirs.getSbjID = @(sbj) double(extractBetween(sbj,"_","_"));
end


