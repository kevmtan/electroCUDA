function [wts,sph,winv,cfg,icact] = ec_cudaica(x,wtsIn,o)
%% cudaica_wrapper - use CUDAICA in Matlab
%    Call a precompiled CUDAICA binary from the Matlab workspace
%    CUDAICA is a GPU implementation of Infomax ICA (~25x speedup)
%
% Inputs:
%   x(chans,frames) = data to decompose
%   wtsIn(comps,chans) = starting weights (e.g. from previous ICA decomposition)
%   o.bin = full filepath of compiled CUDAICA binary
%
% Outputs:
%   wts(comps,chans) = Weight matrix
%   sph(chans,comps) = Sphering matrix
%   winv(chans,comps) = Mixing matrix (backprojection of ICs into channels)
%   status = cudaica was succsefful (logical)
%   cfg = runtime configuration script & output log
%   icact(comps,frames) = Reconstructed IC activity timecourses
%        
% NOTE: use agressively cleaned data for ICA decomposition (hipass & outlier rejection),
%       then revert to rawer data for IC reconstruction (icact = wts*sph*data)
%
%
%               Kevin Tan, 2022 (http://github.com/kevmtan/electroCUDA)
%
%
% ACKNOWLEDGEMENTS:
%    * Schwartz Center for Cognitive Neuroscience @ UC San Diego
%    * Fede Raimondo @ Forschungszentrum Jülich
% LICENSE: GNU General Public License
% DISCLAIMER: Use this code at your own risk. Author assumes no responsibility
%    for any adverse outcomes related this code or its use. Author makes no
%    guarantees on the performance or accuracy of this code. This code is for
%    research purposes only. NOT INTENDED FOR MEDICAL USE.

arguments
    x {mustBeFloat}
    wtsIn {isfloat,isstring,ischar} = ''
    o.sphering {mustBeMember(o.sphering,["on" "off"])} = "on"  % Sphering of data (on/off)   {default: on}
    o.bias {mustBeMember(o.bias,["on" "off"])} = "on"          % Perform bias adjustment (on/off) {default: on}
    o.extended {isnumeric} = 1                                 % Perform "extended-ICA" using tnah() with kurtosis estimation every N training blocks. If N < 0, fix number of sub-Gaussian components to -N 
    o.pca {isnumeric} = 0  % DONT TURN ON                      % Decompose a principal component subspace of
    o.lrate {isfloat} = 1e-4;                                  % Start learning rate (0<float<<1) {default: 1e-4}
    o.blocksize {isinteger} = 0                                % int>=0        [0 default: heuristic, from data size]
    o.stop {isfloat} = "" %1e-7                                % Stop learning rate {default: 1e-7, heuristic} 
    o.maxsteps {isinteger} = 512                               % int>0         {default: 512}
    o.posact {mustBeMember(o.posact,["on" "off"])} = "off"     % Make maximum value for each comp positive.
    o.annealstep {isfloat} = 0.98
    o.annealdeg {isnumeric} = 60
    o.momentum {isnumeric} = 0
    o.verbose {mustBeMember(o.verbose,["on" "off"])} = "off"   % Verbose terminal output
    o.sfx {isstring,ischar} = ""                               % Suffix for filenames
    o.dir {isstring,ischar} = pwd                              % Directory to save in
    o.dry logical = false                                      % Dry run - preparation only
    o.double logical = false % DONT TURN ON                    % Double precision all steps (float64) - CRITICAL but slower
    o.bin {mustBeText} = "/home/kt/Documents/MATLAB/cudaica-master/cudaica" % Path to CUDAICA compiled binary
end
if ~isempty(o.sfx) && o.sfx~=""; sfx="_"+o.sfx; else; sfx=""; end
wts=[]; sph=[];

%% Get arguments for script
o.dir = string(o.dir);

% Data matrix
if size(x,1)>size(x,2); x=x'; end
nChs = size(x,1);
nFrames = size(x,2);

% Filenames
fnSc = o.dir+"cudaica"+sfx+".sc";
fnDat = o.dir+"cudaica"+sfx+".fdt";
fnWts = o.dir+"cudaica"+sfx+".wts";
fnSph = o.dir+"cudaica"+sfx+".sph";
fnWtsIn = "";
if ~isempty(wtsIn)
    if isstring(wtsIn) || ischar(wtsIn)
        fnWtsIn = wtsIn;
    else
        fnWtsIn = o.dir+"cudaica"+sfx+".wtsIn";
    end
end

%% Make CUDAICA runtime config script
sc = repmat("",27,2);

% These arguments must be at *exactly* these line positions... yes annoying
sc(1,1)="DataFile";           sc(1,2)=fnDat;
sc(3,1)="chans";              sc(3,2)=nChs;
sc(4,1)="frames";             sc(4,2)=nFrames;
sc(5,1)="WeightsOutFile";     sc(5,2)=fnWts;
sc(6,1)="SphereFile";         sc(6,2)=fnSph;
sc(7,1)="sphering";           sc(7,2)=o.sphering;
sc(8,1)="bias";               sc(8,2)=o.bias;
sc(9,1)="extended";           sc(9,2)=o.extended;
sc(13,1)="pca";               sc(13,2)=o.pca;
sc(14,1)="lrate";             sc(14,2)=o.lrate;
sc(16,1)="blocksize";         sc(16,2)=o.blocksize;
sc(18,1)="stop";              sc(18,2)=o.stop;
sc(20,1)="maxsteps";          sc(20,2)=o.maxsteps;
sc(21,1)="posact";            sc(21,2)=o.posact;
sc(23,1)="annealstep";        sc(23,2)=o.annealstep;
sc(25,1)="annealdeg";         sc(25,2)=o.annealdeg;
sc(26,1)="momentum";          sc(26,2)=o.momentum;
sc(27,1)="verbose";           sc(27,2)=o.verbose;
sc(isempty(sc(:,2))|sc(:,2)=="",1) = "";
if fnWtsIn~=""
    sc(28,1)="WeightsInFile";     sc(28,2)=fnWtsIn;
end

% Save as plain text script
writematrix(sc,fnSc,'Delimiter',' ',"FileType","text");


%% Write data
if o.double; prec="float64"; else; prec="float"; end

% EEG data
fID = fopen(fnDat,"w");
fwrite(fID,x,prec);
fclose(fID);

% Pre-existing input weights
if ~isempty(wtsIn) && isnumeric(wtsIn)
    fID = fopen(fnWtsIn,"w");
    fwrite(fID,wtsIn,prec);
    fclose(fID);
end
if o.dry; return; end

%% Run CUDAICA
[status,cmdout] = system(o.bin+" -f "+fnSc,'-echo');
system("rm "+fnDat);
%if ~status; warning("CUDAICA FAILED"); return; end

% Read weights
fID = fopen(fnWts,"r");
wts = fread(fID,[nChs nChs],prec);
fclose(fID);

% Read sphere
fID = fopen(fnSph,"r");
sph = fread(fID,[nChs nChs],prec);
fclose(fID);

% Calculate mixing matrix
winv = pinv(wts * sph); 

% Collate config script & terminal output
if nargout>=4
    cfg = struct;
    cfg.status = status;
    cfg.sc = sc;
    cfg.log = cmdout;
end

% Reconstruct IC activity
if nargout>=5
    icact = (n.icWeights * n.icSphere) * x;
end

end
% cudaica() - Run stand-alone binary version of runica() from the
%            Matlab command line. Saves time and memory relative
%            to runica().  If stored in a float file, data are not 
%            read into Matlab, and so may be larger than Matlab
%            can handle owing to memory limitations.
% Usage:
%  >> [wts,sph] = cudaica( datavar,  'key1', arg1, 'key2', arg2 ...);
% else
%  >> [wts,sph] = cudaica('datafile', chans, frames, 'key1', arg1, ...);
%
% Inputs:
%   datavar       - (chans,frames) data matrix in the Matlab workspace
%   datafile      - quoted 'filename' of float data file multiplexed by channel
%     channels    -   number of channels in datafile (not needed for datavar)
%     frames      -   number of frames (time points) in datafile (only)
%
% Optional flag,argument pairs:
%   'extended'   - int>=0        [0 default: assume no subgaussian comps]
%                  Search for subgaussian comps: 'extended',1 is recommended
%   'pca'        - int>=0        [0 default: don't reduce data dimension]
%                    NB: 'pca' reduction not recommended unless necessary
%   'sphering'   - 'on'/'off'    first 'sphere' the data {default: 'on'}    
%   'lrate'      - (0<float<<1) starting learning rate {default: 1e-4}
%   'blocksize'  - int>=0        [0 default: heuristic, from data size]
%   'maxsteps'   - int>0         {default: 512}
%   'stop'       - (0<float<<<1) stopping learning rate {default: 1e-7} 
%                    NB: 'stop' <= 1e-7 recommended
%   'weightsin'  - Filename string of inital weight matrix of size
%                  (comps,chans) floats, else a weight matrix variable 
%                  in the current Matlab workspace (copied to a local
%                  .inwts files). You may want to reduce the starting 
%                  'lrate' arg (above) when resuming training, and/or 
%                  to reduce the 'stop' arg (above). By default, binary 
%                  ica begins with the identity matrix after sphering. 
%   'verbose'    - 'on'/'off'    {default: 'off'}
%   'filenum'    - the number to be used in the name of the output files.  
%                  Otherwise chosen randomly. Will choose random number 
%                  if file with that number already exists.
%
% Less frequently used input flags:
%   'posact'     - ('on'/'off') Make maximum value for each comp positive.
%                    NB: 'off' recommended. {default: 'off'} 
%   'annealstep' - (0<float<1)   {default: 0.98}
%   'annealdeg'  - (0<n<360)     {default: 60} 
%   'bias'       - 'on'/'off'    {default: 'on'}    
%   'momentum'   - (0<float<1)   {default: 0 = off]
%
% Outputs:
%   wts          - output weights matrix, size (ncomps,nchans)
%   sph          - output sphere matrix, size (nchans,nchans)
%                  Both files are read from float files left on disk
%   stem         - random integer used in the names of the .sc, .wts, 
%                  .sph, and if requested, .intwts files
%
% Author: Scott Makeig, SCCN/INC/UCSD, La Jolla, 2000 
%
% See also: runica()
