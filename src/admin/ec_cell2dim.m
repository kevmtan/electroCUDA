function y = ec_cell2dim(C,dim)
% Converts a cell vector containing same-size arrays into an array of the
% underlying type by concatenating cell elements along a target dimension
%
% Part of the electroCUDA package (https://github.com/kevmtan/electroCUDA)
%
% Output:
%   y = array with size: [sizes(1:dim-1), K, sizes(dim:end)]

%% Input validation
arguments
    C cell {mustBeVector} % Input cell vector
    dim (1,1) double = 1  % Dimension to concatenate
end


%% Prep 

% Find nonempty elements
idf = find(~cellfun(@isempty,C,UniformOutput=true));

% Input sizes
K = numel(C);             % number of elements in cell vector
elemSz = size(C{idf(1)}); % size of array within cell elements

% Output size: insert K at position dim
outSz = [elemSz(1:dim-1),K];
if dim <= numel(elemSz)
    outSz = [outSz,elemSz(dim:end)];
end

% Preallocate output array
y = zeros(outSz,like=C{idf(1)});    % array of zeros, same class as cell contents
ids = repmat({':'},1,ndims(y));     % subscript template


%% Fill array slices
for k = idf'            % loop across nonempty cell elements
    ids{dim} = k;       % fill subscript template with slice number
    y(ids{:}) = C{k};   % copy cell element into array slice
end