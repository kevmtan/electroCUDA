function mustBeDims(input,numDims)
    % Test for number of dimensions    
    if ~any(ismember(length(size(input)),numDims))
        eid = 'Size:wrongDimensions';
        msg = ['Input must have ',num2str(numDims),' dimension(s).'];
        throwAsCaller(MException(eid,msg))
    end
end