function [ ] = plotSpheres(electrodes, color)
%PLOTSPHERES  Plot electrodes as spheres of a given color

%   Author: Jan Kubanek
%   Institution: Wadsworth Center, NYSDOH, Albany, NY
%   Date: August 2005
%   This procedure is a part of the NeuralAct Matlab package.


ELS = size(electrodes, 1);
for els = 1 : ELS,    
    %original electrode locations:
    xe = electrodes(els, 1);
    ye = electrodes(els, 2);
    ze = electrodes(els, 3);
    %generate sphere coordinates
    [X, Y, Z] = sphere(40);

    %place the sphere into the spot:
    R = 1.5; %sphere radius
    X = R * X + xe;
    Y = R * Y + ye;
    Z = R * Z + ze;

    hold on;
    surf(X, Y, Z, 'FaceColor', color, 'EdgeColor', 'none');
end

hold off;