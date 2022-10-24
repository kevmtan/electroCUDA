function signal = ec_ASRclean(signal,cutoff,windowlen,stepsize,maxdims,ref_maxbadchannels,ref_tolerances,ref_wndlen,usegpu,useriemannian,maxmem)
% Run the ASR method on some high-pass filtered recording.
% Signal = clean_asr(Signal,StandardDevCutoff,WindowLength,BlockSize,MaxDimensions,ReferenceMaxBadChannels,RefTolerances,ReferenceWindowLength,UseGPU,UseRiemannian,MaxMem)
%
% This is an automated artifact rejection function that ensures that the data contains no events
% that have abnormally strong power; the subspaces on which those events occur are reconstructed 
% (interpolated) based on the rest of the EEG signal during these time periods.
%
% The basic principle is to first find a section of data that represents clean "reference" EEG and
% to compute statistics on there. Then, the function goes over the whole data in a sliding window
% and finds the subspaces in which there is activity that is more than a few standard deviations
% away from the reference EEG (this threshold is a tunable parameter). Once the function has found
% the bad subspaces it will treat them as missing data and reconstruct their content using a mixing
% matrix that was calculated on the clean data.
%
% Notes: 
%   This function by default attempts to use the Statistics toolbox in order to automatically
%   extract calibration data for use by ASR from the given recording. This step is automatically
%   skipped if no Statistics toolbox is present (then the entire recording will be used for
%   calibration, which is fine for mildly contaminated data -- see ReferenceMaxBadChannels below).
%
% In:
%   Signal : continuous data set, assumed to be *zero mean*, e.g., appropriately high-passed (e.g.
%            >0.5Hz or with a 0.5Hz - 1.0Hz transition band)
%
%   Cutoff : Standard deviation cutoff for removal of bursts (via ASR). Data portions whose variance
%            is larger than this threshold relative to the calibration data are considered missing
%            data and will be removed. The most aggressive value that can be used without losing
%            much EEG is 3. For new users it is recommended to at first visually inspect the difference 
%            between the original and cleaned data to get a sense of the removed content at various 
%            levels. An aggressive value is 5, and conservative value is 20. Default: 5.
%
%   The following are detail parameters that usually do not have to be tuned. If you cannot get
%   the function to do what you want, you might consider adapting these better to your data.
%
%   WindowLength : Length of the statistcs window, in seconds. This should not be much longer 
%                  than the time scale over which artifacts persist, but the number of samples in
%                  the window should not be smaller than 1.5x the number of channels. Default:
%                  max(0.5,1.5*Signal.nbchan/Signal.srate);
%
%   StepSize : Step size for processing. The reprojection matrix will be updated every this many
%              samples and a blended matrix is used for the in-between samples. If empty this will
%              be set the WindowLength/2 in samples. Default: []
%
%   MaxDimensions : Maximum dimensionality to reconstruct. Up to this many dimensions (or up to this 
%                   fraction of dimensions) can be reconstructed for a given data segment. This is
%                   since the lower eigenvalues are usually not estimated very well. Default: 2/3.
%
%   ReferenceMaxBadChannels : If a number is passed in here, the ASR method will be calibrated based
%                             on sufficiently clean data that is extracted first from the recording
%                             that is then processed with ASR. This number is the maximum tolerated
%                             fraction of "bad" channels within a given time window of the recording
%                             that is considered acceptable for use as calibration data. Any data
%                             windows within the tolerance range are then used for calibrating the
%                             threshold statistics. Instead of a number one may also directly pass
%                             in a data set that contains calibration data (for example a minute of
%                             resting EEG) or the name of a data set in the workspace.
%
%                             If this is set to 'off', all data is used for calibration. This will
%                             work as long as the fraction of contaminated data is lower than the
%                             the breakdown point of the robust statistics in the ASR calibration
%                             (50%, where 30% of clearly recognizable artifacts is a better estimate
%                             of the practical breakdown point).
%
%                             A lower value makes this criterion more aggressive. Reasonable range:
%                             0.05 (very aggressive) to 0.3 (quite lax). If you have lots of little
%                             glitches in a few channels that don't get entirely cleaned you might
%                             want to reduce this number so that they don't go into the calibration
%                             data. Default: 0.075.
%                             
%
%   ReferenceTolerances : These are the power tolerances outside of which a channel in a
%                         given time window is considered "bad", in standard deviations relative to
%                         a robust EEG power distribution (lower and upper bound). Together with the
%                         previous parameter this determines how ASR calibration data is be
%                         extracted from a recording. Can also be specified as 'off' to achieve the
%                         same effect as in the previous parameter. Default: [-3.5 5.5].
%
%   ReferenceWindowLength : Granularity at which EEG time windows are extracted
%                           for calibration purposes, in seconds. Default: 1.
%
%   UseRiemannian : [true|false] Use Riemannian distance instead of Euclidian distance. 
%              Riemannian distance used the modication in the following publication 
%              Blum Sarah, Jacobsen Nadine S. J., Bleichner Martin G., Debener Stefan (2019) 
%              A Riemannian Modification of Artifact Subspace Reconstruction for EEG Artifact 
%              Handling, Frontiers in Human Neuroscience, 13, 141. DOI=10.3389/fnhum.2019.00141.	
%
%   MaxMem : Amount of memory to use. See asr_process for more information.
%
%   UseGPU : Whether to run on the GPU. This makes sense for offline processing if you have a a card with
%            enough memory and good double-precision performance (e.g., NVIDIA GTX Titan or K20). 
%            Note that for this to work you need to a) have the Parallel Computing toolbox and b) remove 
%            the dummy gather.m file from the path. Default: false
%
% Out:
%   Signal : data set with local peaks removed
%
% Examples:
%   % use the defaults
%   eeg = clean_asr(eeg);
%
%   % use a more aggressive threshold
%   eeg = clean_asr(eeg,2.5);
%
%   % disable subset selection of calibration data (use all data instead)
%   eeg = clean_asr(eeg,[],[],[],[],'off');
%
%   % use a custom calibration measurement (e.g., EEGLAB dataset containing a baseline recording)
%   eeg = clean_asr(eeg,[],[],[],[],mybaseline);
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-10-15

% Copyright (C) Christian Kothe, SCCN, 2012, ckothe@ucsd.edu
%
% This program is free software; you can redistribute it and/or modify it under the terms of the GNU
% General Public License as published by the Free Software Foundation; either version 2 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
% even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with this program; if not,
% write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
% USA

if ~exist('cutoff','var') || isempty(cutoff) cutoff = 5; end
if ~exist('windowlen','var') || isempty(windowlen) windowlen = max(0.5,1.5*signal.nbchan/signal.srate); end
if ~exist('stepsize','var') || isempty(stepsize) stepsize = []; end
if ~exist('maxdims','var') || isempty(maxdims) maxdims = 0.66; end
if ~exist('ref_maxbadchannels','var') || isempty(ref_maxbadchannels) ref_maxbadchannels = 0.075; end
if ~exist('ref_tolerances','var') || isempty(ref_tolerances) ref_tolerances = [-3.5 5.5]; end
if ~exist('ref_wndlen','var') || isempty(ref_wndlen) ref_wndlen = 1; end
if ~exist('usegpu','var') || isempty(usegpu) usegpu = false; end
if ~exist('maxmem','var') || isempty(maxmem) maxmem = []; end
if ~exist('useriemannian','var') || isempty(useriemannian) useriemannian = false; end

signal.data = double(signal.data);

% first determine the reference (calibration) data
if isnumeric(ref_maxbadchannels) && isnumeric(ref_tolerances) && isnumeric(ref_wndlen)
    disp('Finding a clean section of the data...');
    try
        ref_section = clean_windows(signal,ref_maxbadchannels,ref_tolerances,ref_wndlen); 
    catch e
        disp('An error occurred while trying to identify a subset of clean calibration data from the recording.');
        disp('If this is because do not have EEGLAB loaded or no Statistics toolbox, you can generally');
        disp('skip this step by passing in ''off'' as the ReferenceMaxBadChannels parameter.');
        disp('Error details: ');
        hlp_handleerror(e,1);
        disp('Falling back to using the entire data for calibration.')
        ref_section = signal;
    end
elseif strcmp(ref_maxbadchannels,'off') || strcmp(ref_tolerances,'off') || strcmp(ref_wndlen,'off')
    disp('Using the entire data for calibration (reference parameters set to ''off'').')
    ref_section = signal;
elseif ischar(ref_maxbadchannels) && isvarname(ref_maxbadchannels)
    disp('Using a user-supplied data set in the workspace.');
    ref_section = evalin('base',ref_maxbadchannels);
elseif all(isfield(ref_maxbadchannels,{'data','srate','chanlocs'}))
    disp('Using a user-supplied clean section of data.');
    ref_section = ref_maxbadchannels; 
else
    error('Unsupported value for argument ref_maxbadchannels.');
end

% calibrate on the reference data
disp('Estimating calibration statistics; this may take a while...');
if exist('hlp_diskcache','file')
    if useriemannian
        state = hlp_diskcache('filterdesign',@asr_calibrate_r,ref_section.data,ref_section.srate,cutoff);
    else
        state = hlp_diskcache('filterdesign',@asr_calibrate,ref_section.data,ref_section.srate,cutoff);
    end
else
    if useriemannian
        state = asr_calibrate_r(ref_section.data,ref_section.srate,cutoff, [], [], [], [], [], [], [], maxmem);
    else
        state = asr_calibrate(ref_section.data,ref_section.srate,cutoff, [], [], [], [], [], [], [], maxmem);
    end
end
clear ref_section;

if isempty(stepsize)
    stepsize = floor(signal.srate*windowlen/2); end

% extrapolate last few samples of the signal
sig = 2*signal.data(:,end) - signal.data(:,(end-1):-1:end-round(windowlen/2*signal.srate));
%sig = [signal.data bsxfun(@minus,2*signal.data(:,end),signal.data(:,(end-1):-1:end-round(windowlen/2*signal.srate)))];

% process signal using ASR
if useriemannian
    [signal.data,state] = asr_process_r(sig,signal.srate,state,windowlen,windowlen/2,stepsize,maxdims,maxmem,usegpu);
else
    [signal.data,state] = asr_lfn(sig,signal.srate,state,windowlen,windowlen/2,stepsize,maxdims,maxmem,usegpu);
end

% shift signal content back (to compensate for processing delay)
signal.data(:,1:size(state.carry,2)) = [];
end

%%
function [outdata,outstate] = asr_lfn(data,srate,state,windowlen,lookahead,stepsize,maxdims,maxmem,usegpu)
% Processing function for the Artifact Subspace Reconstruction (ASR) method.
% [Data,State] = asr_process(Data,SamplingRate,State,WindowLength,LookAhead,StepSize,MaxDimensions,MaxMemory,UseGPU)
%
% This function is used to clean multi-channel signal using the ASR method. The required inputs are 
% the data matrix, the sampling rate of the data, and the filter state (as initialized by
% asr_calibrate). If the data is used on successive chunks of data, the output state of the previous 
% call to asr_process should be passed in.
%
% In:
%   Data : Chunk of data to process [#channels x #samples]. This is a chunk of data, assumed to be
%          a continuation of the data that was passed in during the last call to asr_process (if
%          any). The data should be *zero-mean* (e.g., high-pass filtered the same way as for
%          asr_calibrate).
%   
%   SamplingRate : sampling rate of the data in Hz (e.g., 250.0)
%
%   State : initial filter state (determined by asr_calibrate or from previous call to asr_process)
%
%   WindowLength : Length of the statistcs window, in seconds (e.g., 0.5). This should not be much
%                  longer than the time scale over which artifacts persist, but the number of samples 
%                  in the window should not be smaller than 1.5x the number of channels. Default: 0.5
%
%   LookAhead : Amount of look-ahead that the algorithm should use. Since the processing is causal,
%               the output signal will be delayed by this amount. This value is in seconds and should
%               be between 0 (no lookahead) and WindowLength/2 (optimal lookahead). The recommended
%               value is WindowLength/2. Default: WindowLength/2
%
%   StepSize : The statistics will be updated every this many samples. The larger this is, the faster 
%              the algorithm will be. The value must not be larger than WindowLength*SamplingRate.
%              The minimum value is 1 (update for every sample) while a good value is 1/3 of a second.
%              Note that an update is always performed also on the first and last sample of the data
%              chunk. Default: 32
%
%   MaxDimensions : Maximum dimensionality of artifacts to remove. Up to this many dimensions (or up 
%                   to this fraction of dimensions) can be removed for a given data segment. If the
%                   algorithm needs to tolerate extreme artifacts a higher value than the default
%                   may be used (the maximum fraction is 1.0). Default 0.66
%
%   MaxMemory : The maximum amount of memory used by the algorithm when processing a long chunk with
%               many channels, in MB. The recommended value is at least 64. To run on the GPU, use
%               the amount of memory available to your GPU here (needs the parallel computing toolbox).
%               default: min(5000,1/2 * free memory in MB). Using smaller amounts of memory leads to
%               longer running times.
%
%   UseGPU : Whether to run on the GPU. This makes sense for offline processing if you have a a card
%            with enough memory and good double-precision performance (e.g., NVIDIA GTX Titan or
%            K20). Note that for this to work you need to have the Parallel Computing toolbox.
%            Default: false
%
% Out:
%   Data : cleaned data chunk (same length as input but delayed by LookAhead samples)
%
%   State : final filter state (can be passed in for subsequent calls)
%

% History
% 03/20/2019 Makoto and Chiyuan. Supported 'availableRAM_GB'. GUI switched to GUIDE-made.
% 08/31/2012 Christian. Created.
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-08-31

% UC Copyright Notice
% This software is Copyright (C) 2013 The Regents of the University of California. All Rights Reserved.
% 
% Permission to copy, modify, and distribute this software and its documentation for educational,
% research and non-profit purposes, without fee, and without a written agreement is hereby granted,
% provided that the above copyright notice, this paragraph and the following three paragraphs appear
% in all copies.
% 
% Permission to make commercial use of this software may be obtained by contacting:
% Technology Transfer Office
% 9500 Gilman Drive, Mail Code 0910
% University of California
% La Jolla, CA 92093-0910
% (858) 534-5815
% invent@ucsd.edu 
% 
% This software program and documentation are copyrighted by The Regents of the University of
% California. The software program and documentation are supplied "as is", without any accompanying
% services from The Regents. The Regents does not warrant that the operation of the program will be
% uninterrupted or error-free. The end-user understands that the program was developed for research
% purposes and is advised not to rely exclusively on the program for any reason.
% 
% IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
% SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF
% THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE. THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
% INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
% PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY OF
% CALIFORNIA HAS NO OBLIGATIONS TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR
% MODIFICATIONS.

if nargin < 4 || isempty(windowlen) 
    windowlen = 0.5; end
windowlen = max(windowlen,1.5*size(data,1)/srate);
if nargin < 5 || isempty(lookahead)
    lookahead = windowlen/2; end
if nargin < 6 || isempty(stepsize)
    stepsize = 32; end
if nargin < 7 || isempty(maxdims)
    maxdims = 0.66; end
if nargin < 9 || isempty(usegpu)
    usegpu = false; end
if nargin < 8 || isempty(maxmem)
%     if usegpu
%         dev = gpuDevice(); maxmem = dev.FreeMemory/2^20; 
%     else
%         maxmem = hlp_memfree/(2^21); % In MB? (if 2^20) Probably because in the subsequent moving average process, you'll need to secure double amount of data.
%     end
end
if usegpu
    dev = gpuDevice(); maxmem = dev.FreeMemory/2^20;
else
    maxmem = memfree_lfn/(2^21); % In MB? (if 2^20) Probably because in the subsequent moving average process, you'll need to secure double amount of data.
end

if maxdims < 1
    maxdims = round(size(data,1)*maxdims); end
if isempty(data)
    outdata = data; outstate = state; return; end

[C,S] = size(data);
N = round(windowlen*srate);
P = round(lookahead*srate);
[T,M,A,B] = deal(state.T,state.M,state.A,state.B); % T, threshold; M, mixing matrix from the calibration data (sqrt of covariance matrix), IIR filter, IIR filter 

% initialize prior filter state by extrapolating available data into the past (if necessary)
if isempty(state.carry)
    state.carry = repmat(2*data(:,1),1,P) - data(:,1+mod(((P+1):-1:2)-1,S)); end

data = [state.carry data];
data(~isfinite(data(:))) = 0;

% split up the total sample range into k chunks that will fit in memory
if maxmem*1024*1024 - C*C*P*8*3 < 0
    disp('Memory too low, increasing it (rejection block size now depends on available memory so it might not be 100% reproducible)...');
    maxmem = memfree_lfn/(2^21);
    if maxmem*1024*1024 - C*C*P*8*3 < 0
	error('Not enough memory');
    end
end
splits = ceil((C*C*S*8*8 + C*C*8*S/stepsize + C*S*8*2 + S*8*5) / (maxmem*1024*1024 - C*C*P*8*3)); % Mysterious. More memory available, less 'splits'
if splits > 1
    fprintf('Now cleaning data in %i blocks',splits); end

for i=1:splits
    range = 1+floor((i-1)*S/splits) : min(S,floor(i*S/splits)); %
    if ~isempty(range)
        % get spectrally shaped data X for statistics computation (range shifted by lookahead)
        [X,state.iir] = filter(B,A,double(data(:,range+P)),state.iir,2);
        % move it to the GPU if applicable
        if usegpu && length(range) > 1000
            try X = gpuArray(X); catch,end; end
        % compute running mean covariance (assuming a zero-mean signal)
        [Xcov,state.cov] = moving_average(N,reshape(bsxfun(@times,reshape(X,1,C,[]),reshape(X,C,1,[])),C*C,[]),state.cov); % ch c ch x range.
        % extract the subset of time points at which we intend to update
        update_at = min(stepsize:stepsize:(size(Xcov,2)+stepsize-1),size(Xcov,2));
        % if there is no previous R (from the end of the last chunk), we estimate it right at the first sample
        if isempty(state.last_R)
            update_at = [1 update_at]; 
            state.last_R = eye(C);
        end
        Xcov = reshape(Xcov(:,update_at),C,C,[]);
        if usegpu
            Xcov = gather(Xcov); end
        % do the reconstruction in intervals of length stepsize (or shorter if at the end of a chunk)
        last_n = 0;
        for j=1:length(update_at)
            % do a PCA to find potential artifact components
            [V,D] = eig(Xcov(:,:,j));
            [D,order] = sort(reshape(diag(D),1,C)); V = V(:,order);
            % determine which components to keep (variance below directional threshold or not admissible for rejection)
            keep = D<sum((T*V).^2) | (1:C)<(C-maxdims);
            trivial = all(keep);
            % update the reconstruction matrix R (reconstruct artifact components using the mixing matrix)
            if ~trivial
                R = real(M*pinv(bsxfun(@times,keep',V'*M))*V');
            else
                R = eye(C);
            end
            % apply the reconstruction to intermediate samples (using raised-cosine blending)
            n = update_at(j);
            if ~trivial || ~state.last_trivial
                subrange = range((last_n+1):n);
                blend = (1-cos(pi*(1:(n-last_n))/(n-last_n)))/2;
                data(:,subrange) = bsxfun(@times,blend,R*data(:,subrange)) + bsxfun(@times,1-blend,state.last_R*data(:,subrange));
            end
            [last_n,state.last_R,state.last_trivial] = deal(n,R,trivial);
        end
    end
    if splits > 1
        fprintf('.'); end
end
if splits > 1
    fprintf('\n'); end

% carry the look-ahead portion of the data over to the state (for successive calls)
state.carry = [state.carry data(:,(end-P+1):end)];
state.carry = state.carry(:,(end-P+1):end);

% finalize outputs
outdata = data(:,1:(end-P));
if usegpu
    state.iir = gather(state.iir);
    state.cov = gather(state.cov);
end
outstate = state;
end

%%
function [X,Zf] = moving_average(N,X,Zi)
% Run a moving-average filter along the second dimension of the data.
% [X,Zf] = moving_average(N,X,Zi)
%
% In:
%   N : filter length in samples
%   X : data matrix [#Channels x #Samples]
%   Zi : initial filter conditions (default: [])
%
% Out:
%   X : the filtered data
%   Zf : final filter conditions
%
%                           Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                           2012-01-10

if nargin <= 2 || isempty(Zi)
    Zi = zeros(size(X,1),N); end

% pre-pend initial state & get dimensions
Y = [Zi X]; M = size(Y,2);
% get alternating index vector (for additions & subtractions)
I = [1:M-N; 1+N:M];
% get sign vector (also alternating, and includes the scaling)
S = [-ones(1,M-N); ones(1,M-N)]/N;
% run moving average
X = cumsum(bsxfun(@times,Y(:,I(:)),S(:)'),2);
% read out result
X = X(:,2:2:end);

if nargout > 1
    Zf = [-(X(:,end)*N-Y(:,end-N+1)) Y(:,end-N+2:end)]; end
end


%%
function result = memfree_lfn
% Get the amount of free physical memory, in bytes
result = javaMethod('getFreePhysicalMemorySize', javaMethod('getOperatingSystemMXBean','java.lang.management.ManagementFactory'));
end