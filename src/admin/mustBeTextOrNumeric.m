function mustBeTextOrNumeric(input)
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

if ~(istext(input) || isnumeric(input))
    error('Input must be text or numeric');
end