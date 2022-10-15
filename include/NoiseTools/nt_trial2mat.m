function [y,w]=nt_trial2mat(x,max_nsamples) 
%[y,w]=nt_trial2mat(x,max_nsamples) - convert trial cell array to 3D matrix
%
%  y: matrix (samples * channels * trials)
%  w: weights (samples * 1 * trials)
%
%  x: trial array (each trial is samples * channels)
%  max_nsamples: max number of samples per trial
%
% In the case of variable-length trials, the weights can be used to indicate 
% which parts of the array are valid data.

if nargin<2; max_nsamples=[]; end

ntrials=numel(x);

% determine maximum trial size
nsamples=0;
for k=1:ntrials
    [m,n]=size(x{k});
    nsamples=max(m,nsamples);
end

% clip if too large
if ~isempty(max_nsamples)
    nsamples=min(nsamples,max_nsamples);
end

% load data into 3D matrix
nchans=n;
if isa(x{1},'single')
    y=zeros(nsamples, nchans, ntrials, 'single');
else
    y=zeros(nsamples, nchans, ntrials);
end

%w=zeros(nsamples, 1, ntrials);
for k=1:ntrials
    [m,n]=size(x{k});
    if m>nsamples;
        % longer than max: clip
        x{k}=x{k}(1:nsamples,:);
        m=nsamples;
    end
    y(1:m,:,k)=x{k};
    %w(1:n,1,k)=1;
end

