clear all
close all
clc

%importing the whole data of the measurement of the vertical gradient
X=xlsread('gradient','A:A');
Y=xlsread('gradient','B:B');
Z=xlsread('gradient','C:C');

%eliminating the empty values in the vectors
X(isnan(X))=[];
Y(isnan(Y))=[];
Z(isnan(Z))=[];

[xq,yq]=meshgrid(0:1:20);

%plotting the data 
Vq=griddata(X,Y,Z,xq,yq,'nearest');
contourf(xq,yq,Vq,'ShowText','on')
hold on 
plot(X,Y,'k.')
title('Vertical gradient [nT]')
xlabel('Distance in x-direction [m]')
ylabel('Distance in y-direction [m]')
zlabel('Vertical gradient [nT]')
colorbar 