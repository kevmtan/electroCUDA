function z=nt_double2int(x,param)
%nt_double2int() - recode/decode double as integer to save space
%
% z=nt_double2int(x,intsize): recode double as integer
%   z: coded data
%   x: data to code (matrix or array of matrices)
%   intsize: [default: 'int16']
%
% x=nt_double2int(z,indices): decode back to double
%   x: decoded data
%   z: coded data
%   indices: indices of rows/columns [default: all]
%     indices{1}: rows to keep
%     indices{2}: columns to keep
%
% Data are coded as a structure including a matrix of integers together with
% min and max of each column:
%   z.ints: data scaled and coded as ints
%   z.min: min of original data
%   z.max: max of original data
%   z.intsize: integer type (e.g. 'int16')
%
% They can also consist of a cell array of such structures.
% 
% NoiseTools

nt_greetings;


if iscell(x)
    for iChunk=1:numel(x)
        z{iChunk}=nt_double2int(x{iChunk},param);
    end
    return
end

if isfloat(x) % code to integer

    if nargin<2; param='int16'; end
    intsize=param;
    sz=size(x);
    if ndims(x)>2; x=x(:,:); end
   
    z.ints=zeros(size(x),intsize);
    z.min=zeros(1,size(x,2));
    z.max=zeros(1,size(x,2));
    z.intsize=intsize;
    
    % recode columns individually
    for iCol=1:size(x,2);
        z.min(iCol)=min(x(:,iCol));        
        z.max(iCol)=max(x(:,iCol));
        z.ints(:,iCol)= double(intmin(intsize)) + ...
            (x(:,iCol) - z.min(iCol)) * ...
            ( double(intmax(intsize))-double(intmin(intsize)) ) /...
            ( z.max(iCol)-z.min(iCol) ); % automatically coerced to intsize
    end
    z.ints=reshape(z.ints,sz);
    
else % decode back to double
    
    assert(isstruct(x), '!');
    intsize=x.intsize;
    sz=size(x.ints);
    if ndims(x.ints)>2; x.ints=x.ints(:,:); end

    if nargin<2; param=[]; end
    indices=param;
    
    if isempty(indices); 
        
        % default: decode all
        z=zeros(size(x.ints));
        for iCol=1:size(x.ints,2)
            z(:,iCol) = x.min(iCol) + ...
                (x.max(iCol)-x.min(iCol)) / (double(intmax(intsize))-double(intmin(intsize))) * (double(x.ints(:,iCol))-double(intmin(intsize)));
        end
        z=reshape(z,sz);
        
    else
        % select rows and/or columns
        if numel(indices)<2; indices{2}=[]; end
        if isempty(indices{1}); indices{1}=1:size(x.ints,1); end
        if isempty(indices{2}); indices{2}=1:size(x.ints,2); end
        
        z=zeros(numel(indices{1}),numel(indices{2}));
        
        for idx=1:numel(indices{2})
            iCol=indices{2}(idx);
            z(:,idx) = x.min(iCol) + ...
                (x.max(iCol)-x.min(iCol)) / (double ( double(intmax(intsize))-double(intmin(intsize)))) * (double(x.ints(indices{1},iCol))-double(intmin(intsize)));
        end
        
        
        if numel(sz)>2 && numel(indices{2})<size(x.ints,2)
            warning('output data has not been reshaped');
        else
            z=reshape(z,[numel(indices{1}),numel(indices{2})]);
        end
        
    end
    
end




        