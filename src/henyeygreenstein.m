function [theta] = henyeygreenstein(g)
%HENYEYGREENSTEIN random sampling of Henyey-Greenstein distribution
%   Takes anisotropy factor 'g' and uses Henyey-Greenstein distribution to
%   sample theta.
%
% Authors: Karim A. Tarabein <katarabein@wpi.edu>
%          Loris Fichera
%
% 4/28/2020

x = rand;

if g == 0
        theta = arccos(2*x-1);
else
        theta = acos((1/(2*g))*(1+g^2-(1-g^2)/(1-g+2*g*x)));
end
end

