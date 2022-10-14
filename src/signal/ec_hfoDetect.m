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
% MODIFIED: Kevin Tan, 2022 (kevmtan.github.io)
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


