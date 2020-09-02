function photonPositions = initializephotons(N, sigma)
%INITIALIZEPHOTONS Initializes N photons according to a Gaussian
%distribution with standard deviation equal to sigma (cm).
% 
%  Returns a matrix of 3xN elements representing the XYZ coordinates of the
%  photons. 2 sigma seems to equal spot diameter of 0.45 cm, 1 = 0.2 cm.
%   
%  Authors: Karim A. Tarabein <katarabein@wpi.edu>
%           Loris Fichera <lfichera@wpi.edu>
%  
%  Last Modified: 4/21/2020

photonPositions = zeros(3,N); %make empty matrix output
photonPositions(1,:) = normrnd(0,sigma,1,N); %Generate points across 1D Gauss

%apply random rotation transform across each X Y pairs
phi = rand([1,N])*2*pi;

for i = 1:N    
    R = rotz(phi(i));
    photonPositions(:,i) = R * photonPositions(:,i);
end
end