%yz-plane display on scroll
interval=0.5; % 1 second change display
plane=menu('Which plane would you like to see','xy','xz','yz')
sz=size(rawImage_transformation);
colors=["r","g","b","c","m","y","k"];
labels=[];

%determine set number of iterations
if plane==3
    iterations=sz(1);
end
if plane==2
    iterations=sz(2);
end
if plane==1
    iterations=sz(3);   
end

iterNum=0;
time=second(datetime());
f1=figure;
figure(f1);
while (iterNum<iterations)
if second(datetime())-time >interval
    clf;
    time=second(datetime());
     if plane==3
         slice=reshape(rawImage_transformation(1,:,:),sz(2),sz(3));
         %quiver(y_width,z_width,0,0,"r");
     end
     if plane==2
         slice=reshape(rawImage_transformation(:,1,:),sz(1),sz(3));
     end
     if plane==1
         slice=reshape(rawImage_transformation(:,:,1),sz(1),sz(2));
     end
     
     scatter(transformation*([i;j;k]-[x(1); y(1); z(1)]));
     %labeledImage=labelImage(slice) %%NEED TO FIGURE THIS OUT
     %for i=1:size(labels)
     %labeledI=labeledImage==1;
     %[xTemp,yTemp]=ind2sub(size(labeledI),find(labeledI(:,:,:)));
     %scatter(xTemp,yTemp,c(i));
     end
end
end


