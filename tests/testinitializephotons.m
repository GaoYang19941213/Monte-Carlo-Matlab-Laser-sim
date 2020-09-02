% Create a Gaussian beam with N = 100 photons and stardard deviation = 1;
N = 10000;
sigma = 20;

% Call the function
photonPositions = initializephotons(N, sigma);

% Visualize the output
figure, axis equal, hold on
scatter3(photonPositions(1,:), photonPositions(2,:), photonPositions(3,:),'g');
grid on;
xlabel('X'); %remember units
ylabel('Y');
zlabel('Z');

figure;
%histogram(ans);
hist3(photonPositions(1:2,:)','Nbins',[100 100]);
