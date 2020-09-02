%NOTE: this is intended to be a short demo for the PAP matrix that should
%run in 6 min total. Ideally, you will want to do this with 600,000
%photons. Understand that a decent number of these may reflect off the top
%surface and escape the boundaries

%add to path the src folder using the file explorer address
addpath('C:\Users\kktar\Google Drive\Phd\MATLAB\Monte_Carlo_Laser\src');

% [PAP Tw] = photonpath(method,N,r,cf,t_type,spotsize,l_type)
%
% 100,000 photons, r = 1 cm, cf = 0.005 cm, t_type = blood (3),  spotsize =
% 0.05 cm

%Method 1 (homogenous), laser type 1 (gaussian)

[PAP Tw] = photonpath(1,100000,1,0.005,3,0.05,1);

%Prepare slice of PAP in the xz direction, display using a log10 scale to
%show smaller variances

[L W H] = size(PAP);

slice = zeros(L,W);

slice(:,:) = PAP(:,round(W/2),:); 

%Transpose slice because picture coordinates = transposed matrix
%coordinates. Remember, one pixel or element is 1 cf for spatial conversion
%purposes
imagesc(log10(slice')); 
colormap(makec2f);
axis equal image;
xlabel('elements (cm/cf) in x direction');
ylabel('elements (cm/cf) in z direction');
colorbar;
title('log10 scale image slice in XZ plane through center of PAP (1/cm^3)');


