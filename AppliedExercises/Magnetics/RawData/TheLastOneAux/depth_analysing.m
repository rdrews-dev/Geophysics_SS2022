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

%using the data surrounding the maxima of the anomalies 
x= (0:1:20);
y= (0:1:12);
[xq,yq]=meshgrid(x,y);

%plotting the data
Vq=griddata(X,Y,Z,xq,yq,'nearest');
surf(xq,yq,Vq)
hold on 
view([0 180])
hold off
title('Corrected vertical gradient')
xlabel('Distance in x-direction [m]')
ylabel('Distance in y-direction [m]')
zlabel('Vertical gradient [nT]')
colorbar 