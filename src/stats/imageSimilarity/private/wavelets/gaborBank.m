function gaborCell=gaborBank(dimX,dimY,numSizes)

% gaborCell=gaborBank(dimX,dimY,numSizes)
%
% returns gabor filters at different locations, orientations, 
% and sizes

baseSigma=80*2*max(dimX,dimY)/400;
baseFreq=.005/2*(400/max(dimX,dimY));
thetaVec=[0 .125*pi .25*pi .375*pi .5*pi .625*pi .75*pi .875*pi];

ind=1;
for lev=1:numSizes,
  intervalLenX=dimX/(2^lev);
  intervalLenY=dimY/(2^lev);
  for x=1:2:2^lev,
    for y=1:2:2^lev,
      for i=1:8,
        A=gabor_fn(-dimX/2+[1:dimX],-dimY/2+[1:dimY],baseSigma/(2^(lev-1)),thetaVec(i),baseFreq*2^(lev-1),[-dimX/2+x*intervalLenX -dimY/2+y*intervalLenY 0]);
        A=A/sqrt(sum(A(:).^2));
        gaborCell{ind}=A;
        ind=ind+1;
        A=gabor_fn(-dimX/2+[1:dimX],-dimY/2+[1:dimY],baseSigma/(2^(lev-1)),thetaVec(i),baseFreq*2^(lev-1),[-dimX/2+x*intervalLenX -dimY/2+y*intervalLenY .5*pi]);
        A=A/sqrt(sum(A(:).^2));
        gaborCell{ind}=A;
        ind=ind+1;
      end;
    end;
  end;
end;

%A=gabor_fn(-199:200,-199:200,40,.25*pi,.009,[-100 100]);
