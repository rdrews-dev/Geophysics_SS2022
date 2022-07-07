
 
% %%
% %Einlesen der Datei mit den Werten
% Z = xlsread('messergebnisse.xlsx','A28:U48');
% X= [0:20];
% Y=[0:20];
% 
% % [X,Y,Z]=peaks(100);
% % contour(X,Y,Z);
% % figure;
% % contourf(X,Y,Z,50);
% % colorbar;
% 
% figure(1)
% contourf(Z)
% contourf(X,Y,Z,100)
% figure(2)
% [X,Y]=meshgrid(X,Y);
% 
% subplot(2,2,1);
% mesh(X,Y,Z);
% xlim([0 15])
% ylim([0 15])
% 
% subplot(2,2,2);
% contourf(X,Y,Z,30)
% 
% % xlabel('x'); ylabel('y'); zlabel('z')
clear all
close all
clc
%%

%ungefiltert
X=xlsread('messergebnisse.xlsx',3,'A:A');
Y=xlsread('messergebnisse.xlsx',3,'B:B');
Z=xlsread('messergebnisse.xlsx',3,'C:C');

X(isnan(X))=[];
Y(isnan(Y))=[];
Z(isnan(Z))=[];

[x,y]=meshgrid(0:1:20);

G=griddata(X,Y,Z,x,y,'nearest');
figure()
contourf(x,y,G,'ShowText','on')
hold on
plot(X,Y,'k.')
title('Total Feld ungefiltert')
xlabel('Entfernung in x-Richtung')
ylabel('Entfernung in y-Richtung')
colorbar
%%
%gefiltert
X=xlsread('messergebnisse.xlsx',2,'A:A');
Y=xlsread('messergebnisse.xlsx',2,'B:B');
Z=xlsread('messergebnisse.xlsx',2,'C:C');

X(isnan(X))=[];
Y(isnan(Y))=[];
Z(isnan(Z))=[];

[x,y]=meshgrid(0:1:20);

G=griddata(X,Y,Z,x,y,'nearest');
figure();
contourf(x,y,G,'ShowText','on')
hold on
plot(X,Y,'k.')
title('Total Feld gefiltert')
xlabel('Entfernung in x-Richtung')
ylabel('Entfernung in y-Richtung')
colorbar
