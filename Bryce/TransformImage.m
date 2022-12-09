function [transformed_Image]=TransformImage(myImage,x,y,z,x_width,y_width, z_width)
    center_coord=[x(1) y(1) z(1)];
    n=2;
    %x_width=max(x_width,int32(sqrt((x(size(x,1))-x(1))^2+(y(size(y,1))-y(1))^2+(z(size(z,1))-z(1))^2)));
    %y_width=50;
    %z_width=50;

    epsilon=x_width/2;
    %t=x; % parametric equations
    %xyz_of_t=[polyfit(t,x,n);polyfit(t,y,n);polyfit(y,z,n)]; % polyfit based off of parametric equations
  
    t_at_center_coord=[0;0;0];%p_inv(xyz_of_t)*center_coord;
    x_vector=[x(size(x,1)); y(size(y,1)); z(size(z,1))]-[x(1); y(1); z(1)];%xyz_of_t*(t_at_center_coord+epsilon)-xyz_of_t*(t_at_center_coord-epsilon);
    x_vector=x_vector/norm(x_vector);
    y_vector=[1;1;-(x_vector(1,1)+x_vector(2,1))/x_vector(3,1)];
    y_vector=y_vector/norm(y_vector);
    z_vector=cross(x_vector,y_vector);
    z_vector=z_vector/norm(z_vector);
    
    % Need to transform old coordinate axis into new coordinate axis
    basis=[x_vector,y_vector,z_vector]; % T*basis=I
    transformation=inv(basis);
    transformed_myImage=zeros(2*x_width+1,2*y_width+1,2*z_width+1);% NOT SURE WHAT SIZE TO MAKE THIS
    
    for i=1:size(myImage,1)
        for j=1:size(myImage,2)
            for k=1:size(myImage,3)
                new_coords=int32(transformation*([i;j;k]-[x(1); y(1); z(1)]));
                new_coords=new_coords+int32([0;y_width;z_width]);
                if new_coords<=[2*x_width+1;2*y_width+1;2*z_width+1] & new_coords>=[1;1;1]
                    transformed_myImage(new_coords(1), new_coords(2), new_coords(3))=myImage(i,j,k);
                end
            end
        end
        if(mod(i,50)==0)
            display(100*i/size(myImage,1)+" % done")
        end
    end
        
    
myImage_binary=transformed_myImage==1;
figure();
% xlim(xbound);
% ylim(ybound);
% zlim(zbound);
col=[.7 .7 .8];
hiso = patch(isosurface(myImage_binary,0),...
    'FaceColor',col,'EdgeColor','none');
%hiso2 = patch(isocaps(myImage_binary,0),'FaceColor',col,'EdgeColor','none');
axis equal;axis off;
lighting phong;
isonormals(myImage_binary,hiso);
alpha(0.5);
set(gca,'DataAspectRatio',[1 1 1])
camlight;
hold on;
quiver3(x_width,y_width,z_width,0,x_width,0,"r");
quiver3(x_width,y_width,z_width,0,0,z_width,"g");
quiver3(x_width,y_width,z_width,0,0,-z_width,"g");
quiver3(x_width,y_width,z_width,y_width,0,0,"b");
quiver3(x_width,y_width,z_width,-y_width,0,0,"b");
set(gcf,'Color','white');
view(140,80)
title('Centerline and SegmentationNII');
transformed_Image=transformed_myImage;

