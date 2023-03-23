function [pathological_chan_id,pathological_event]=ec_hfoDetect(eeg,chanNames,fs,thr)
%% [pathological_chan_id,pathological_event]=find_paChan(eeg,chanNames,fs,thr)
%   Find possible pathological channels with HFO and spikes.
%   Pathological (irritative) channels are defined as channels with event
%   occuerrnce rate > [thr] times of the average HFO+spike rate
%   eeg:        miltichannel EEG data in columns.
%   chanNames:  channel labels.
%   fs:         sampling frequency.
%   tr:         threshold to define the patholgocial channels.
%
%   pathological_chan_id: pathological channels index (monopolar)
%   pathological_event:    -ts(:,1) = timestamps of each event;
%                          -ts(:,2) = corresponding channel index (***bipolar)
%   Su Liu
%   suliu@standord.edu
%
% MODIFIED: Kevin Tan, 2022 (github.com/kevmtan/electroCUDA)
%    - Accelerated with parfor loops when possible (ideally ThreadPools)
%    - Preallocation & other speed optimizations
fs = floor(fs);
if nargin<4
    thr = 2;
end
try parpool('threads'); catch; end

%% Create bipolar for HFO and spike detection
fprintf('%s\n','---- Creating bipolar montage ----')

eeg_bi = nan(height(eeg),width(eeg)-1);
chan = cell(1,width(eeg)-1);
z=1;
if strcmp(chanNames{1,1},'01')
    labels=str2double(chanNames);
    [~,orig_order]=sort(labels);
    for t=1:size(eeg,2)-1
        eeg_bi(:,z)=eeg(:,orig_order(t))-eeg(:,orig_order(t+1));
        chan{1,z}=sprintf('%s-%s',chanNames{t},chanNames{t+1});
        z=z+1;
    end
else
    for t=1:size(eeg,2)-1
        name1 = join(regexp(string(chanNames{t}),'[a-z]','Match','ignorecase'),'');
        name2 = join(regexp(string(chanNames{t+1}),'[a-z]','Match','ignorecase'),'');
        if strcmp(name1,name2)
            eeg_bi(:,z)=eeg(:,t)-eeg(:,t+1);
            chan{1,z}=sprintf('%s-%s',chanNames{t},chanNames{t+1});
            z=z+1;
        else
            continue
        end
    end
end
%%% change

%% Detecting events
fprintf('%s\n','---- Detecting pathological events ----');
b = fir1(64,[80 450]/(fs/2));
a = 1;
input_filtered = filtfilt(b,a,eeg_bi);
n = size(input_filtered,2);
parfor t = 1:n
    [~,th] = get_threshold(input_filtered(:,t),100,50,'std',5);
    try
        timestamp{t}(:,1) = find_event(input_filtered(:,t),th,2,1);
        timestamp{t}(:,2) = t;
    catch
        continue;
    end
end
T = cat(1,timestamp{:});
[~,I] = sort(T(:,1));
event.timestamp = T(I,:);
[alligned,allignedIndex,K] = getaligneddata(eeg_bi,event.timestamp(:,1),[-150 150]);
event.timestamp=event.timestamp(logical(K),:);
ttlN = size(alligned,3);
for t = 1:ttlN
    event.data(:,1,t) = alligned(:,event.timestamp(t,2),t);%raw segment
    event.data(:,2,t) = input_filtered(allignedIndex(t,:),...
        event.timestamp(t,2))*1000;%filtered segment
    event.data(:,3,t) = allignedIndex(t,:);%index
end
atf_ind = find(eliminate_noise(event.data,fs));
event.data(:,:,atf_ind) = [];
channel = event.timestamp(:,2);
channel(atf_ind)=[];
pChan = chan(event.timestamp(:,2));
pChan(atf_ind)=[];
event.timestamp(atf_ind,:)=[];
s_p = zeros(1,n);
u = unique(channel);
s = zeros(1,length(u));
parfor j = 1:length(u)
    s(j)=length(find(channel==u(j)));
end
s_p(1,u)=s;

% Channels with event occurence rate > 2*median rate are shown. Can change as needed.
pc=chan(s_p>thr*mean(s_p));
monochan=cell(length(pc),2);
for t = 1:length(pc)
    try
        monochan(t,:) = strsplit(pc{t},'-');
    catch
        temp=strsplit(pc{t},'-');
        if length(temp)==4
            monochan(t,1)=strcat(temp(1),'-',temp(2));
            monochan(t,2)=strcat(temp(3),'-',temp(4));
        else
            error('Channel name mismatch');
        end
    end
end

fprintf('---- Done ----')
%%%%%%%%%show problematic chan%%%%%%%%%%%%%%
pathological_chan=unique(monochan(:));
pathological_event.ts=event.timestamp;
pathological_event.channel=pChan;

if isempty(pathological_chan)
    pathological_chan_id=[];
else
    pathological_chan_id = nan(1,length(pathological_chan));
    parfor t=1:length(pathological_chan)
        pathological_chan_id(t)=find(strcmp(pathological_chan{t},chanNames));
    end
end




%% data_norm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [discard] = eliminate_noise(data,fs)
%   Eliminate noise after initial detection
%   Su Liu
candidate = cell(1,size(data,3));
pre = 127*(fs/1000);
post = 128*(fs/1000);
ind = round(size(data,1)/2-pre):round(size(data,1)/2+post);
ld = length(ind);
for i = 1:size(data,3)
    candidate{i}(:,1) = data(ind,1,i);
    candidate{i}(:,2) = data(ind,2,i);
    candidate{i}(:,3) = i;
end
count2 = zeros(length(candidate),1);
idx = cell(length(candidate),1);
th = zeros(length(candidate),1);
discard = zeros(length(candidate),1);
for i = 1:length(candidate)
    env = envelope_su(candidate{i}(:,2),fs)';
    env_back = envelope_su(candidate{i}([1:round(ld/3-1) round(2*ld/3)+1:end],2),fs);
    th(i) = 3*median(env_back);
    FF_mid = find(env>th(i), 1);
    FF_mid2 = find(env>20*th(i), 1);
    %count = zerocross_count(detrend(candidate{i}(:,1),'constant')');%zero crossing of the raw
    [count2(i,1),idx{i,1}] = zerocross_count((candidate{i}(:,2)-th(i))');
    if isempty(FF_mid)|| ~isempty(FF_mid2) || count2(i,1)<=2 ||...%count>=10 ||
            idx{i}(1) < (ld/2-60*(fs/1000)) ||...
            idx{i}(end) > (ld/2+60*(fs/1000))
        discard(i)=1;
        continue;
        %elseif  length(FF_mid)<20*(fs/1000) || length(FF_mid)>100*(fs/1000)
        %   discard(i)=1;
        %  continue;
    end
end



%% envelope_su %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function envmax = envelope_su(sig,fs,param)
% Generates the envelope of the signal.
% Written by Su Liu.
% suliu@stanford.edu
if nargin<3
    param=8;
end
env=abs(hilbert(sig));

f_s=round(fs/2);
cutoff=param/f_s;

b1=fir1(2,cutoff);
envmax=filtfilt(b1,1,env);


%% find_event %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function stamp = find_event(data,th,id_type,th_type,reject)
%  id_type 1: find the first crossing point.
%          2: if a succesive serie of timestamps are found, get the peak.
%          3: if a succesive serie of timestamps are found, get the
%          central point.
%   Written by Su Liu
if nargin<5 || isempty(reject)
    if th_type==0
        reject=9;
    else
        reject=5;
    end
end

% if ~isempty(index(data(index)>reject*th))
%      index(data(index)>reject*th)=[];
% end


% index=find(data>th);
% index_m=find(data<-th);

index=sort([find(data>th);find(data<-th)]);
r_ind=[find(data(index)>reject*th);find(data(index)<(-reject*th))];
if ~isempty(r_ind)
    index(r_ind)=[];
end


li=length(index);
q=1;
count=0;
if li==0 || li==1
    get_idx=[];
else
    F=find(diff(index)<=100);
    %F=find(diff(index)<=50);
    if ~isempty(F)
        if length(F)==1
            group{1}=index(F:F+1);
        else
            F(:,2)=F(:,1)+1;
            for i=1:length(F)-1
                if F(i,2)~=F(i+1,1)
                    group{q}=index(F(i-count,1):F(i,2));
                    index(F(i-count,1):F(i,2))=0;
                    count=0;
                    q=q+1;
                else
                    count=count+1;
                    if i==length(F)-1
                        group{q}=index(F(i+1-count,1):F(end));
                        index(F(i+1-count,1):F(end))=0;
                    else
                        continue;
                    end
                end
            end
        end
        atf=zeros(length(group),1);
        if th_type==1
            for i=1:length(group)
                if length(group{i})>100 %set the criteria
                    %if length(group{i})>50 %set the criteria
                    atf(i)=1;
                elseif length(group{i})<=2%old:10
                    atf(i)=1;
                end
            end
        else
            for i=1:length(group)
                if length(group{i})>60
                    %if length(group{i})>30;
                    atf(i)=1;
                end
            end
        end
        group(logical(atf))=[];
        get_idx=zeros(length(group),1);
        for i=1:length(group)

            switch id_type
                case 1
                    get_idx(i,1)=group{i}(1);
                case 2
                    get_idx(i,1)=group{i}(data(group{i})==max(data(group{i})));

                case 3
                    get_idx(i,1)=round(median(group{i}));
                case 4
                    if length(group{i})>=8
                        n=1:length(group{i})-1;
                        a=find(abs(gradient(diff(group{i}),n))<2);
                        if any(diff(a)==1)
                            get_idx(i,1)=group{i}(floor(median(a(find(diff(a)==1)+1)+1)));
                        else
                            get_idx(i,1)=group{i}(round(median([a(1);a+1])));
                        end
                    else
                        get_idx(i,1)=group{i}(data(group{i})==max(data(group{i})));
                    end
            end
        end

    end
end
index(index==0)=[];
if th_type==0
    if exist('get_idx','var')
        stamp=sort([get_idx;index]);
    else
        stamp=index;
    end
else
    if ~exist('get_idx','var')
        get_idx=[];
    end
    stamp=get_idx;
end
discard= data(stamp)>reject*th;
stamp(discard)=[];



%% Getaligneddata %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [alligned,allignedIndex,K] = getaligneddata(data,index,range,artifact)
% [alligned] = getaligneddata(data,index,range)
% index Tx1 = The sample index of the trigger
% range 1x2 = range(1) samples before and range(2) samples after the
% trigger index
% data : Multichannel data first dimension is the samples and the second
% channels
% alligned data: last dimension is always T and first dimesion is depend on
% the range, other dimenstions are same as input data

%%
if nargin<4
    artifact=[0 0];
end
q=1;
index=index(:);
T = length(index);
K=zeros(T,1);
range=round(range);
alligned = zeros(diff(range)+1,size(data,2),T);
allignedIndex = zeros(T,diff(range)+1);
for k = 1:T
    allignedIndex(k,:)=index(k)+(range(1):range(2));
    if ~any(allignedIndex(k,:)<=0) && ~any(allignedIndex(k,:)>length(data))
        if ~any((allignedIndex(k,1)<artifact(:,2) & allignedIndex(k,1)>artifact(:,1)) | (allignedIndex(k,end)<artifact(:,2) & allignedIndex(k,end)>artifact(:,1)))
            alligned(:,:,k) = data(allignedIndex(k,:),:);
            K(k)=1;
        end
    else
        K(k)=0;
        continue;
    end
end

% Keeping only artifact free trials
alligned=alligned(:,:,logical(K));
allignedIndex=allignedIndex(logical(K),:);
%allignedIndex(del,:)=[];
%alligned(:,:,del)=[];




%% Get Threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [v,th] = get_threshold(data,frame,overlap,type,param,input)
%     data: single channel raw data.
%   window: window length for rectangular window, or pre-defined window.
%  overlap: overlaping samples when calculating the variance.
%     type: choose which type of operator to use.
%    param: parameter used for the threshold.
%   Written by Su Liu
if nargin<6
    input=[];
elseif ~strcmp(type,'Manual')
    input=[];
elseif input==0
    input=[];
end
if strcmp(type,'std')==1
    v=temp_variance(data,frame,overlap,2);
    m=median(v);
else
    v=temp_variance(data,frame,overlap);
    switch type
        case 'Mean'
            m=mean(v);
        case 'Median'
            m=median(v);
            %case 'std'
            %m=std(v);
        case 'Manual'
            if ~isempty(input)
                th=input;
                return;
            end
    end
end
th=param*m;



%% temp_variance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = temp_variance(data,frame,overlap,type)
%Computes the temporal variance of signal using moving window.
%Written by Su Liu
if nargin<4
    type=1;
end
if isscalar(frame)
    winlength = frame;
    window = ones(winlength,1);
elseif isvector(frame)
    window = frame;
    winlength = length(frame);
end

%x = [zeros(ceil((winlength*overlap+1)/2)-1,1); data(:); zeros(floor((winlength*overlap+1)/2),1)];
lx=length(data);
index = spdiags(repmat((1:lx)',[1 winlength]),0:-(winlength-overlap):-lx+winlength);
window = repmat(window,[1 size(index,2)]);
switch type
    case 1
        y(:,1) = var((window.*data(index)));
    case 2
        y(:,1) = std((window.*data(index)));
    case 3
        y(:,1) = mean((window.*data(index)));
end




%% zerocross_count
function [count,idx] = zerocross_count(data)
%Computes the zero-crossing number
%Written by Su Liu
s = size(data);    % size of matrix v
l = s(1);       % Number of row of matrix v
for m=1:l
    x = data(m,:);
    %    disp(' ')
    %    disp(['New input vector x: ', num2str(x)])
    %    disp(' ')
    %    num_samples = length(x);
    %    count       = 0;
    %    for n=2:num_samples
    %        if((x(n) * x(n-1)) <= 0)
    %            count = count + 1;
    %        end
    %    end
    %    disp(['Method of product, count = ', num2str(count)])

    % Method, eliminating the defects of precedent code
    x_sign= sign(x);             % Negative: -1, Zero: 0, Positive 1
    index_0  = x_sign == 0;   % Index of elements == 0
    x_sign(index_0) = 1;                   % Set elements == 0 to 1
    x_sign_diff = diff(x_sign);        % Change of sign detection
    idx=find(x_sign_diff ~= 0);
    count = length(find(x_sign_diff ~= 0)); % Not == 0 means a jump of sign
end