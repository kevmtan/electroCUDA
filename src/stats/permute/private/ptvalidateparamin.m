function ptvalidateparamin(x,y,a)
%PTVALIDATEPARAMIN  Validate input parameters of PERMUTOOLS functions.
%   PTVALIDATEPARAMIN(X,Y,ARG) validates the input parameters X and Y, and
%   input arguments ARG of the main PERMUTOOLS functions.
%
%   See also PTPARSEVARARGIN.
%
%   PERMUTOOLS https://github.com/mickcrosse/PERMUTOOLS

%   © 2018-2024 Mick Crosse <crossemj@tcd.ie>
%   CNL, Albert Einstein College of Medicine, NY.
%   TCBE, Trinity College Dublin, Ireland.

if ~isnumeric(x)
    error('X must be numeric.')
elseif ~isnumeric(y)
    error('Y must be numeric or empty.')
end
if a.alpha < 1/a.nPerm
    warning('Number of permutations may be too low for chosen ALPHA.')
end