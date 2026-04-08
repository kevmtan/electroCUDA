function C = ec_dim2cell(x,dim)
% Converts an array into a cell vector containing array slices along a
% target dimension
%
% Part of the electroCUDA package (https://github.com/kevmtan/electroCUDA)
%
% Output:
%   C = cell vector with length equal to elements in target dimension

%% Input validation
arguments
    x                    % Input array
    dim (1,1) double = 1 % Dimension to concatenate
end


%% Prep

% Input sizes & dims
sz = size(x);                   % size of input array
K = sz(dim);                    % number of elements along dimension
ids = repmat({':'},1,ndims(x)); % subscript template

% Size of array slices in output cell vector
outSz = sz;
outSz(dim) = [];
outScalar = prod(outSz)==1; % "x" is vector; slices are scalar, no reshape needed

% Preallocate output cell vector       
C = cell(K,1);               


%% Fill cell vector

% Loop across dimension elements
for k = 1:K
    % Fill cell element with "x" slice
    if outScalar
        C{k} = x(k); % direct copy scalar slice
    else
        ids{dim} = k; % subscript dimension index   
        C{k} = reshape(x(ids{:}),outSz); % get slice and reshape into outSz
    end
end


% % Old code - concise but slow
% dims = 1:ndims(x);
% dims(dim) = [];
% C = num2cell(x,dims);
% C = cellfun(@squeeze,C,UniformOutput=false);
