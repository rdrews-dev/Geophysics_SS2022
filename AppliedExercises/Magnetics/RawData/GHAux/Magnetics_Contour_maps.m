clc
close all
clear all

% Overhauser Magnetometer

Z = xlsread('Oberhauser.xlsx','B32:Q52');
X = xlsread('Oberhauser.xlsx','B31:Q31');
Y = xlsread('Oberhauser.xlsx','A32:A52');

% Fluxgate Magnetometer

A = [0:1:20];
B = A;
C = xlsread('Fluxgate.xlsx','B6:V26');

%Oberhauser andere Gruppe

%F = xlsread('Oberhauser andere Gruppe.xlsx','C27:W47');

%Referenzmessungen nach der zeit plotten


Referenz= xlsread('Oberhauser.xlsx','AA6:AA22');
time = xlsread ('Oberhauser.xlsx','Y6:Y22');


% Overhauser Magnetometer Rohdaten

figure(1)
contour(Z)
contour(X,Y,Z,50)
title('Overhauser Magnetometer - Stärke des Gesamtmagnetfeldes [nT]')
xlabel('Kennzahl des Profils [m]')
ylabel('Messpunkt entlang des Profils [m]')
colorbar


% Overhauser andere Gruppe
%figure(2)
%contour(F)
%contour(B,A,F,50)

% Fluxgate Magnetometer Rohdaten
figure(3)
contour(C)
contour(A,B,C,50)
title('Fluxgate Magnetometer - vertikaler Gradient')
xlabel('Kennzahl des Profils [m]')
ylabel('Messpunkt entlang des Profils [m]')
colorbar

%Referenzmessungen über die Zeit
figure(4)
plot(time,Referenz,'-r','LineWidth', 1.5)
hold on 
plot(time,Referenz,'*b','LineWidth', 1.5)
hold off
ylim ([48300 48400])
xlim ([0 153])
title('Referenzmessungen über die Zeit ')
xlabel('Zeit in Minuten seit Beginn der Messung')
ylabel('Messung am Referenzpunkt [nT]')
legend('Linie zur Vergleichbarkeit','Messpunkte')

% Overhauser Magnetometer korrigierte Daten

K = xlsread('Oberhauser 2.0.xlsx','B32:Q52');

% Overhauser Magnetometer korrigierte Daten

figure(5)
contour(K)
contour(X,Y,K,50)
title('Overhauser Magnetometer - Stärke des Magnetfeldes [nT]')
xlabel('Kennzahl des Profils [m]')
ylabel('Messpunkt entlang des Profils [m]')
colorbar

%Profile 6 of Overhauser 
Prof=K(:,6);
zl=zeros(21);
hw=-185*ones(21);
Xhw=[2:10]
figure(7)
plot(A,Prof)
title('Overhauser Magnetometer - Messprofil bei 6 Meter')
xlabel('Messpunkt entlang des Profils [m]')
ylabel('Stärke des Magnetfeldes [nT]')
hold on
plot(A,zl,'k')
hold on
plot(A,hw,'r--')
hold off


% Fluxgate korrigierte Daten

M = xlsread('Fluxgate 2.0.xlsx','B6:V26');

% Fluxgate Magnetometer korrigiert
figure(6)
contour(M)
contour(A,B,M,50)
title('Fluxgate Magnetometer - vertikaler Gradient')
xlabel('Kennzahl des Profils [m]')
ylabel('Messpunkt entlang des Profils [m]')
colorbar

%Profile 6 of Fluxgate, Minimum
figure(8)
subplot(1,2,1)
PFlow=M(:,6);
hwFL=-122*ones(21);
plot(A,PFlow)
title('Fluxgate - Messprofil bei 6 Meter')
xlabel('Messpunkt entlang des Profils [m]')
ylabel('Stärke des Magnetfeldes [nT]')
hold on
plot(A,zl,'k')
hold on
plot(A,hwFL,'r--')
hold off

figure(8)
subplot(1,2,2)
%Profile of Flucgate Maximum at 18 m
PFhi=M(:,18);
hwFH=166.55*ones(21);
plot(A,PFhi)
title('Fluxgate - Messprofil bei 18 Meter')
xlabel('Messpunkt entlang des Profils [m]')
ylabel('Stärke des Magnetfeldes [nT]')
hold on
plot(A,zl,'k')
hold on
plot(A,hwFH,'r--')
hold off

%figure (6)

%[X,Y]=meshgrid(X,Y);


%subplot(2,2,1)
%mesh(X,Y,Z)
%xlim([0 15])
%ylim([0 15])

%subplot(2,2,2)
%contour(X,Y,Z,30)
%xlim([0 15])
%ylim([0 15])


%subplot(2,2,3)
%pcolor(X,Y,Z)
%xlim([0 15])
%ylim([0 15])

%subplot(2,2,4)
%surf(X,Y,Z)
%xlim([0 15])
%ylim([0 15])