function [ ] = plotElNums(electrodes)
%PLOTELNUMS  Plot electrodes numbers

%   Author: Jan Kubanek
%   Institution: Wadsworth Center, NYSDOH, Albany, NY
%   Date: August 2005
%   This procedure is a part of the NeuralAct Matlab package.


ELS = size(electrodes, 1);
for els = 1 : ELS,    
    %original electrode locations:
    X = electrodes(els, 1);
    Y = electrodes(els, 2);
    Z = electrodes(els, 3);
    elnum=sprintf('%d', els);
    
    th = text(X, Y, Z, elnum);
    set(th, 'fontweight', 'bold', 'fontsize', 18);
end