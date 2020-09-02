%% Monte Carlo Photon Propagation
% Estimates the path the photon takes in spherical coordinates once it
% interacts with an element in tissue. coordinates are (theta,phi,s), where
% s is the step size (cm), theta is the pitch (rad), and phi is the 
% rotation of the photon (rad).
%
%Tissue Parameters:
%mu_a  %optical absorption cm^-1
%mu_s %optical scattering cm^-1
%g %anisotropy factor
%rho %density g/cm^2
%w %photon energy
%
%
%Authors: Karim Tarabein <katarabein@wpi.edui>
% 5/11/2020
%


function [dtheta dphi ds delw] = Monte_Carlo(w,mu_a,mu_s,g);
%g = 0.9; 
%step size 
n = 1; %number of cycles
dsa=zeros(1,n);
dphia=zeros(1,n);
dthetaa=zeros(1,n);
for i = 1:n
dsa(i) = -log(rand)/(mu_a+mu_s);
dphia(i) = 2*rand*pi;
dthetaa(i) = henyeygreenstein(g);
end
ds = mean(dsa);
dphi = mean(dphia);
dtheta = mean(dthetaa);
delw = w*mu_a/(mu_a+mu_s);
end 


    