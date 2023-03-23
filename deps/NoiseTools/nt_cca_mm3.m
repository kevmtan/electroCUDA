function [D,E,R,EXTRA]=nt_cca_mm(x,y,ssize,ldaflag,nccs)
%[D,E,R]=nt_cca_mm(x,y,ssize,ldaflag,nccs) - calculate metrics for match-mismatch task
%
%  D: d-prime 
%  E: error rate
%  R: correlation coefficient over entire trial
%  EXTRA: struct with additional info:
%    .D_match: matrix of euclidean distances for matching segments/trials
%    .D_mismatch: matrix of euclidean distances averaged over mismatched segments/trials
%    .rms_eeg: matrix of RMS of EEG segments
%    .rms_stim: matrix of RMS of stim segments
%
%  x,y: data as trial arrays
%  ssize: samples, segment size [default: all]
%  ldaflag: 0: first CC, 1: LDA, 2: sum, p<1: weight with exp p
%  nccs: number of CCs to keep [default: all]

zscore=1;
lda=1;

if nargin<2; error('!'); end
if nargin<3; ssize=[]; end
if nargin<4||isempty(ldaflag); ldaflag=1; end
if nargin<5; nccs=[]; end

if ssize ~= round(ssize); error('!'); end

% find smallest trial size across trials
nsamples=size(x{1},1); % min size over trials
ntrials=numel(x);
for iTrial=1:ntrials
    if size(x{iTrial}) ~= size(y{iTrial}); error('!'); end
    nsamples=min(nsamples,size(x{iTrial},1));
end
if isempty(ssize); ssize=nsamples; end % default: segment size = nsamples
nsamples=ssize*floor(nsamples/ssize); % reduce nsamples to multiple of wsize

% clip all trials to smallest size
if nsamples<1; error('!'); end
for iTrial=1:ntrials
    x{iTrial}=nt_demean(x{iTrial}(1:nsamples,:)); % clip trials to new length
    y{iTrial}=nt_demean(y{iTrial}(1:nsamples,:));
end
nsegments=nsamples/ssize; % number of segments per trial

% sanity check
if 0 
    % scramble (should yield approx d-prime==0 and error == 50%)
    for iTrial=1:ntrials
        y{iTrial}=y{1+mod(iTrial+5,ntrials)};
        %disp([iTrial, 1+mod(iTrial+5,ntrials)]);
    end
end

% call standard nt_cca_mm to get map of good/bad segments
[~,~,~,EXTRA]=nt_cca_mm(x,y,ssize,ldaflag,nccs);

% determine threshold to count segment as bad
d=EXTRA.DD_mismatch(:)-EXTRA.DD_match(:);  % small --> bad
d=sort(d);
PROP=0.1; % proportion of segments to count as bad
thresh=d(round(PROP*numel(d)));

DD_match=reshape(EXTRA.DD_match, [size(EXTRA.DD_match,1)/ntrials, ntrials]);
DD_mismatch=reshape(EXTRA.DD_mismatch, [size(EXTRA.DD_mismatch,1)/ntrials, ntrials]);
for iTrial=1:numel(x)
    
    % bad segments in this trial
    iBad=find(DD_mismatch(:,iTrial)-DD_match(:,iTrial)<thresh);
    
    disp(iBad);
    
    % remove bad segments
    xx=reshape(x{iTrial}, [ssize,size(x{iTrial},1)/ssize, size(x{iTrial},2)]); 
    xx(:,iBad,:)=[];
    xx=reshape(xx,[size(xx,1)*size(xx,2),size(xx,3)]);
    x2{iTrial}=xx;
    
    yy=reshape(y{iTrial},[ssize,size(y{iTrial},1)/ssize, size(y{iTrial},2)]);
    yy(:,iBad,:)=[];
    yy=reshape(yy,[size(yy,1)*size(yy,2),size(yy,3)]);
    y2{iTrial}=yy;
end

% cross-validated CCA
shifts=[0]; 
[AA,BB,~]=nt_cca_crossvalidate(x2,y2,shifts);

% select reduced number of CCs
if isempty(nccs)
    nccs=size(AA{1},2);
else
    nccs=min(nccs,size(AA{1},2));
    for iTrial=1:ntrials
        AA{iTrial}=AA{iTrial}(:,1:nccs);
        BB{iTrial}=BB{iTrial}(:,1:nccs);
    end
    %RR=RR(1:nccs,:,:);
end

DD_match=[]; % normalized Euclidean distance for matching trials
DD_mismatch=[]; % normalized Euclidean distance for mismatched trials
RR=[];
rms_eeg=[];
rms_stim=[];

% crossvalidation loop
for iTrial=1:ntrials
    
    %{
    The CCA solution (AA, BB) was calculated on the basis of other trials.     
    We apply it to segments of this trial.
    %}

    % CCs
    cc_x=nt_mmat(x{iTrial},AA{iTrial});
    cc_y=nt_mmat(y{iTrial},BB{iTrial});
    %cc_x=nt_mmat(y{1+mod(iTrial,ntrials)},BB{iTrial}); % scramble
    
    % cut CCs into segments
    S_x=zeros(ssize,nccs,nsegments);
    S_y=zeros(ssize,nccs,nsegments);
    for iSegment=1:nsegments
        start=(iSegment-1)*ssize;
        S_x(:,:,iSegment)=cc_x(start+(1:ssize),:); 
        S_y(:,:,iSegment)=cc_y(start+(1:ssize),:);
     end

    % RMS of EEG and stim over each segment
    a=sqrt(mean(S_x.^2,1)); % average over samples
    a=permute(a,[2 3 4 1]); % get rid of singleton
    a=a(:,:); % size [nccs, nsegments*ntrials])
    a=mean(a); % average over CCs
    b=sqrt(mean(S_y.^2,1));
    b=permute(b,[2 3 4 1]);
    b=b(:,:);
    b=mean(b);
    rms_eeg=[rms_eeg;a(:)];
    rms_stim=[rms_stim;b(:)];

    
    % z-score each segment
    for iSegment=1:nsegments
        if zscore
            S_x(:,:,iSegment)=nt_normcol(nt_demean(S_x(:,:,iSegment))); % mean 0 norm 1
            S_y(:,:,iSegment)=nt_normcol(nt_demean(S_y(:,:,iSegment)));
        end
    end
    
    % For each envelope segment, we calculate the Euclidean distance between this segment and the corresponding
    % EEG segment (match) and between this segment and all the envelope segments of other trials (mismatch).

    % matching segments:
    
    % distance from each segment of audio to corresponding segment of EEG
    D_match=sqrt(mean((S_x-S_y).^2, 1));
    D_match=permute(D_match,[2 3 4 1]); % get rid of initial singleton
    D_match=D_match(:,:)'; % --> segments X comps
    
        
    % mismatched segments:
    
    % distance from each segment of x to all mismatched segments of y,
    % averaged over those segments
    S_x=S_x(:,:,:); 
    S_y=S_y(:,:,:);
    D_mismatch=zeros(size(S_x,3),size(S_x,3)-1, nccs);
    for iSegment=1:size(S_x,3)
        other_segments=setdiff(1:size(S_x,3),iSegment);
        if 1
            tmp=bsxfun(@minus,S_y(:,:,other_segments),S_x(:,:,iSegment));
        else
            % flip: each segment of y with all mismatched segments of x
            tmp=bsxfun(@minus,S_x(:,:,other_segments),S_y(:,:,iSegment));
        end
        d=sqrt(mean(tmp.^2, 1));
        D_mismatch(iSegment,:,:)=permute(d,[1 3 2]);
    end
    D_mismatch=mean(D_mismatch,2); % average over all other segments
    D_mismatch=permute(D_mismatch,[1 3 2]); 
    
    
    if ldaflag==1
        %{
        We want to transform distance scores (one per CC) using LDA. 
        
        To get the LDA matrix to apply to this trial, we calculate a CCA
        solution based on the other trials, and calculate the LDA
        solution from that.
        %}
         
        % exclude this trial
        other_trials=setdiff(1:ntrials,iTrial);

        % CCs
        cc_x2=nt_mmat(x(other_trials),AA{iTrial}); % AA, BB: CCA xforms derived from other trials
        cc_y2=nt_mmat(y(other_trials),BB{iTrial});

        % cut CCs into segments 
        % !!! why not just reshape?
        S_x=zeros(ssize,nccs,ntrials-1,nsegments);
        S_y=zeros(ssize,nccs,ntrials-1,nsegments);
        for iTrial2=1:ntrials-1
            for iSegment=1:nsegments
                start=(iSegment-1)*ssize;

                if zscore
                    S_x(:,:,iTrial2,iSegment)=nt_normcol(nt_demean(cc_x2{iTrial2}(start+(1:ssize),:))); % mean 0 norm 1
                    S_y(:,:,iTrial2,iSegment)=nt_normcol(nt_demean(cc_y2{iTrial2}(start+(1:ssize),:)));
                else
                    S_x(:,:,iTrial2,iSegment)=cc_x2{iTrial2}(start+(1:ssize),:); 
                    S_y(:,:,iTrial2,iSegment)=cc_y2{iTrial2}(start+(1:ssize),:);
                end
            end
        end    
        % S_x and S_y are of size [nsamples, nccs, (ntrials-1), nsegments]

        % --> [nsamples, nccs, (ntrials-1)*nsegments]:
        S_x=S_x(:,:,:); 
        S_y=S_y(:,:,:);

        % For each EEG segment, we calculate the Euclidean distance between this segment and the corresponding
        % envelope segment (match) and between this segment and all the envelope segments of other trials (mismatch).

        % match:
        % distance from each segment of audio to corresponding segment of EEG
        D_match2=sqrt(mean((S_x-S_y).^2, 1));
        D_match2=permute(D_match2,[2 3 1]); % gets rid of initial singleton
        D_match2=D_match2(:,:)'; % size [nccs, (ntrials-1)*nsegments]

        % mismatch:
        % distance from each segment of audio to all mismatched segments of EEG, averaged
        D_mismatch2=zeros(size(S_x,3),size(S_x,3)-1, nccs);
        for iSegment=1:size(S_x,3)
            % for each segment of audio
            other_segments=setdiff(1:size(S_x,3),iSegment);
            if 0
                tmp=bsxfun(@minus,S_y(:,:,other_segments),S_x(:,:,iSegment)); % sample-to-sample differences
            else
                tmp=bsxfun(@minus,S_x(:,:,other_segments),S_y(:,:,iSegment));
            end
            d=sqrt(mean(tmp.^2, 1)); % sum squares
            %disp(size(tmp))
            D_mismatch2(iSegment,:,:)=permute(d,[1 3 2]);
        end
        D_mismatch2=mean(D_mismatch2,2); % average over all other segments
        D_mismatch2=permute(D_mismatch2,[1 3 2]); 

        if 0
            figure(1); clf
            for k=1:4
                subplot (2,2,k);
                histogram(D_mismatch(:,k)-D_match(:,k), -.5:.01:.5); title(mean(D_mismatch(:,k)-D_match(:,k))/std(D_mismatch(:,k)-D_match(:,k)));
            end
        end

        % Use DSS to find optimal linear combination of distance scores to 
        % separate match & mismatch (--> LDA)

        c0=nt_cov(D_match2)/size(D_mismatch2,1);
        c1=nt_cov(D_mismatch2)/size(D_match2,1);
        [todss,pwr0,pwr1]=nt_dss0(c0,c1);
        if mean(D_match2*todss(:,1), 1)<0; todss=-todss; end
        
        lda_xform=todss;
        
    end % if ldaflag=1

    if ldaflag>0 && ldaflag<1
        p=ldaflag; % exponent to apply to CC distances
        ldaflag=3;
    end
    
    switch ldaflag  
        case 0
            D_match=D_match(:,1);
            D_mismatch=D_mismatch(:,1);
        case 1
            D_match=D_match*lda_xform(:,1);
            D_mismatch=D_mismatch*lda_xform(:,1);
        case 2
            D_match=mean(D_match,2);
            D_mismatch=mean(D_mismatch,2);
        case 3
            pp=p.^(0:size(D_match,2)-1);
            D_match=mean(D_match.*pp,2);
            D_mismatch=mean(D_mismatch.*pp,2);
        otherwise
            error('!');
    end
                
    DD_match=[DD_match; D_match(:)];
    DD_mismatch=[DD_mismatch; D_mismatch(:)];
        
    RR(iTrial,:)=diag(corr(cc_x,cc_y));
end

if 0
    figure(100);  clf;
    histogram(DD_mismatch-DD_match, -.5:.05:.5); title(mean(DD_mismatch-DD_match)/std(DD_mismatch-DD_match)); 
    drawnow;
end

D=mean(DD_mismatch-DD_match, 1)/std(DD_mismatch-DD_match);
E=mean(DD_mismatch-DD_match < 0, 1);
R=mean(RR, 1);
EXTRA.DD_mismatch=DD_mismatch;
EXTRA.DD_match=DD_match;
EXTRA.rms_eeg=rms_eeg;
EXTRA.rms_stim=rms_stim;



