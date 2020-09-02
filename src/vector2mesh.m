%% VECTOR2MESH
%
% Author: Karim A. Tarabein <katarabein@wpi.edu>
% Last edited: May 30th, 2020
%
% Converts spherical coordinates of photons outputed from Monte_Carlo.m 
% and transforms them to fit the coordinate frame of the tissue mesh 
% structure

function [V C] = vector2mesh(r,theta,phi,origin,cf)
%conversion factor, from unit length to # of elements

x = r*sin(phi)*cos(theta);
y = r*sin(phi)*sin(theta);
z = r*cos(phi);

%vector in xyz transformed to match input coordinate system
V = rotx(pi)*[x;y;z];

%output coordinate transformed to match input coordinate system
C = round(origin + (V/cf));
end