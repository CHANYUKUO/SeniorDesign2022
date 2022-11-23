function display_label(Labeled,segmentedImage,map_type)
    %% Additional step: elongate the vessel 
    % (only use when centerline extraction algorithm failed 
    % at the end of vessel)
    
    % add additional slices at the end of the vessel to improve the result of
    % centerline extraction
    % 
    elongated_slice_number=3;
    segmentedImage=double(segmentedImage);
    Image_2=[];
    for i=1:(size(segmentedImage,3)+elongated_slice_number)
        if i<1+elongated_slice_number
            Image_2(:,:,i)=segmentedImage(:,:,1);
        else
            Image_2(:,:,i)=segmentedImage(:,:,i-elongated_slice_number);
        end
    end
    segmentedImage=Image_2;
    clear Image_2    

%% Segmented Image Section
    Image_binary=segmentedImage==1; 
    %[vx,vy,vz] = ind2sub(size(Image_binary),find(Image_binary(:,:,:)));
    col=[.7 .7 .8];
    hiso = patch(isosurface(Image_binary,0),...
        'FaceColor',col,'EdgeColor','none');
    axis equal;axis off;
    lighting phong;
    isonormals(Image_binary,hiso);
    alpha(0.5);
    set(gca,'DataAspectRatio',[1 1 1])
    camlight;
    hold on;
    
%% Plot labeled

    switch map_type
        case 1
            newImage= Labeled==1;
            [xTemp,yTemp,zTemp]=ind2sub(size(newImage),find(newImage(:,:,:)));
            plot3(...
                xTemp,yTemp,zTemp,...
                'square','Markersize',4,'MarkerFaceColor','k','Color','k');
        case 2
            
    end
end