clear all
close all

%This is vector x for the lateral distance
x = -150:0.01:150;
%Depth of the sphere
z = 50;
%Radius of the sphere
R = 25;
%Constants for the limestone cave scenario 
%(SI stands for System International units)
DensityLimestone_InGramsPerCentimeterCubed = 2.0;
DensityLimestone_SI = DensityLimestone_InGramsPerCentimeterCubed *1/1000 * 100^3;
DenistyAir_SI = 1.2;
%Density Contrast in kg/m^3
DeltaRho_SI = DenistyAir_SI-DensityLimestone_SI;
%Gravitational constants
G_SI = 6.674e-11;


%This is the formula we want to plot
gz_SI = 4/3*pi*R^3*DeltaRho_SI*G_SI*z./((z.^2+x.^2).^(3/2));
gz_SI_max = 4/3*pi*R^3*DeltaRho_SI*G_SI*1/(z^2);
gz_mGal = gz_SI*100*1000;

fig=figure(1)
plot(x,gz_mGal-gz_mGal(1),'r-','LineWidth',3);hold on

%And for a different depths
z=75;
gz_SI = 4/3*pi*R^3*DeltaRho_SI*G_SI*z./((z.^2+x.^2).^(3/2));
gz_mGal = gz_SI*100*1000;
plot(x,gz_mGal-gz_mGal(1),'b-','LineWidth',3);hold on

z=100;
gz_SI = 4/3*pi*R^3*DeltaRho_SI*G_SI*z./((z.^2+x.^2).^(3/2));
gz_mGal = gz_SI*100*1000;
plot(x,gz_mGal-gz_mGal(1),'g-','LineWidth',3);hold on

legend('Cave at 50 m', 'Cave at 75 m','Cave at 100 m','Location','SouthEast')
xlabel('Distance (m)')
ylabel('g_z anomaly (mGal)')
%Export to a png. (This can be done much better.)
set(findall(fig, '-property', 'FontSize'), 'FontSize', 15, 'fontWeight', 'bold')
print('-dpng','-r300','GravityAnomaly.png')
