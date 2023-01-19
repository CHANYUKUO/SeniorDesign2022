%yz-plane display on scroll
interval=1; % 1 second change display
plane=menu('Which plane would you like to see','xy','xz','yz')
sz=size(rawImage_transformation)
%if plane==3
%iterations=sz(3)
%if(
%if second(datetime())-time > 1
 if plane==3
     slice=reshape(rawImage_transformation(1,:,:),sz(2),sz(3)))
     %quiver(y_width,z_width,0,0,"r");
 end
 if plane==2
     slice=reshape(rawImage_transformation(:,1,:),sz(1),sz(3)))
 end
 if plane==1
     slice=reshape(rawImage_transformation(:,:,1),sz(1),sz(2)))
 end
 
 newImage= slice>500;
 [xTemp,yTemp]=ind2sub(size(newImage),find(newImage(:,:,:)));
 scatter(xTemp,yTemp);
%end


