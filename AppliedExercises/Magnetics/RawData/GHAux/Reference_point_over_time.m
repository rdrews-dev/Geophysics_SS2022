clear all;
clc

%--------------------------------------------------------------------------
%% Data preparation

% Read data as matrix
M = readmatrix('Reference_point_over_time');

% Define time series and measured total field
t = M(1:end,1); % Time [min]
B = M(1:end,2); % Total field [nT]

%--------------------------------------------------------------------------
%% Plotting
figure(1)
plot(t,B,'Color',[0.7,0.7,0.7],LineWidth=1)
% Mean of reference meausrements [nT]
yline(48310.86364,'r',LineWidth=1.5,LineStyle='--'); 
hold on
scatter(t,B,'k','+',LineWidth=1);
xlabel('Zeit [min]');
ylabel('Totales Feld [nT]');
legend('Referenzmessung','Mittelwert')

%--------------------------------------------------------------------------