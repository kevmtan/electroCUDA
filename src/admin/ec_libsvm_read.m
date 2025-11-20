function [x,y] = ec_libsvm_read(fn)

x = readmatrix(fn,Filetype="text",OutputType="string");
if ~contains(x(1,1),":")
    y = str2double(x(:,1));
    x = x(:,2:end);
else
    y = [];
end

x = str2double(extractAfter(x,":"));