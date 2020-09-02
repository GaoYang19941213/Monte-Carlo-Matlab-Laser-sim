%Test PositionPhotons

Plane = zeros(101); %101x101 matrix for reference plane
spotradius = 45; %10 element spot radius, 20 element spot diameter
testinitializephotons; %run testinitializephotons
close all;

[PhotonDist] = PositionPhotons(Plane,photonPositions,spotradius);

surf(PhotonDist);
title('Position of photons on tissue surface');