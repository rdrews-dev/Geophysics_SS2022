clear all
close all
clc
%%
%unfiltert
X=xlsread('messergebnisse.xlsx',6,'A:A');
Y=xlsread('messergebnisse',6,'B:B');
Z=xlsread('messergebnisse',6,'C:C');

X(isnan(X))=[];
Y(isnan(Y))=[];
Z(isnan(Z))=[];

[x,y]=meshgrid(0:1:20);

G=griddata(X,Y,Z,x,y,'nearest');
figure();
contourf(x,y,G,'ShowText','on')
hold on
plot(X,Y,'k.')
title('Gradienten Feld ungefiltert')
xlabel('Entfernung in x-Richtung')
ylabel('Entfernung in y-Richtung')
colorbar

%%
%gefiltert
X=xlsread('messergebnisse.xlsx',5,'A:A');
Y=xlsread('messergebnisse',5,'B:B');
Z=xlsread('messergebnisse',5,'C:C');

X(isnan(X))=[];
Y(isnan(Y))=[];
Z(isnan(Z))=[];

[x,y]=meshgrid(0:1:20);

G=griddata(X,Y,Z,x,y,'nearest');
figure();
contourf(x,y,G,'ShowText','on')
hold on
plot(X,Y,'k.')
title('Gradienten Feld gefiltert')
xlabel('Entfernung in x-Richtung')
ylabel('Entfernung in y-Richtung')
colorbar
