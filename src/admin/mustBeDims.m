function mustBeDims(input,numDims)
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

if ~any(ismember(length(size(input)),numDims))
    eid = 'Size:wrongDimensions';
    msg = ['Input must have ',num2str(numDims),' dimension(s).'];
    throwAsCaller(MException(eid,msg))
end