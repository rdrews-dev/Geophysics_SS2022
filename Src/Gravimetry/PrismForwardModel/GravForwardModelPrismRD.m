clear all;
close all;

%% This code quantifies the gravitational potential of a rectangular
%% Prism located in the sub-surface using an analytical solution of
%% Nagy 1966 (Geophysics)



%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case Numbers
% RectangleCentered: 1 ;
% Two Rectangles: 2;
% Ambiguities: 3
%%%%%%%%%%%%%%%%%%%%%%%%%%
CaseNumber = 3;

switch CaseNumber
    case 1
        display('Calculating centered rectangle.')
        %This is the density contrast
        drho = 400;
        
        % Location and geometry of Prisms.
        % -----------------------------------------------------
        % Width height and depth of the prism.
        wx = 10;wy = 100;wz = 0.5;
        % Offset in depth z and lateral direction x. 
        % The y-dimension is (but doesn not have to)
        % is symetric to the profile direction
        
        offsetz=1;offsetx=0;

        % Sample Points along profile in x-direction.
        % Coordinates are symetric with origin in center.
        % -----------------------------------------------------
        dx=0.5;xp = -20:dx:20;yp = xp*0;zp=xp*0;

        % Coordinates of the prism relative to sample points
        % -----------------------------------------------------
        dx1=fliplr(min(xp)-wx/2:dx:max(xp)-wx/2);dx2=dx1+wx;
        dy1=dx1*0-wy/2;dy2=dy1+wy;
        dz1=dx1*0+offsetz;dz2=dz1+wz;

        % This applies the analysitcal solution of Nagy 1966.
        % -----------------------------------------------------
        dg = gravprism(drho,dx1,dx2,dy1,dy2,dz1,dz2); 
        
        % Here we visualize the results.
        figure()
        subplot(3,1,1)
        plot(xp,dg)
        xlabel('Horizontal Distance x (km)');ylabel('Gravity Anomaly (mGal)');
        subplot(3,1,2)%[x y w h]
        rectangle('Position',[-wx/2,offsetz,wx,wz]);
        set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
        xlim([min(xp),max(xp)]);xlabel('Horizontal Distance x (km)');ylabel('Depth (m)');
        subplot(3,1,3)%[x y w h]
        rectangle('Position',[-wx/2,-wy/2,wx,wy]);
        xlim([min(xp),max(xp)]);xlabel('Horizontal Distance x (km)');ylabel('Horizontal Distance y (km)');
   case 2
        display('Calculating the effect of multiple rectangles.')
        % This is the density contrast
        % -----------------------------------------------------
        drho = [400];
        % Width, height and depth of the two prisms.
        % -----------------------------------------------------
        wx = [10 8];
        wy = [100 100];
        wz = [0.5 0.25];
        
        % Offset in depth z and lateral direction x. 
        % The y-dimension is (but doesn not have to)
        % is symetric to the profile direction
        % -----------------------------------------------------
        offsetz=[1 0.25];offsetx=[-10 12]
        
        % Number of prisms in this example
        % -----------------------------------------------------
        np = length(offsetz);
        
        % Sample Points along profile in x-direction.
        % Coordinates are symetric with origin in center.
        % -----------------------------------------------------
        dx=0.5;xp = -20:dx:20;yp = xp*0;zp=xp*0;

        % Coordinates of the prisms relative to sample points
        % -----------------------------------------------------
        for kk=1:np
            dx1(kk,:)=fliplr(min(xp)-wx(kk)/2:dx:max(xp)-wx(kk)/2)+offsetx(kk);dx2(kk,:)=dx1(kk,:)+wx(kk);
            dy1(kk,:)=dx1(kk,:)*0-wy(kk)/2;dy2(kk,:)=dy1(kk,:)+wy(kk);
            dz1(kk,:)=dx1(kk,:)*0+offsetz(kk);dz2(kk,:)=dz1(kk,:)+wz(kk);
        end
        dg = gravprism(drho,dx1,dx2,dy1,dy2,dz1,dz2); 
        
        % Visualization of the combined effect
        % -----------------------------------------------------
        figure()
        subplot(3,1,1)
        % Here we show the combined effect by summing the effects if individual prisms
        plot(xp,sum(dg,1))
        xlabel('Horizontal Distance x (km)');ylabel('Gravity Anomaly (mGal)');
        subplot(3,1,2)
        hold on;
        for kk=1:np
            rectangle('Position',[-wx(kk)/2+offsetx(kk),offsetz(kk),wx(kk),wz(kk)]);
        end
        set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
        xlim([min(xp),max(xp)]);xlabel('Horizontal Distance x (km)');ylabel('Depth (m)');
        subplot(3,1,3)%[x y w h]
        for kk=1:np
            rectangle('Position',[-wx(kk)/2+offsetx(kk),-wy(kk)/2,wx(kk),wy(kk)]);
        end
        xlim([min(xp),max(xp)]);xlabel('Horizontal Distance x (km)');ylabel('Horizontal Distance y (km)');
   case 3
        display('Showcasing ambiguity.')
        % Those are density contrasts. We now choose two.
        % -----------------------------------------------------
        drho1 = 400;drho2=950;
        % Width, height and depth of the two prisms.
        % -----------------------------------------------------
        wx = [10 8.7];
        wy = [100 100];
        wz = [0.5 0.25];
        %Offset in depth z and lateral direction x. 
        %The y-dimension is (but doesn not have to)
        %is symetric to the profile direction
        offsetz=[1 2];offsetx=[0 0]
        
        % Number of prisms
        % -----------------------------------------------------
        np = length(offsetz);
        
        % Sample Points along profile in x-direction.
        % Coordinates are symetric with origin in center.
        % -----------------------------------------------------
        dx=0.5;xp = -20:dx:20;yp = xp*0;zp=xp*0;

        % Coordinates of prisms relative to sample points
        % -----------------------------------------------------
        for kk=1:np
            dx1(kk,:)=fliplr(min(xp)-wx(kk)/2:dx:max(xp)-wx(kk)/2)+offsetx(kk);dx2(kk,:)=dx1(kk,:)+wx(kk);
            dy1(kk,:)=dx1(kk,:)*0-wy(kk)/2;dy2(kk,:)=dy1(kk,:)+wy(kk);
            dz1(kk,:)=dx1(kk,:)*0+offsetz(kk);dz2(kk,:)=dz1(kk,:)+wz(kk);
        end
        
        % Now calculate the effects with variable densities.
        % For this we calculate all prisms for all densities.
        % It is a bit silly, but it works.
        % -----------------------------------------------------
        dg1 = gravprism(drho1,dx1,dx2,dy1,dy2,dz1,dz2); 
        dg2 = gravprism(drho2,dx1,dx2,dy1,dy2,dz1,dz2);
        
        % Visualization
        % -----------------------------------------------------
        figure()
        subplot(3,1,1)
        hold on;
        plot(xp,dg1(1,:),'r') %This is prism 1 with density 1
        plot(xp,dg2(2,:),'m') %This is prism 2 with density 2
        xlabel('Horizontal Distance x (km)');ylabel('Gravity Anomaly (mGal)');
        subplot(3,1,2)
        hold on;
        plot(xp,0*xp,'b-x')
            kk=1
            rectangle('Position',[-wx(kk)/2+offsetx(kk),offsetz(kk),wx(kk),wz(kk)],'FaceColor','r');
            kk=2
            rectangle('Position',[-wx(kk)/2+offsetx(kk),offsetz(kk),wx(kk),wz(kk)],'FaceColor','m');
        
        
        set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
        xlim([min(xp),max(xp)]);xlabel('Horizontal Distance x (km)');ylabel('Depth (m)');
        subplot(3,1,3)%[x y w h]
        	kk=1;
            rectangle('Position',[-wx(kk)/2+offsetx(kk),-wy(kk)/2,wx(kk),wy(kk)],'FaceColor','r');
            kk=2;
            rectangle('Position',[-wx(kk)/2+offsetx(kk),-wy(kk)/2,wx(kk),wy(kk)],'FaceColor','m');
        xlim([min(xp),max(xp)]);xlabel('Horizontal Distance x (km)');ylabel('Horizontal Distance y (km)');

end
