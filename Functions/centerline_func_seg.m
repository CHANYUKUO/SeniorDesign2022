function [x,y,z,skel] = ...
    centerline_func_seg(segmentedImage)
%% Load your vessel image

% Store home folder
home = pwd;

% Import the segmented vessel
Image = segmentedImage;

%% Additional step: elongate the vessel 
% (only use when centerline extraction algorithm failed 
% at the end of vessel)

% add additional slices at the end of the vessel to improve the result of
% centerline extraction
elongated_slice_number=3;
Image=double(Image);
Image_2=[];
for i=1:(size(Image,3)+elongated_slice_number)
    if i<1+elongated_slice_number
        Image_2(:,:,i)=Image(:,:,1);
    else
        Image_2(:,:,i)=Image(:,:,i-elongated_slice_number);
    end
end
Image=Image_2;
clear Image_2

%% centerline extraction

% Convert of uint16 image into a binary image 
% True if Image contain 1. 
Image_binary=Image==1; 

% Extract boundaries for image display
[vx,vy,vz] = ind2sub(size(Image_binary),find(Image_binary(:,:,:)));
% Image_binary = Image_binary(xbound,ybound,zbound);

% centerline extraction
skel = Skeleton3D(Image_binary);
[xTemp,yTemp,zTemp]=ind2sub(size(skel),find(skel(:)));

% view the centerline output    
figure();
% xlim(xbound);
% ylim(ybound);
% zlim(zbound);
col=[.7 .7 .8];
hiso = patch(isosurface(Image_binary,0),...
    'FaceColor',col,'EdgeColor','none');
%hiso2 = patch(isocaps(Image_binary,0),'FaceColor',col,'EdgeColor','none');
axis equal;axis off;
lighting phong;
isonormals(Image_binary,hiso);
alpha(0.5);
set(gca,'DataAspectRatio',[1 1 1])
camlight;
hold on;
plot3(...
    yTemp,xTemp,zTemp,...
    'square','Markersize',4,'MarkerFaceColor','k','Color','k');
set(gcf,'Color','white');
view(140,80)
title('Original output');
x = xTemp;
y = yTemp;
z = zTemp;
end