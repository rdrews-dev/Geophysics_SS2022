clear all
close all

%Gravitational constants in SI units
G_SI = 6.674e-11;
%Density of core and crust in kg m^{-3}
rho_crust = 2.7*100^3/1000;
rho_core = 13.0 * 100^3/1000;
%Mean density in this model (ouch, too high)
rho_mean = (rho_crust+rho_core)/2; 
%Radius of a spherical Earth in m
R = 6371*1000;l=0:1:R;


%% Made up linear density
LinearDensity = (rho_crust-rho_core)/R*(l-R)+rho_crust;
%% PREM Density
PREM = dlmread('PREM.txt',' ',4,0);
PREM_Depth = PREM(:,2)*1000;PREM_Density = PREM(:,5)*100^3/1000;PREM_dz = (PREM(2,2)-PREM(3,2))*1000;
[PREM_Depth,ia,ic] = unique(PREM_Depth);PREM_Density=PREM_Density(ia);PREM_Depth(1)=1e-3;

%% Get the corresponding gs
gConstantDensity = G_SI*rho_mean*4.0/3.0*pi*l;
gLinearDensity = 4*pi*G_SI*((rho_crust-rho_core)/(4*R)*l.^2+1.0/3.0*rho_core*l);

%% Numerical integration using the trapezoidal rule
for kk=2:length(PREM_Depth)
   gPREM(kk) = 4*pi*G_SI.*1./(PREM_Depth(kk).^2).*trapz(PREM_Depth(1:kk),PREM_Density(1:kk).*PREM_Depth(1:kk).^2); 
end

fig=figure(1)
subplot(1,2,1)
plot(l/R,gConstantDensity,'r-','LineWidth',3);hold on
plot(l/R,gLinearDensity,'b-','LineWidth',3);hold on
plot(PREM_Depth/max(PREM_Depth),gPREM,'-','LineWidth',3,'color', [0 0.5 0])
ylabel('g (m s^{-2})')
xlabel('Distance/R_E')
legend('Constant Density','Linear Density','PREM Density','Location','SouthEast')
box off;grid on;
legend('box','off')
subplot(1,2,2)
plot(l/R,LinearDensity,'b-','LineWidth',3);hold on
plot(l/R,LinearDensity*0+rho_mean,'r-','LineWidth',3);
plot(PREM_Depth/max(PREM_Depth),PREM_Density,'-','LineWidth',3,'color', [0 0.5 0])
ylabel('Density (kg m^{-3})')
xlabel('Distance/R_E')
box off;grid on;

%Export to a png. (This can be done much better.)
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 20 10])
set(findall(fig, '-property', 'FontSize'), 'FontSize', 12)
print('-dpng','-r300','../../../Exercises/Figures/Gravimetry/Gravimetry01_GravityInsideEarth.png')

fig=figure(2)
plot(PREM_Depth/max(PREM_Depth),PREM_Density,'-','LineWidth',3,'color', [0 0.5 0])
box off;
grid on;
legend('Density from PREM');ylabel('Density [kg m^3]');xlabel('Distance/R_E')
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 10 10])
set(findall(fig, '-property', 'FontSize'), 'FontSize', 12)
print('-dpng','-r300','../../../Exercises/Figures/Gravimetry/Gravimetry01_PREM.png')