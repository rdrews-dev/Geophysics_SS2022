clear all; close all;
%% There is sometimes an unexplained multiple which bounces twice in lower layer. 
%% Not sure how to predict that, geometry is a bit awkward

lw=2;
PlotSolutions = 1;
if PlotSolutions==1
    Outputfile = '../../../Exercises/All/Figures/Seismics/ShotGatherSolution.pdf';
    Outputfile2 = '../../../Exercises/All/Figures/Seismics/TsqXsq.pdf'
else 
    Outputfile = '../../../Exercises/All/Figures/Seismics/ShotGather.pdf';
end


addpath(genpath('/Users/rdrews/Nextcloud/esd_teach/geophyscis_BSc_SoSe21/src/crewes/'))
nx=600;dx=2;nz=600; %basic geometry
x=(0:nx-1)*dx;z=(0:nz-1)*dx;
v1=700;v2=1000;v3=1200;%velocities
d1 = 80; d2 = 250; d3=z(end)-d1-d2;

xc = 2*d1/sqrt(v2^2/v1^2-1);


vrms2 = sqrt((v1^2*d1/v1+v2^2*d2/v2)/(d1/v1+d2/v2));
vav2 = (d1*v1+d2*v2)/(d1+d2);
vav3 = (d1*v1+d2*v2+d3*v3)/(d1+d2+d3);
vrms3 = sqrt((v1^2*d1/v1+v2^2*d2/v2+v3^2*d3/v3)/(d1/v1+d2/v2+d3/v3));
[~,id1]=min(abs(z-d1));[~,id2]=min(abs(z-(d1+d2)));[~,id3]=min(abs(z-(d1+d2+d3)));

vmodel=v3*ones(nx,nz);
vmodel(1:id1,:)=v1;
vmodel(id1:id2,:)=v2;
vmodel(id2:end,:)=v3;

dtstep=.0001;%time step
dt=.004;tmax=1;%time sample rate and max time
xrec=x(1:10:end);%receiver locations
zrec=zeros(size(xrec));%receivers at zero depth
snap1=zeros(size(vmodel));
snap2=snap1;
snap2(1,1)=1;%place the source
[seismogram4,seis4,t]=afd_shotrec(dx,dtstep,dt,tmax, ...
vmodel,snap1,snap2,xrec,zrec,[5 10 30 40]*2.1,0,2);


figure(1)
imagesc(x,z,vmodel)

ExludeFirst=3;
h=figure(2)
hyp1 = 2/v1*sqrt(d1^2+(x./2).^2);hyp1m = 4/v1*sqrt(d1^2+(x./4).^2);hyp1m2 = 8/v1*sqrt(d1^2+(x./8).^2);
hyp2 = 2/vav2*sqrt((d1+d2)^2+(x./2).^2);hyp2m = 4/vav2*sqrt((d1+d2)^2+(x./4).^2)
hyp3 = 2/vav3*sqrt((d1+d2+d3)^2+(x./2).^2);
plotseis(seismogram4(:,ExludeFirst:end),t(1:end),xrec(ExludeFirst:end),1,15);
%plotseis(seis4(:,ExludeFirst:end),t(1:end),xrec(ExludeFirst:end),1,10);
if PlotSolutions==1
    hold on
    plot(x,1/v1*x,'m-','linewidth',lw);
    plot(x,1/v2*x+2*d1*sqrt(v2^2-v1^2)/(v1*v2),'m-','linewidth',lw)
    plot(x,hyp1,'g-','linewidth',lw)
    plot(x,hyp1m,'r-','linewidth',lw)
    plot(x,hyp2m,'r-','linewidth',lw)
    %plot(x,hyp1m2,'r-')
    plot(x,hyp2,'g','linewidth',lw)
    plot(x,hyp3,'g','linewidth',lw)
    xline(xc,'b--','linewidth',lw)
end
xlabel('Position along geophone line (m)')
ylabel('Traveltime (s)')
xlim([0, 800])
grid on;
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,Outputfile,'-dpdf','-r0')
    

%% Velocity Analysis
%% ------------------------------------------------------------------------
xh1 = [0 78 120 180 220 260 300];
th1=  [0.228 0.254 0.2857 0.332 0.376 0.423 0.485];
xh2 = [0 60 200 260 380 ];
th2=  [0.711 0.714 0.743 0.765 0.832 ];
h=figure(11)
plot(xh1.^2,th1.^2,'rx')
hold on;
plot(xh2.^2,th2.^2,'bx')
coeffs = polyfit(xh1.^2,th1.^2,1);coeffs2 = polyfit(xh2.^2,th2.^2,1);
plot(xh1.^2,polyval(coeffs,xh1.^2),'r--');
plot(xh2.^2,polyval(coeffs2,xh2.^2),'b--');xlabel('x^2 (m^2)'); ylabel('t^2 (s^2)')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,Outputfile2,'-dpdf','-r0')


v1rms_estimated = sqrt(1/coeffs(1));
v2rms_estimated = sqrt(1/coeffs2(1));
DeltatNMO = th1(3)-th1(1);DeltatNMO2 = th2(3)-th2(1);

v2Dix = sqrt(1/th2(1)*(v2rms_estimated^2*(th1(1)+th2(2))- v1rms_estimated^2*th1(1))    ); ...


vNMO = sqrt(xh1(3)^2/(2*DeltatNMO*th1(1)));vNMO2 = sqrt(xh2(3)^2/(2*DeltatNMO2*th2(1)));
display(['Interval velocity for reflector 1 is: ',num2str(v1)])
display(['(RMS) Velocity for reflector 1 from x^2-t^2 method is: ',num2str(sqrt(1/coeffs(1)))])
display(['NMO Velocity for reflector 1 is: ',num2str(vNMO)])
display(['Interval velocity for reflector 2 is: ',num2str(v2)])
display(['RMS velocity for reflector 2 from x^2-t^2 method is: ',num2str(v2rms_estimated)])
display(['NMO velocity for reflector 2 is: ',num2str(vNMO)])
display(['Dix velocity for reflector 2 is:',num2str(v2Dix)])
display(['True Depth 1:',num2str(d1)])
display(['Estimated Depth 1:',num2str(v1rms_estimated*th1(1)/2)])
display(['True Depth 2:',num2str(d2)])
display(['Estimated Depth 2:',num2str(v2rms_estimated*th2(1)/2)])



