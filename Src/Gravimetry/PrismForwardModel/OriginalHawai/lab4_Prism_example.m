%---------------------------------------------------------------
% Lab4 example
%----------------------------------------------------------------
clear;

%---------------------------------------------------------------
% Input Parameters.  It is good practice to set all variables
% in the beginning. 
%---------------------------------------------------------------
x=[-20e3:500:20e3];	%x arrays having increments of 500;
m=0.5;              % desired slope of line
b=2;                % desired y intercept

wx=10e3; wy=100e3; wz=0.5e3;  % dimensions of prism

%---------------------------------------------------------------
% An example how to input a parameter during run time.  This
% example, would be useful if you want to add multiple curves
% to the same plot (option 0); or start over from scratch
% to make a new plot (option 1).
%---------------------------------------------------------------
ioverwrite=input('Enter 1 to clear plot, 0 to keep the plot to add to it. >');

figure(20);
if (ioverwrite==1); clf; end;

%---------------------------------------------------------------
% First lets learn out to use a "function".  The function "make_line"
% takes an input "x", slope "m", and intercept "b" and outputs y 
% values for that line.  Functions are useful if you need to do the same
% set of calculations lots of times.  Here is a very simple example.  In practice a 
% a "function" is useful for more complicated calculations that require
% multiple lines of code.  
%---------------------------------------------------------------


y=make_line(x,m,b);	%here's how we use the function

subplot(311);
plot(x/1e3,y/1e3,'b.-'); hold on;
xlabel('Y')
ylabel('X');
axis([x(1) max(x) y(1) max(y)*1.2]/1e3);
title('Example Line Drawing');
grid on;
%---------------------------------------------------------------
% Now lets learn how to read in data from a file, generate vectors
% from the data, and plot the data
%---------------------------------------------------------------

load gravprism_solution.txt;
xsol=gravprism_solution(:,1);  %takes all values of rows in 1st column
gsol=gravprism_solution(:,2);  %takes all values of rows in 2nd column  

plot(xsol/1e3,gsol,'r-');

%---------------------------------------------------------------
% Now lets draw a box
%---------------------------------------------------------------
x1=-wx/2; x2=x1+wx;           % Locations of corners of prism
z1=1e3; z2=z1+wz;

subplot(312);
xbox=[x1 x2 x2 x1 x1]/1e3;
ybox=[z1 z1 z2 z2 z1]/1e3;
plot(xbox,ybox,'k');
set(gca,'YDir','reverse');		%Z is depth so should be plotted down

axis([2*[x1 x2] [-0.1*z2 1.1*z2]]/1e3);
grid on;
xlabel('X-direction (km)')
ylabel('Z-Depth (km)')
title('Vertical Cross-section');


