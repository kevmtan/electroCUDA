function y = ec_dim2cell(x,dim)
%% ec_dim2cell (https://github.com/kevmtan/electroCUDA)
% Squeeze array into cell along diminsion

%% Input validation
arguments
    x                    % Input array/matrix
    dim (1,1) double = 1 % Dimension
end

%% Main
sz = size(x);

if dim==2 && length(sz)<=3
    y = cell(1,sz(2));
    for c = 1:sz(2)
        y{c} = squeeze(x(:,c,:));
    end
else
    sz = 1:length(size(x));
    sz(dim) = [];

    y = num2cell(x,sz);
    y = cellfun(@squeeze,y,UniformOutput=false);
end
