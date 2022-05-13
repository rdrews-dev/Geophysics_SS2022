clc
clear all
%% equations 3.37a - 3.37c in Telford

zm1 = 5; %Depth
zm2=8;
zm3=zm1+1;
zm4=zm2+1;
m = 1  %Magnetic Moment
x=-10:0.1:10;
r1 = (x.^2+zm1.^2);
r2 = (x.^2+zm2.^2);
r3 = (x.^2+zm3.^2);
r4 = (x.^2+zm4.^2);

I=40;
F1 = (m./r1.^5).*((3*cosd(I).^2-1).*x.^2-6*x.*zm1*sind(I)*cosd(I)+(3*sind(I).^2-1)*zm1);
F2 = (m./r2.^5).*((3*cosd(I).^2-1).*x.^2-6*x.*zm2*sind(I)*cosd(I)+(3*sind(I).^2-1)*zm2);
F3 = (m./r3.^5).*((3*cosd(I).^2-1).*x.^2-6*x.*zm3*sind(I)*cosd(I)+(3*sind(I).^2-1)*zm3)
F4 = (m./r4.^5).*((3*cosd(I).^2-1).*x.^2-6*x.*zm4*sind(I)*cosd(I)+(3*sind(I).^2-1)*zm4)

Z1 = (m./r1.^5).*((2*zm1.^2-x.^2).*sind(I)-3*x*zm1*cosd(I))
Z2 = (m./r2.^5).*((2*zm2.^2-x.^2).*sind(I)-3*x*zm2*cosd(I))
Z3 = (m./r3.^5).*((2*zm3.^2-x.^2).*sind(I)-3*x*zm3*cosd(I))
Z4 = (m./r4.^5).*((2*zm4.^2-x.^2).*sind(I)-3*x*zm4*cosd(I))

Ftotal1 = F1+F2;
Ftotal2 = F3+F4;

Ztotal1 = Z1+Z2;
Ztotal2 = Z3+Z4;


figure(1)
plot(x,Ftotal1,'b');
hold on
plot(x,Ftotal2,'b--');
yyaxis right;
plot(x,Ftotal2-Ftotal1)

figure(2)
plot(x,Ztotal1);
hold on
plot(x,Ztotal2);

yyaxis right;
plot(x,Ztotal2-Ztotal1)
