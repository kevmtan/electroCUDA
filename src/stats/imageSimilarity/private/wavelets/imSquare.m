function imOut=imSquare(imIn,borderVal)

% function imOut=imSquare(imIn,borderVal)
%
% RGB input:
% converts n x m x 3 image matrix imIn to a padded 
% max(n,m) x max(n,m) x 3 image matrix imOut
%
% if specified, borderVal is a 3-element vector specifying
% the intensity values (in rgb dimensions) for pixels at the edge
% of the picture
%
% Grayscale input:
% same as for RGB input except imIn is n x m and borderVal has 
% 1 element

imIn=double(imIn);

bool3D = length(size(imIn))==3;

if bool3D,
  for k=1:3,
    initBorderVal(k)=median([imIn(1,1,k) imIn(1,end,k) imIn(end,1,k) imIn(end,end,k)]);
  end;
  if ~exist('borderVal'),
    borderVal=initBorderVal;
  end;
else,
  initBorderVal=median([imIn(1,1) imIn(1,end) imIn(end,1) imIn(end,end)]);
  if ~exist('borderVal'),
    borderVal=initBorderVal;
  end;
end;

maxSize=max(size(imIn,1),size(imIn,2));
if size(imIn,1)<maxSize,
  bufferSize=maxSize-size(imIn,1);
  if bool3D,
    imOut=zeros([maxSize maxSize 3]);
    for k=1:3,
      imOut(:,:,k)=initBorderVal(k)*ones([maxSize maxSize]);
      imOut(round(bufferSize/2)+[1:(size(imIn,1))],:,k)=imIn(:,:,k);
    end;
  else,
    imOut=zeros([maxSize maxSize]);
    imOut=initBorderVal*ones([maxSize maxSize]);
    imOut(round(bufferSize/2)+[1:(size(imIn,1))],:)=imIn(:,:);
  end;
else,
  bufferSize=maxSize-size(imIn,2);
  if bool3D,
    imOut=zeros([maxSize maxSize 3]);
    for k=1:3,
      imOut(:,:,k)=initBorderVal(k)*ones([maxSize maxSize]);
      imOut(:,round(bufferSize/2)+[1:(size(imIn,2))],k)=imIn(:,:,k);
    end;
  else,
    imOut=zeros([maxSize maxSize]);
    imOut=initBorderVal*ones([maxSize maxSize]);
    imOut(round(bufferSize/2)+[1:(size(imIn,1))],:)=imIn(:,:);
  end;
end;

if bool3D,
  for k=1:3,
    imTemp=squeeze(imOut(:,:,k));
    imTemp(find(imTemp==initBorderVal(k)))=borderVal(k);
    imOut(:,:,k)=imTemp;
%    imOut(find(imOut==initBorderVal(k)))=borderVal(k);
  end;
else,
  imOut(find(imOut==initBorderVal))=borderVal;  
end;
