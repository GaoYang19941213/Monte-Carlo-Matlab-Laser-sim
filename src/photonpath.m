%% PHOTONPATH
%
%
% Author: Karim Tarabein
% Last edited: May 30th, 2020
%
%Uses the .f's in src to perform Monte carlo analysis and create a PAP
%matrix for the desired tissue. Assumes laser is highly collimated and
%arrives at the surface with all of its energy. There is a possibility to
%factor in power loss in air using the heterogenous tissue mode as air is
%in the tissue library as well, but generally it is negligable.
%
%Alternatively, one could use the functions in this seperately. Once you
%create a PAP matrix, fluence = PAP * power of laser. If you use a number
%of photons large enough this simulation can take an hour or two.
%
% *Below is an explanation of the outputs*
%
% PAP: a probabalistic matrix of the distribution of photons in a
% substance. Multiply the PAP by the laser power to get fluence in terms of
% Watts. Multiply PAP by the power of the laser and time on to get the
% energy deposition.
%
%
% Tw: a matrix of the distribution of theoretical photons in a substance.
% It is only a representation of the result, purely theoretical. Dividing
% by total number of theoretical photons leads to PAP. Use this to test
% your set up. sum(sum(sum(Tw))) should never equal more than number of
% photons, although it can equal less since photons can escape
%
% *Below is an explanation of inputs*
%
% method: only 1 or 2 are acceptable inputs. Method 1 is homogenous where
% you define a tissue type according to the makeTissueList below. Method 2
% is using the maketissue file from mcxyz to create homogenous tissue. You
% will need to change the maketissue file yourself to change what the
% heterogenous makeup is of the tissue. Method 2 also outputs a figure
% representing the tissue you are firing the laser at as well as a
% distribution of laser lines representing the spotsize.
%
% ---- tissueList ------ 	mua   	mus  	g  	musp
%1	            air	
%2	          water	
%3	          blood	
%4	         dermis	
%5	      epidermis	
%6	          skull	
%7	    gray matter	
%8	   white matter	
%9	standard tissue	
%
% N: number of photons you are simulating. It is reccomended to use at
% least 100,000 photons. 
%
% r: length of the tissue cube in cm
%
% cf: distance between each element in the tissue mesh in cm
%
% t_type: tissue type only used in homogenous samples (method = 1), 
% use tissue list above to select the homogenous tissue type desired
%
% spotsize: diameter of spot size in cm, assumes circular profile
%
% l_type: can only equal 1 or 2, type 1 is gaussian (single phase) laser.
% type 2 is a square wave distribution.

function [C TmuA PAP Tw] = photonpath(method,N,r,cf,t_type,spotsize,l_type,nm)


tic


%Step 1, select method and make tissue

if method == 1 %homogenous, deals with tissueMesh.m, use help tissueMesh to understand more
    [TmuA TmuS Trho Tw origin] = Tissue_Mesh(r,cf,t_type,nm); 
    L = length(TmuA);
    g = 0.9; %g = 0.9 for most soft tissue
elseif method == 2 %heterogenous, edit maketissueRBE595.m
    maketissueRBE595; 
    cf = binsize;
    TmuA = zeros(Nbins,Nbins,Nbins);
    TmuS = zeros(Nbins,Nbins,Nbins);
    Tw = zeros(Nbins,Nbins,Nbins);
    for ix = 1:Nbins
        for iz = 1:Nbins
            for iy = 1:Nbins
                TmuA(ix,iy,iz) = tissueList(T(ix,iy,iz)).mua;
                TmuS(ix,iy,iz) = tissueList(T(ix,iy,iz)).mus;
                Tg(ix,iy,iz) = tissueList(T(ix,iy,iz)).g;
            end
        end
    end
    r = round(Nbins/2)*binsize; 
    origin = [r/cf r/cf round(zsurf/cf)]; 
    L = Nbins;
end

%Step 2 choose laser distribution type and assign spotsize

if l_type == 1
    sigma = spotsize/0.2; % sigma = 1 leads to spot size ~ 0.2 cm. 
    photonP = initializephotons(N, sigma); %gaussian
elseif l_type ==2 
    photonP = flatwave(N,spotsize); % square wave
end



% Step 3: Starting positions for photons
s_start = 0; %starting orientations for each photo (collimated)
w_start = 1;
theta_start = 0;
phi_start = 0;

%starting position
startP = origin';

%Step 4: Run Monte Carlo for each photon and chart its path of deposited
%energy, matrix Tw
for i = 1:N
    C = round((photonP(:,i)/cf))+startP; 
    ssp(:,i) = C;
    w = w_start;
    theta=theta_start;
    phi=phi_start;
    s = s_start;
    while w >0.001 
        %Exit conditions
         if C(1) < 1 
             C = [2;0;0]
             break
         end
         if C(2) < 1
             C = [0;2;0]
             break 
         end
         if C(3) < 1
             C = [0;0;2]
             break 
         end
         if C(1) > L
             C = [1;0;0]
             break 
         end
         if C(2) > L
             C = [0;1;0]
             break 
         end
         if C(3) > L
             C = [0;0;1]
             break 
         end
        %extract optical and physical properties at point
        mu_a = TmuA(C(1),C(2),C(3)); 
        mu_s = TmuS(C(1),C(2),C(3)); 
               
        if method ==1 
            g = 0.9;
        elseif method ==2 
            g = Tg(C(1),C(2),C(3));
        end
   
               [dtheta dphi s delw] = Monte_Carlo(w,mu_a,mu_s,g);
               theta= theta+dtheta; 
               phi = phi+dphi; 
               w = w-delw; 
               [V Cn] = vector2mesh(s,theta,phi,C,cf);
               C = Cn; 
               if C(1) < 1 
                   C = [2;0;0]
                   break
               end
               if C(2) < 1
                   C = [0;2;0]
                   break 
               end
               if C(3) < 1 
                   C = [0;0;2] 
                   break 
               end
               if C(1) > L
                   C = [1;0;0]
                   break 
               end
               if C(2) > L
                   C = [0;1;0]
                   break 
               end
               if C(3) > L
                   C = [0;0;1]
                   break 
               end
               Tw(C(1),C(2),C(3))= Tw(C(1),C(2),C(3)) + delw;
               %Exit conditions
         
    end
end
 toc

dd = length(Tw);

wtotal = w_start*N; %total w of photons positioned on tissue surface
PAP = Tw/wtotal;
end
