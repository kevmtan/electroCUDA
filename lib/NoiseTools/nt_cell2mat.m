function y=nt_cell2mat(x)
%y=nt_cell2mat(x) - convert cell matrix of nD matrices to (n+1)D matrix
%
%   y: (n+1)-dimension matrix
%
%   x: cell matrix of matrices
%
% Similar to matlab's cell2mat() but much more flexible.
%
% If matrices in x are of different dimensions or sizes, the result is
% based on the largest dimension/size. Maximum ndims is 4.
%
% The cell matrix x can have ndims up to 4.
%
% NoiseTools.
nt_greetings

MAXDIMS=4; % modify code if more are needed

if ~iscell(x); error('!'); end

% recurse if x is matrix of cells
if min(size(x))>1
    if ndims(x)>MAXDIMS; error('!'); end
    sz=size(x);
    yy={};
    for k=1:size(x,1)
        yy{k}=nt_cell2mat(x(k,:,:,:)); % add more colons if needed
    end
    y=nt_cell2mat(yy);
    return
end
        
% find size of largest matrix in cell array
nd=0;
for iTrial=1:numel(x)
    nd=max(nd,ndims(x{iTrial})); % find largest number of dimensions
end
if nd>MAXDIMS; error('!'); end
szs=zeros(1,nd);
for iTrial=1:numel(x)
    tmp=size(x{iTrial});
    szs(1:numel(tmp))=max(szs(1:numel(tmp)),tmp); % find largest size
end
    
% transfer to matrix
y=zeros([szs,numel(x)]);
for iTrial=1:numel(x)
    sz=size(x{iTrial});
    sz(numel(sz)+1:nd)=1;
    if nd==1
        y(1:sz(1),iTrial)=x{iTrial};
    elseif nd==2
        y(1:sz(1),1:sz(2),iTrial)=x{iTrial};
    elseif nd==3
        y(1:sz(1),1:sz(2),1:sz(3),iTrial)=x{iTrial};
    elseif nd==2
        y(1:sz(1),1:sz(2),1:sz(3),1:sz(4),iTrial)=x{iTrial};
    end % add more cases if needed
end


% test code
if 0
    % basic case: cell array of 2 matrices, same size
    x{1}=randn(10);
    x{2}=randn(10);
    disp(size(nt_cell2mat(x)));
end
if 0
    % cell array of 2 matrices, different size
    x{1}=randn(10);
    x{2}=randn(20);
    disp(size(nt_cell2mat(x)));
end
if 0
    % cell array of 2 3-D matrices, same size
    x{1}=randn(10,11,12);
    x{2}=randn(10,11,12);
    disp(size(nt_cell2mat(x)));
end
if 0
    % cell array with one 2-D matrix and one 3-D matrix
    x{1}=randn(10);
    x{2}=randn(10,11,12);
    disp(size(nt_cell2mat(x)));
end
if 0
    % cell array of 2 matrices, same size, plot  
    x{1}=diag(1:10);
    x{2}=diag(randn(10,1));
    y=nt_cell2mat(x);
    figure(1); clf;
    subplot 221
    nt_imagescc(x{1});
    subplot 222
    nt_imagescc(x{2});
    subplot 223
    nt_imagescc(y(:,:,1));
    subplot 224
    nt_imagescc(y(:,:,2));
end
if 0
    % cell array of 2 matrices, different size, plot
    x{1}=diag(1:10);
    x{2}=diag(randn(20,1));
    y=nt_cell2mat(x);
    figure(1); clf;
    subplot 221
    nt_imagescc(x{1});
    subplot 222
    nt_imagescc(x{2});
    subplot 223
    nt_imagescc(y(:,:,1));
    subplot 224
    nt_imagescc(y(:,:,2));
end
if 0
    % 3-D matrix of 2-D matrices, same size
    x{1,1}=randn(10);
    x{2,1}=randn(10);
    x{1,2}=randn(10);
    x{2,2}=randn(10);
    disp(size(nt_cell2mat(x)));
end
if 0
    % 3-D matrix of 2-D matrices, various sizes
    x{1,1}=randn(10);
    x{2,1}=randn(11);
    x{1,2}=randn(12);
    x{2,2}=randn(13);
    disp(size(nt_cell2mat(x)));
end

    