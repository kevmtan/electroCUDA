function cort = readSurfTri(cort)
% Kevin Tan, 2022 (github.com/kevmtan/electroCUDA)
% Reads freesurfer cortex & converts to triangulation object

if ischar(cort) || isstring(cort)
    fnCort = fullfile(cort);
    cort = struct;
    [cort.vert,cort.tri] = read_surf(fnCort);
end

% Convert to freesurfer cort to matlab triangulation object
if isa(cort,'struct')
   % Sometimes this is needed sometimes not. no comprendo. DG ??
    if min(min(cort.tri))<1
        cort.tri = cort.tri + 1;
    end

    % Convert
    cort = triangulation(cort.tri,cort.vert);

    %if doGPU
    %    cort.vert = gpuArray(cort.vert);
    %    cort.tri = gpuArray(cort.tri);
    %end
    %try cort = triangulation(cort.tri,cort.vert);
    %catch; cort = trianglation(gather(cort.tri),gather(cort.vert)); end
elseif isa(cort,'triangulation')
    disp("NOTICE: 'cort' already a triangulation object, skipping...");
else
    warning("'cort' is an unsupported filetype, skipping...");
end
