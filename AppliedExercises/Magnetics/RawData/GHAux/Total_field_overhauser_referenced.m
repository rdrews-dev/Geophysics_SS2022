clear all;
clc

%--------------------------------------------------------------------------
%% Data preparation

% Read data as matrix
M = readmatrix('Total_field_overhauser_measurements_referenced');

% Define x and y (coordinate system) and referenced total field measurements
x = M(1,2:end); % x-direction 1-20m
y = M(2:end,1); % y-direction 1-20m
B = M(2:end,2:end); % Total field [nT]

% Inverse Outlier removal
% (Look for anomaly --> remove outliers outside range of anomaly)
% Removal of outliers > 150 and < -150 outside of anomaly
% Removal of outliers > 1000 and < -1000 inside of anomaly
Outl_1 = B(1:2,1:end) > 150 | B(1:2,1:end) < -150;
Outl_2 = B(14:21,1:end) > 150 | B(14:21,1:end) < -150;
Outl_anom = B(3:13,1:end) > 1000 | B(3:13,1:end) < -1000;
B_clean = [Outl_1; Outl_anom; Outl_2];
B(B_clean==1)=nan;

% Interpolate outliers
B = fillmissing(B,"linear"); % Linear interpolation of NaNs

% All data for y = [1:2] was removed in plotting due to the strong
% visible influence of neighbouring metal fences.

%--------------------------------------------------------------------------
%% Plotting

% Surface plot ------------------------------------------------------------
figure(1)
surf(x,y(3:21,:),B(3:21,:),'FaceColor','interp')
xlabel('x [m]');
ylabel('y [m]');
legend = colorbar; % Legend countour colours
legend.Label.String = 'Totales Feld referenziert [nT]'; % Label legend
legend.FontSize = 11; % Font size legend
colormap(jet);
hold on

% Contour plot ------------------------------------------------------------
figure(2)
contours = [-400:50:300]; % countour line every 50 nT
%contour(x,y,grad,contours)
contourf(x,y(3:21,:),B(3:21,:),contours) % filled countour lines
xlabel('x [m]');
ylabel('y [m]');
legend = colorbar; % Legend countour colours
legend.Label.String = 'Totales Feld referenziert [nT]'; % Label legend
legend.FontSize = 11; % Font size legend
colormap(jet);

% Cross section along anomaly (surface plot)-------------------------------
figure(3)
 % Surface plot with cross section plane
subplot(1,2,1)
surf(x,y(3:21,:),B(3:21,:),'FaceColor','interp')
xlabel('x [m]');
ylabel('y [m]');
legend = colorbar;
legend.Label.String = 'Totales Feld referenziert [nT]';
legend.FontSize = 11;
colormap(jet);
hold on
% Visualize cross section plane
patch([0,0,20,20],[5,5,7,7],[300,-400,-400,300],'w','FaceAlpha',0.7)

x_s = linspace(0,20,21); % x over cross section plane
y_s = linspace(5,7,21); % y over cross section plane
B_s = interp2(x,y,B,x_s,y_s); % Interpolate over surface
ori = sqrt((x_s-0).^2+(y_s-5).^2); % Define origin axis for cross section

% Cross section plot
subplot(1,2,2)
plot(ori,B_s,'k',LineWidth=1)
axis([min(ori),max(ori),-400,300]);
xlabel('Distanz [m]');
ylabel('Totales Feld referenziert [nT]');

% Cross sections through Min/Max in surface plot --------------------------
figure(4)
subplot(1,2,1) % Cross section at x = 6 (anomaly minimum)
plot(y(3:end),B(3:end,15),'Color',[0.7,0.7,0.7],LineWidth=1,LineStyle='--') 
hold on
scatter(y(3:end),B(3:end,15),'k','+',LineWidth=1)
xlabel('y (x = 6) [m]');
ylabel('Totales Feld referenziert [nT]');
hold off
subplot(1,2,2) % Cross section at x = 20 (anomaly maximum)
plot(y(3:end),B(3:end,1),'Color',[0.7,0.7,0.7],LineWidth=1,LineStyle='--')
hold on
scatter(y(3:end),B(3:end,1),'k','+',LineWidth=1)
xlabel('y (x = 20) [m]');
ylabel('Totales Feld referenziert [nT]');
hold off

%--------------------------------------------------------------------------

