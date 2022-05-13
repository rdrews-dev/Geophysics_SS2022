clear all
close all

data = load('../../../Exercises/Ex4/LonLatXYZ.txt');

x = data(:,3);y=data(:,4);z=data(:,5);


xlin = linspace(min(x), max(x), 100);
ylin = linspace(min(y), max(y), 100);
[X,Y] = meshgrid(xlin, ylin);
Z = griddata(x,y,z,X,Y,'natural');
mesh(X,Y,Z)
axis tight; hold on
plot3(x,y,z,'.','MarkerSize',15)