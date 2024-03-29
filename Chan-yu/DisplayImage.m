myImage_binary=segmentedVessel_transformation==1;

for i=1:size(myImage_binary,1)
    for j=1:size(myImage_binary,2)
        for k=1:size(myImage_binary,3)
        end
    end
end


label=menu('What would you like to color?','1','2','3','4','5');
color=menu("What color would like this to be displayed in?","red","yellow","green","blue")
center_coord=[x(1) y(1) z(1)]';
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
center_coord=transformationMatrix*center_coord;
%quiver3(y_width,0,z_width,0,x_width,0,"r");
%quiver3(y_width,0,z_width,0,0,z_width,"g");
%quiver3(y_width,0,z_width,0,0,-z_width,"g");
%quiver3(y_width,0,z_width,y_width,0,0,"b");
%quiver3(y_width,0,z_width,-y_width,0,0,"b");

newImage= Labeled==label;
[xTemp,yTemp,zTemp]=ind2sub(size(newImage),find(newImage(:,:,:)));

if label==1
    scatter3(xTemp,yTemp,zTemp,"r");
end
if label==2
    scatter3(xTemp,yTemp,zTemp,"y");
end
if label==3
    scatter3(xTemp,yTemp,zTemp,"g");
end
if label==4
    scatter3(xTemp,yTemp,zTemp,"b");
end

set(gcf,'Color','white');
view(140,80)
title('Centerline and SegmentationNII');