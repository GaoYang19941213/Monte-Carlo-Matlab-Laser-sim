
%test henyeygreenstein and plot the distribution of random sampling to
%compare to henyey greenstein equation

g = 0.9; %anisotropy factor

n = 1000;
theta_all = zeros(1,n);

for i = 1:n
    theta_all(i) = henyeygreenstein(g);
end

figure;
histogram(cos(theta_all));
xlim([-1 1]);
title('Histogram of randomly generated cos(\theta) values');
syms 'Q' 'real'; %Q = cos theta

P = (1-g^2)/(2*(1+g^2-2*g*Q)^(3/2));
figure;
fplot(P,[-1 1])
title('Henyey-Greenstein Distribution line');