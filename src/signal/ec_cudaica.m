function [ica,x] = ec_cudaica(x,cudaica_bin,wtsIn,arg)
%% cudaica_wrapper - use CUDAICA in Matlab
%    Call a precompiled CUDAICA binary from the Matlab workspace
%    CUDAICA is a GPU implementation of Infomax ICA (~25x speedup)
%    PCA is done in-wrapper because it's broken on CUDAICA binary
%
% INPUTS: see 'Input validation' below
%
% OUTPUTS:
%   wts(comps,chans) = Weight matrix
%   sph(chans,comps) = Sphering matrix
%   winv(chans,comps) = Mixing matrix (backprojection of ICs into channels)
%   status = cudaica was succsefful (logical)
%   cfg = runtime configuration script & output log
%   icact(comps,frames) = Reconstructed IC activity timecourses
%        
% NOTE: use agressively cleaned data for ICA decomposition (detrend & outlier rejection),
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

%% Input validation
arguments
    x {mustBeFloat}                      % x(frames,chans) = data to decompose
    cudaica_bin {mustBeText}             % Path to CUDAICA compiled binary
    wtsIn {isfloat,isstring,ischar} = '' % wtsIn(comps,chans) = starting weights (e.g. from previous ICA decomposition)
    % Name-value arguments
    arg.pca {isnumeric} = []             % Number of PCA components to decompose {auto=[], skip=0}
    arg.sfx string = ""                  % Suffix for filenames
    arg.dir string = pwd                 % Directory to save in
    arg.dry logical = false              % Dry run - don't call cudaica binary
    % CUDAICA flags
    arg.sphering {mustBeMember(arg.sphering,["on" "off"])} = "on" % Sphering of data (on/off)   {default: on}
    arg.bias {mustBeMember(arg.bias,["on" "off"])} = "on"         % Perform bias adjustment (on/off) {default: on}
    arg.extended {isnumeric} = 1                                  % Perform "extended-ICA" using tnah() with kurtosis estimation every N training blocks. If N < 0, fix number of sub-Gaussian components to -N 
    arg.lrate {isfloat} = 1e-4                                    % Start learning rate (0<float<<1) {default: 1e-4}
    arg.blocksize {isnumeric} = 0                                 % int>=0        [0 default: heuristic, from data size]
    arg.stop {isfloat} = ""                                       % Stop learning rate {default: 1e-7, heuristic} 
    arg.maxsteps {isnumeric} = 512                                % int>0         {default: 512}
    arg.posact {mustBeMember(arg.posact,["on" "off"])} = "off"    % Make maximum value for each comp positive.
    arg.annealstep {isfloat} = 0.98                               % (0<float<1)   {default: 0.98}
    arg.annealdeg {isfloat} = 60                                  % (0<n<360)     {default: 60} 
    arg.momentum {isfloat} = 0                                    % (0<float<1)   {default: 0 = off]
    arg.verbose {mustBeMember(arg.verbose,["on" "off" "matlab"])} = "off"  % Verbose terminal output
end
nFrames = size(x,1);
nChs = size(x,2);
if isempty(arg.lrate); arg.lrate=1e-4; end
if isempty(arg.stop); arg.stop=""; end
if ~isempty(arg.sfx) && arg.sfx~=""; sfx="_"+arg.sfx; else; sfx=""; end
if isempty(arg.pca)||arg.pca<=0; nComps=nChs; else; nComps=arg.pca; end
doFlip=true;
if size(x,2)>size(x,1); x=x'; doFlip=0; warning("data has more channels than frames, flipping..."); end

%% Prep

% Preallocate output
ica=struct; ica.wts=[]; ica.sph=[]; ica.w=[]; ica.winv=[]; ica.pca=[];

% Filenames
fnSc = arg.dir+"cudaica"+sfx+".sc";
fnDat = arg.dir+"cudaica"+sfx+".fdt";
fnWts = arg.dir+"cudaica"+sfx+".wts";
fnSph = arg.dir+"cudaica"+sfx+".sph";
fnWtsIn = "";
if ~isempty(wtsIn)
    if isstring(wtsIn) || ischar(wtsIn)
        fnWtsIn = wtsIn;
    else
        fnWtsIn = arg.dir+"cudaica"+sfx+".wtsIn";
    end
end

%% Ensure data not rank-deficient
xRank = ec_rank(x,true);
disp("Num components="+nChs+" | Data rank="+xRank);
if nComps>xRank && (isempty(arg.pca) || arg.pca==1)
    arg.pca = xRank;
    nComps = xRank;
    warning("[ec_cudaica] Data is rank deficient, reducing to "+xRank+" components with PCA");
elseif arg.pca>1
    arg.pca = arg.pca;
    nComps = arg.pca;
elseif isempty(arg.pca) || arg.pca<=0
    arg.pca = 0;
    nComps = nChs;
end

%% PCA (doing in Matlab because broken in cudaica)
if arg.pca > 1
    [wtsPCA,x] = pca(x,NumComponents=nComps,Centered=false);
    disp("[ec_cudaica] Reducing to "+nComps+" components with PCA");
end

%% Make CUDAICA config script
sc = repmat("",27,2);

% These arguments must be at *exactly* these line positions
sc(1,1)="DataFile";           sc(1,2)=fnDat;
sc(3,1)="chans";              sc(3,2)=nComps;
sc(4,1)="frames";             sc(4,2)=nFrames;
sc(5,1)="WeightsOutFile";     sc(5,2)=fnWts;
sc(6,1)="SphereFile";         sc(6,2)=fnSph;
sc(7,1)="sphering";           sc(7,2)=arg.sphering;
sc(8,1)="bias";               sc(8,2)=arg.bias;
sc(9,1)="extended";           sc(9,2)=arg.extended;
sc(14,1)="lrate";             sc(14,2)=arg.lrate;
sc(16,1)="blocksize";         sc(16,2)=arg.blocksize;
sc(18,1)="stop";              sc(18,2)=arg.stop;
sc(20,1)="maxsteps";          sc(20,2)=arg.maxsteps;
sc(21,1)="posact";            sc(21,2)=arg.posact;
sc(23,1)="annealstep";        sc(23,2)=arg.annealstep;
sc(25,1)="annealdeg";         sc(25,2)=arg.annealdeg;
sc(26,1)="momentum";          sc(26,2)=arg.momentum;
sc(27,1)="verbose";           sc(27,2)=arg.verbose;
sc(isempty(sc(:,2))|sc(:,2)=="",1) = "";
if fnWtsIn~=""
    sc(28,1)="WeightsInFile"; sc(28,2)=fnWtsIn;
end
ica.cfg = sc;

% Save as plain text script
writematrix(sc,fnSc,'Delimiter',' ',"FileType","text");

%% Write data
prec='float';

% EEG data
x = x';
fID = fopen(fnDat,'w');
fwrite(fID,x,prec);
fclose(fID);

% Pre-existing input weights
if ~isempty(wtsIn) && isnumeric(wtsIn)
    fID = fopen(fnWtsIn,"w");
    fwrite(fID,wtsIn,prec);
    fclose(fID);
end
if arg.dry; return; end

%% Run CUDAICA
[~,cmdout] = system(cudaica_bin+" -f "+fnSc,'-echo');
system("rm "+fnDat);

% Read weights
fID = fopen(fnWts,"r");
wts = fread(fID,[nComps nComps],prec);
fclose(fID);

% Read sphere
fID = fopen(fnSph,"r");
sph = fread(fID,[nComps nComps],prec);
fclose(fID);

%% Prepare outputs
ica.wts = wts;
ica.sph = sph;
if arg.pca > 0
    ica.w = wts*sph*wtsPCA';
    ica.sph = eye(nChs);
    ica.pca = wtsPCA;
else
    ica.w = wts*sph;
end
ica.winv = pinv(ica.w);
ica.log = cmdout;
ica.sph_og = sph;
ica.w_og = wts*sph;
ica.winv_og = pinv(wts*sph);

% Reconstruct IC activity
if nargout > 1
    x = ica.w * x;
    if doFlip; x=x'; end
end

%% Original documentation
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
