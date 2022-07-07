close all
clear all
clc

%importing the data of the reference measurements at each beginning of the
%measurements in y-direction

time=xlsread('total_field_reference','C:C');
field=xlsread('total_field_reference','B:B');

%convert timestampts 
date= datetime(time,'convertfrom','posixtime');

%plotting the data
plot(date,field,'o')
hold on
plot(date,field-detrend(field),'-')
%ylim([48250 48400]);
title('Fieldstrength at the reference point over time')
ylabel('Fieldstrength [nT]')
xlabel('Time')
grid on




