function [bstats,wstats,cstats,sstats]=nt_idxx(fname,p)
%nt_idxx(fname,p) - create an index file to summarize large data file
%
% Usage:
%   nt_idx(fname): calculate index structs, store in index file
%   nt_idx(fname,p): override default parameters
%   [bstats,wstats,cstats,sstats]=nt_idx(fname,...): return index structs:
%     bstats: basic stats (size, etc.)
%     wstats: waveform (min, max, mean, std)
%     cstats: covariance
%     sstats: psd
%
% Parameters:
%  fname: name of data file to index
%  p: struct to pass parameters:
%    p.iname: name of index file to create [default: [PATH, 'idxx/', NAME, EXT, '.idxx']
%    p.nstats: target number of stats samples [default: 1000 unless p.dsr set]
%    p.dsr: downsampling ratio of wave stats
%    p.dsrcov: downsampling ratio of covariance relative to wave [default: don't calculate cov]
%    p.dsrpsd: downsampling ratio of PSD relative to wave [default: don't calculate psd]
%    p.channels_to_keep: ignore other channels
%    p.nfft: fft size for psd [default: 1024]
%    p.nlin: number of full-resolution spectral bins [default: 32]
%    p.chunksize: size of chunks to read from disk [default: 500000, 0 -->all]
%    p.reader: header/data reader [default: 'BioSig']
%    p.preproc: preprocessing function handle [default: none]
%    p.quiet: suppress messages [default: false];
%
% Reader p.reader can be either 'FieldTrip' or 'BioSig' or a user-specified
% reader 'reader' callable as:
%   [header,data]=reader(fname, chans, bouds)
% where bounds=[firstsample last sample], chans is a list of channels
% starting from 1, header.Fs contains the sample rate, and data has 
% dimensions samples X channels
% 
% If p.preproc is provided, it will be called as:
%    [y,w]=p.preproc(x);
% where x and y are time X channels data matrices (resp. before and after
% preprocessing), and w is a weight array (time X 1 or time X channels)
% indicating bad data. Examples:
%    p.preproc=@(x) deal(max(min(x,10),-10),[]); % clip, no weight
%    p.preproc=@(x) deal(max(min(x,10),-10),all(x==max(min(x,10),-10),2)); % clipping
%    p.preproc=@(x) deal(max(min(x,10),-10),x==max(min(x,10),-10)); % clipping per channel
%
% NoiseTools
nt_greetings;

if nargin<1; error('!'); end
if nargin<2 ; p=[]; end

% defaults;
if ~isfield(p,'iname')||isempty(p.iname); p.iname=[]; end % default assigned later
if ~isfield(p,'dsr'); p.dsr=[]; end % block size unspecified
if ~isfield(p,'nstats'); p.nstats=[]; end % number of stats unspecified
if ~isfield(p,'dsrcov'); p.dsrcov=[]; end % don't calculate covariance
if ~isfield(p,'dsrpsd'); p.dsrpsd=[]; end % don't calculate PSD
if ~isfield(p,'channels_to_keep')||isempty(p.channels_to_keep); p.channels_to_keep=[]; end % all
if ~isfield(p,'nfft')||isempty(p.nfft); p.nfft=4096; end
if ~isfield(p,'nlin')||isempty(p.nlin); p.nlin=16; end
if ~isfield(p,'chunksize')||isempty(p.chunksize); p.chunksize=500000; end
if ~isfield(p,'reader')||isempty(p.reader); p.reader='BioSig'; end
if ~isfield(p,'preproc'); p.preproc=[]; end
if ~isfield(p,'quiet'); p.quiet=0; end

% check for data file
if ~exist(fname,'FILE');
    disp(fname);
    disp('not found');
    error('!');
end

% check for readers
if strcmp(p.reader,'FieldTrip')
    if 2~=exist('ft_read_data'); disp('You must download FieldTrip from www.fieldtriptoolbox.org'); return; end
elseif strcmp(p.reader,'BioSig')
    if 2~=exist('sopen'); disp('You must download BioSig from biosig.sourceforge.net'); return; end
else
	if ~isa(p.reader,'function_handle'); error('function not found'); end
end

% use separate structs to make it easy to read just one kind of stats from file
bstats=[]; % index structure for basic stats
wstats=[]; % index structure for waveform
cstats=[]; % index structure for covariance
sstats=[]; % index structure for spectrogram

% read header, store info in bstats
if strcmp(p.reader,'FieldTrip')
    h=ft_read_header(fname);
    bstats.sr=h.Fs;
    bstats.nsamples=h.nSamples;
    bstats.nchans=h.nChans;
    bstats.label=h.label; 
elseif strcmp(p.reader,'BioSig')
    if p.quiet
        evalc('h=sopen(fname)'); % suppress pesky verbose output
    else
        h=sopen(fname);
    end 
    bstats.sr=h.SampleRate;
    %if h.NRec>1; error('!'); end % need to figure out how to handle, if needed
    bstats.nsamples=h.SPR*h.NRec;
    idx=find(~strcmp(h.Label,'EDF Annotations'));
    bstats.nchans=numel(idx);
    bstats.label=h.Label(idx);
    sclose(h);
else
    h=p.reader(fname);
    bstats.sr=h.sr;
    bstats.nsamples=h.nsamples;
    bstats.nchans=h.nchans;
    bstats.label=h.label;
end
bstats.header=h;
bstats.fname=fname; 
bstats.p=p;
bstats.now=now;

% store code of this function and of caller function
bstats.nt_idxx.txt=evalc(['type ', mfilename]);
stack=dbstack;
if numel(stack)>1
    bstats.caller.file=stack(2).name;
    try
        txt=evalc(['type ', stack(2).name]); 
    catch
        warning('could not list caller function');
    end
    bstats.caller.txt=txt;
end

% channels
if isempty(p.channels_to_keep) 
    p.channels_to_keep=1:bstats.nchans;
end

if any(p.channels_to_keep>bstats.nchans); error('!'); end
bstats.nchans=numel(p.channels_to_keep);

% idetermine time resolution of statistics
if isempty(p.dsr) 
    % DSR unspecified, specify nstats
    if isempty(p.nstats)
        % set to default
        p.nstats=1000;
    end
    bstats.dsr=ceil(bstats.nsamples/p.nstats);
    nwstats=ceil(bstats.nsamples/bstats.dsr);
else
    % DSR specified
    if ~isempty(p.nstats)
        % ntats also specify: try to ensure minimum nstats
        if ceil(bstats.nsamples/p.dsr)<p.nstats
            p.dsr=ceil(bstats.nsamples/p.nstats);
        end
    end
    bstats.dsr=p.dsr;
    nwstats=ceil(bstats.nsamples/bstats.dsr);
end

% allocate basic stats arrays:
nwstats=ceil(bstats.nsamples/bstats.dsr); % total number of blocks for basic stats
wstats.nwstats=nwstats;
wstats.min=zeros(nwstats,bstats.nchans);
wstats.max=zeros(nwstats,bstats.nchans); 
wstats.mean=zeros(nwstats,bstats.nchans);
wstats.rms=zeros(nwstats,bstats.nchans);

% allocate weight matrix if needed
% if ~isempty(p.preproc)
%     % test to determine if it returns a weight matrix, and if so what size
%     [~,w]=p.preproc(randn(100,10));
%     clf; drawnow;
%     if ~isempty(w)
%         if size(w,2)==1
%             wstats.w=zeros(nwstats,1);
%         else
%             wstats.w=zeros(nwstats,bstats.nchans);
%         end
%     end
% end           

% size of chunk to read from disk, multiple of block size
p.chunksize=floor(p.chunksize/bstats.dsr)*bstats.dsr; 

% allocate covariance array
if ~isempty(p.dsrcov)
    blksizecov=p.dsrcov*bstats.dsr;
    tmp=log2(p.dsrcov);
    assert(tmp==round(tmp), ...
        'p.dsrcov should be power of 2');
    ncstats=ceil(bstats.nsamples/blksizecov);
    cstats.cov=zeros(ncstats,bstats.nchans,bstats.nchans);
    cstats.blksizecov=blksizecov;
    p.chunksize=floor(p.chunksize/blksizecov)*blksizecov;
end

% allocate psd array
if ~isempty(p.dsrpsd) 
    blksizepsd=p.dsrpsd*bstats.dsr;
    if blksizepsd < p.nfft; 
        disp([blksizepsd,p.nfft]);
        error('!'); 
    end;
    tmp=log2(p.dsrpsd);
    assert(tmp==round(tmp), ...
        'p.dsrpsd should be power of 2');
    nsstats=ceil(bstats.nsamples/blksizepsd);
    
    %{
    Matrix to transform linear frequency  to semilog frequency.
    The first nlin samples are full resolution, the next nlin/2 half
    resolution (spectral bins grouped by 2), the next nlin/2 quarter
    resolution, etc.
    %}
    M={};
    if p.nlin~=2^log2(p.nlin); error('!'); end
    M{1}=eye(p.nlin+1);
    for iBlk=1:log2(p.nfft/p.nlin)-1
        for k=1:p.nlin/2 
            MM{k}=ones(2^iBlk,1)/2^iBlk; 
        end
        M{iBlk+1}=blkdiag(MM{:});        
    end
    M=blkdiag(M{:});
    sstats.M=M;

    % scaled frequency axis:
    f0=(0:p.nfft/2)/p.nfft; % normalized frequency of fft
    f=f0*M; f=f./sum(M);
    sstats.f=f;
    
%    figure(1); clf; plot(f); pause

    sstats.psd=zeros(nsstats,bstats.nchans,size(M,2));
    sstats.nfft=p.nfft;
    sstats.blksizepsd=blksizepsd;
    
    % ensure chunksize is multiple of blksepsd
    p.chunksize=floor(p.chunksize/blksizepsd)*blksizepsd;
end


foffset=0;
boffset=0;
coffset=0;
soffset=0;

% read and index;
while true
    
    %if file_offset>=i.nsamples; break; end
    if ~p.quiet; 
        disp([foffset, bstats.nsamples]); 
        disp([num2str(foffset/bstats.nsamples*100), '%']);
    end
    
    % read chunk from disk
    tic
    begsample=foffset+1;
    endsample=min(foffset+p.chunksize,bstats.nsamples);
    if endsample<=begsample; error('!'); end
    if strcmp(p.reader,'FieldTrip')
        error('!');
        x=ft_read_data(fname, 'begsample',begsample,'endsample',endsample);
        x=x'; % --> time X channels
        x=x(:,p.channels_to_keep);
    elseif strcmp(p.reader,'BioSig')
        if p.quiet
            evalc('h=sopen(fname,''r'',p.channels_to_keep)');% suppress pesky verbose output
        else
            h=sopen(fname,'r',p.channels_to_keep);
        end
        NoS=(endsample-begsample-1)/bstats.sr;
        StartPos=(begsample-1)/bstats.sr;
        x=sread(h,NoS,StartPos);
        sclose(h);
    else
        [~,x]=p.reader(fname,p.channels_to_keep,[begsample endsample]);
    end
    if ~p.quiet; toc; end
    
    disp(size(x))
    
    % apply preprocessing
    if ~isempty(p.preproc)
        disp('preproc:'); tic;
        [x,w]=p.preproc(x);
        toc;
    else
        w=[];
    end
    if ~isempty(w); error('TBD'); end
    
    figure(1); clf; plot(x); drawnow;
    
    % fold chunk into blocks
    nblocks=floor(size(x,1)/bstats.dsr); % number of blocks in this chunk
    xb=x(1:nblocks*bstats.dsr,:); % chunk
    xb=reshape(xb,[bstats.dsr,nblocks,bstats.nchans]); % block matrix

    % time series of waveform statistics
    tic;
    wstats.min(boffset+(1:nblocks),:)=min(xb,[],1);
    wstats.max(boffset+(1:nblocks),:)=max(xb,[],1);
    wstats.mean(boffset+(1:nblocks),:)=mean(xb,1);
    wstats.rms(boffset+(1:nblocks),:)=sqrt(mean(xb.^2,1));
    boffset=boffset+nblocks; 
    if ~p.quiet; toc; end
    
    figure(2); clf; plot([wstats.min, wstats.max]); drawnow
    
    
    % extra bit at end of file?
    if size(x,1)>nblocks*bstats.dsr
        tmp=x(nblocks*bstats.dsr+1:end,:);
        wstats.min(boffset+1,:)=min(tmp,[],1);
        wstats.max(boffset+1,:)=max(tmp,[],1);
        wstats.mean(boffset+1,:)=mean(tmp,1);
        wstats.rms(boffset+1,:)=sqrt(mean(tmp.^2,1));
    end
    
    foffset=foffset+nblocks*bstats.dsr; % advance pointer in file

    % time series of covariance matrices
    if ~isempty(cstats) && isfield(cstats, 'cov')
        nblocks=floor(size(x,1)/blksizecov); % number of blocks
        xb=x(1:nblocks*blksizecov,:);        
        xb=reshape(xb,[blksizecov, nblocks, bstats.nchans]);
        for iBlock=1:nblocks
            tmp=squeeze(xb(:,iBlock,:));
            tmp=nt_demean(tmp);
            cstats.cov(coffset+iBlock,:,:) = tmp'*tmp;
        end
        coffset=coffset+size(xb,2);
        if size(x,1)>nblocks*blksizecov
            tmp=x(nblocks*blksizecov+1:end,:);
            tmp=nt_demean(tmp);
            cstats.cov(coffset+1,:,:)=tmp'*tmp;
        end              
    end
      
    % time series of power spectra
    if ~isempty(sstats) && isfield(sstats, 'psd')
        nblocks=floor(size(x,1)/blksizepsd); % number of blocks in chunk
        xb=x(1:nblocks*blksizepsd,:);        
        xb=reshape(xb,[blksizepsd, nblocks, bstats.nchans]);
        for iBlock=1:nblocks
            tmp=squeeze(xb(:,iBlock,:));    
            tmp=nt_demean(tmp);
            sstats.psd(soffset+iBlock,:,:) = pwelch(tmp, p.nfft, 'power')'*M;
        end
        soffset=soffset+size(xb,2);
        
        disp([soffset size(sstats.psd,1)]);
        
        if size(x,1)>nblocks*blksizepsd
            tmp=x(nblocks*blksizepsd+1:end,:);
            tmp=nt_demean(tmp);
            if size(tmp,1)<p.nfft; break; end
            sstats.psd(soffset+1,:,:) = pwelch(tmp, p.nfft, 'power')'*M;
        end              
    end
    
    if ~p.quiet; nt_whoss; end
    %disp([num2str(foffset/h.nSamples*100), '%']);
%     disp([num2str(foffset), '/', num2str(h.nSamples), ' (', num2str(foffset/h.nSamples*100), '%)']);
%     disp([boffset, coffset, soffset]);
    
    if endsample>=bstats.nsamples; break; end;
end
   
if ~nargout
    if isempty(p.iname)
        [FILEPATH,NAME,EXT]=fileparts(fname);
        if isempty(FILEPATH); FILEPATH=pwd; end
        if ~exist([FILEPATH,filesep,'idxx'], 'dir')
            mkdir([FILEPATH,filesep,'idxx']);
        end        
        p.iname=[FILEPATH,filesep,'idxx',filesep,NAME,EXT,'.idxx'];
    end
    wstats.min=nt_double2int(wstats.min); 
    wstats.max=nt_double2int(wstats.max);
    wstats.mean=nt_double2int(wstats.mean);
    wstats.rms=nt_double2int(wstats.rms);
    save(p.iname, 'bstats', 'wstats','cstats', 'sstats','-v7.3');
    clear bstats wstats cstats sstats;
end


    

