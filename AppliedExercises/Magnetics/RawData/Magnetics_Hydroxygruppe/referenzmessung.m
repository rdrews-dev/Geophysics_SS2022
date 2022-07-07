clear all
close all
clc

%%
%Referenz
X=xlsread('messergebnisse.xlsx',1,'AJ:AJ');
Y=xlsread('messergebnisse.xlsx',1,'AK:AK');



plot_1 = figure();  
plot(X,Y,'-x'); 
hold on;
datetick('x','HH:MM') 
ylim([48287 48313])

title('Referenzfeldmessung') 
xlabel('Uhrzeit') 
ylabel('mag Feldstärke [nT]') 
