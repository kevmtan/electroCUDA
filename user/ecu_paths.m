function dirs = ecu_paths(proj)
arguments
    proj string = "writeDefaultHere" % Project name
end
dirs.proj = proj;

%% User paths (must edit per user!)
% NOTE: directory paths must end with a slash

% electroCUDA code directory
dirs.code = "/home/kt/Gdrive/Git/electroCUDA/";

% Paths to executable binaries
dirs.cudaica = "/home/kt/bin/cudaica-kt/cudaica"; % CUDAICA binary file
dirs.thundersvm = "/home/kt/bin/thundersvm-gpu/build/bin/"; % ThunderSVM binary folder

% Root dir of project data (can change per proj below)
dirs.data = "/01/lbcn/"; 

% Freesurfer subjects dir (can be in freesurfer install location, can change per project)
dirs.freesurfer = "/01/lbcn/freesurfer/";

% Project directories (add new case per project)
switch proj
    case "lbcn"
        dirs.data = "/01/lbcn/"; % Root dir of project data
        dirs.freesurfer = "/01/lbcn/freesurfer/"; % Freesurfer subjects dir (can be in freesurfer install location)
    case "ov"
        dirs.data = "/01/ov/"; % Root dir of project data
        dirs.freesurfer = "/01/ov/freesurfer/"; % Freesurfer subjects dir (can be in freesurfer install location)
end


