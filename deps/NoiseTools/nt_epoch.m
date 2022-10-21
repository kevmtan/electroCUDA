function y=nt_epochify(x,idx,bounds)
%y=nt_epochify(x,idx,bounds) - extract epochs based on trigger indices
%
%  y: 3D array of epoched data (time*channels*trials)
%
%  x: raw data (time*channels)
%  idx: array of trigger indices (can be fractionary)
%  bounds: (samples) start and stop of epoch
%  
%  Space indices at intervals of epochsize (can be fractionary):
%       y=nt_epochify(x,[],epochsize);
%  
%  NoiseTools.
nt_greetings;

if nargin<3; error('!'); end
if isempty(idx)
    % space indices at regular intervals of epoch size 
    if numel(bounds)>1; error('!'); end
    idx=1 : bounds : size(x,1)-bounds;
    bounds=ceil(bounds);
end
if numel(bounds)==1 % align epoch start with index
    bounds=[0 bounds]; 
end

% check that indices fit, discard those that don't
idx=idx(:); 
lowestIdx=-bounds(1); % lowest 
highestIdx=size(x,1)-bounds(2); 
if max(idx)>highestIdx
    warning(num2str(numel(idx>highestIdx)));
  	disp('indices beyond end of data');
    idx=idx(idx<=highestIdx);
end
if min(idx)<lowestIdx
    warning(num2str(numel(idx<lowestIdx)));
  	disp('indices beyond end of data');
    idx=idx(idx>=lowestIdx);
end
  
% split data into trials
nsamples=bounds(2)-bounds(1)+1;
if idx == round(idx)
    % integer positions
    y=zeros(nsamples, size(x,2), numel(idx));
    for k=1:numel(idx);
        y(:,:,k)=x(tidx(k)+(bounds(1):bounds(2)),:);
    end
else
    % fractionnary positions
    warning('noninteger indices, using interpolation'); 
    sidx=repmat(idx, [1,nsamples]) + repmat((1:nsamples),[numel(idx,1),1]); 
    sidx=sidx(:);
    yy=interp1(1:size(x,1),x,sidx+bounds(1));
    y=nt_fold(yy,bounds(2)-bounds(1)+1);
end

