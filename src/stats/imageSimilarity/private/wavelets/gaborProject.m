function projCoeff=gaborProject(gaborIn,picIn)

% projCoeff = gaborProject(gaborIn, picIn)
%
% assumes gaborIn has unit power, can be either cell or matrix
% assumes gaborIn and picIn are same dimensions
% normalizes picIn to unit power

picIn=double(picIn);
picIn=picIn-median([picIn(1,1) picIn(1,end) picIn(end,1) picIn(end,end)]);
picIn=picIn/sum(picIn(:).^2);

if iscell(gaborIn),
  cellSize=length(gaborIn);
  projCoeff=zeros(1,cellSize);
  for k=1:cellSize,
    projCoeff(k) = sum(sum(picIn.*gaborIn{k}));
  end;
else,
  projCoeff = sum(sum((picIn/sum(picIn(:).^2)).*gaborIn));
end;
