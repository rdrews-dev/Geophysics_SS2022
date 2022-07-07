clear all 
close all
clc

%importing the date with corrections on the edge bordering the construction
%objects
X = xlsread('total_field_corr.xlsx', 'A:A');
Y = xlsread('total_field_corr.xlsx', 'B:B');
Z = xlsread('total_field_corr.xlsx', 'C:C');
R = xlsread('total_field_corr.xlsx', 'D:D');

%eliminating the empty values in the vectors
Z(isnan(Z)) = [];
X(isnan(X)) = [];
Y(isnan(Y)) = [];
R(isnan(R)) = [];

%subtracting the reference from the total field measurements
V = Z - R;

[xq,yq] = meshgrid(0:1:20);

%plotting the data
Vq = griddata(X,Y,V,xq,yq,'nearest');
contourf(xq,yq,Vq,'ShowText','on')
hold on
plot(X,Y,'k.')
title('Corrected total field [nT]')
xlabel ('Distance in x-direction [m]')
ylabel ('Distance in y-direction [m]')
colorbar



