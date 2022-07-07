clear all;
clc

%--------------------------------------------------------------------------
%% Data preparation

% Read data as matrix
M = readmatrix('Vertical_gradient_fluxgate_measurements');

% Define x and y (coordinate system) and gradient measurements
x = M(1,2:end); % x-direction 1-20m
y = M(2:end,1); % y-direction 1-20m
grad = M(2:end,2:end); % gradient measurements

% Inverse Outlier removal
% Look for anomaly --> remove outliers outside range of anomaly
% Removal of outliers > 100 and < -100 outside of anomaly
% Removal of outliers > 1000 and < -1000 inside of anomaly
Outl_1 = grad(1:2,1:end) > 100 | grad(1:2,1:end) < -100;
Outl_2 = grad(11:21,1:end) > 100 | grad(11:21,1:end) < -100;
Outl_anom = grad(3:10,1:end) > 1000 | grad(3:10,1:end) < -1000;
grad_clean = [Outl_1; Outl_anom; Outl_2];
grad(grad_clean==1)=nan;

% Interpolate outliers
grad = fillmissing(grad,"linear"); % Linear interpolation of NaNs

%--------------------------------------------------------------------------
%% Plotting

% Surface plot ------------------------------------------------------------
figure(1)
surf(x,y,grad,'FaceColor','interp')
xlabel('x [m]');
ylabel('y [m]');
legend = colorbar;
legend.Label.String = 'Fluxgate Gradient [nT/m]';
legend.FontSize = 11;
colormap(jet);

% Contour plot ------------------------------------------------------------
figure(2)
contours = [-400:50:300]; % countour line every 50 nT
contourf(x,y,grad,contours) % filled in countour lines
xlabel('x [m]');
ylabel('y [m]');
legend = colorbar;
legend.Label.String = 'Fluxgate Gradient [nT/m]';
legend.FontSize = 11;
colormap(jet);

%--------------------------------------------------------------------------
