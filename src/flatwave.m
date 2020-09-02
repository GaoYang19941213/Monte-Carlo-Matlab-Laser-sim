function [photonPosition] = flatwave(N,spotsize)
%FLATWAVE 
%
% square wave distribution of photons for non single phase lasers. Inputs N
% = number of photons to distribute, spotsize = diameter in cm.
%
% Outputs XY coordinates for the photons on the starting surface.
%
% Author: Karim A. Tarabein
% Last edited: May 30th, 2020

photonPosition = zeros(3,N); %make empty matrix output
photonPosition(1,:) = rand(1,N)*spotsize/2; %Generate points across 1D square

%apply random rotation transform across each X Y pairs
phi = rand([1,N])*2*pi;

for i = 1:N    
    R = rotz(phi(i));
    photonPosition(:,i) = R * photonPosition(:,i);
end
end

