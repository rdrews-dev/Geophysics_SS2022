clear all
close all
clc

%importing the date with corrections on the edge bordering the construction
%objects
X=xlsread('gradient_corr','A:A');
Y=xlsread('gradient_corr','B:B');
Z=xlsread('gradient_corr','C:C');

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
title('Corrected vertical gradient [nT]')
xlabel('Distance in x-direction [m]')
ylabel('Distance in y-direction [m]')
zlabel('Vertical gradient [nT]')
colorbar 