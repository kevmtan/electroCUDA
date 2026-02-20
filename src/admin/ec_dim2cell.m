function y = ec_dim2cell(x,dim)
%% ec_dim2cell (https://github.com/kevmtan/electroCUDA)
% Squeeze array into cell along diminsion

%% Input validation
arguments
    x                    % Input array/matrix
    dim (1,1) double = 1 % Dimension
end

%% Main
dims = 1:ndims(x);
dims(dim) = [];
y = num2cell(x,dims);
y = cellfun(@squeeze,y,UniformOutput=false);
