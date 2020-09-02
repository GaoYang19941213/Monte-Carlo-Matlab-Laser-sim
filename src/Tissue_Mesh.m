%% TISSUE_MESH
%
% Author: Karim A. Tarabein <katarabein@wpi.edu>
% Last edited: May 30th, 2020
%
%
% Input desired radius for tissue (r) in cm, the distance between each
% representative element (cf) in cm, tissue type seen in the list below,
% and wavelength of laser (nm)
%
% TISSUE TYPES
% 1-air, 2-water, 3-blood, 4-dermis, 5-epidermis, 6-skull, 7-graymatter
% 8-whitematter, 9-standardsofttissue

function [tissue_mua tissue_mus tissue_rho tissue origin] = Tissue_Mesh(r,cf,t_type,wavelength)

%r = cm
n = r / cf; 
%where cf is the representative distance between two elements, and n is
%the number of elements all a distance of cf between eachother
rho = 1; %g/cm^3

nm = wavelength; %wavelength laser
tissueList = makeTissueList(nm);

% tissue type
% 1-air, 2-water, 3-blood, 4-dermis, 5-epidermis, 6-skull, 7-graymatter
% 8-whitematter, 9-standardsofttissue

%samples optical properties from tissue type library and creates a matrix
%using those properties
mu_a=tissueList(t_type).mua;
mu_s=tissueList(t_type).mus;

tissue = zeros(2*n+1,2*n+1,2*n+1); 
%creates a tissue mesh with a definite median on the surgace

origin = [n+1,n+1,1];

tissue_mua = tissue+mu_a;
tissue_mus = tissue+mu_s;
tissue_rho = tissue+rho; 
%rho is not in the library, useful for heat but not fluence calculations

end 
