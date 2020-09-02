function [PhotonDist] = PositionPhotons(Plane,photonPositions,spotradius)
%POSITIONPHOTONS Takes XY photon positions and places them over a 2D
%Matrix. Paired with initializephotons.f
%   
% 
%  Returns a 2D matrix with values representing number of photons across
%  the input matrix. Spotsize is the radius of the laser in number of
%  elements, be sure to convert it from cm to # elements before inputting
%  into the function. 
% 
%   
%  Authors: Karim A. Tarabein <katarabein@wpi.edu>
%           
%  
%  Last Modified: 4/22/2020

[L W] = size(Plane); %get size of plane
PhotonDist = zeros(L,W);

origin = [((L-1)/2)+1,((W-1)/2)+1]; %find center of plane

maxpos = max(photonPositions'); %max values for position

normpos = [photonPositions(1,:)'/maxpos(1) photonPositions(2,:)'/maxpos(2)];
%normalized position 

spotpos = normpos*spotradius; %position based on spotsize
roundpos = round(spotpos); %round xy to whole numbers

%shift the photon positions by the origin
spotpos_originshifted(:,1) = roundpos(:,1) + origin(1); 
spotpos_originshifted(:,2) = roundpos(:,2) + origin(2); 
spo = spotpos_originshifted;
spo = round(spo);

for i = 1:length(photonPositions)
    PhotonDist(spo(i,1),spo(i,2)) = PhotonDist(spo(i,1),spo(i,2))+1;
    %add 1 for every photon in each position onto the plane
end

