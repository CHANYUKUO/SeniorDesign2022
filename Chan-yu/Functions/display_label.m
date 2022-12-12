function display_label(Labeled,segmentedImage,map_type)
%% Segmented Image Section
    figure
    col=[.7 .7 .8];
    hiso = patch(isosurface(segmentedImage,0),...
        'FaceColor',col,'EdgeColor','none');
    axis equal;axis off;
    lighting phong;
    set(gca,'DataAspectRatio',[1 1 1])
    camlight;
    alpha(0.1)
    hold on;
%% Plot labeled
    [x y z]=size(segmentedImage);
    newImage = zeros(x, y, z);
    switch map_type
        case 1
            tissue_index =1;
            title('fat');
        case 2
            tissue_index = 2;
            title('muscle');
        case 3
            tissue_index =3;
            title('adventitia');
        case 4
            tissue_index =4;
            title('aorta');
        case 5
            tissue_index =5;
            title('calcium');
    end
    %% step 
    for i=1:x
        for j=1:y
            for k=1:z
                if Labeled(i,j,k)==tissue_index
                    newImage(i,j,k)=1;
                end
            end
        end
    end
    hiso = patch(isosurface(newImage,0),...
        'FaceColor',[1,0,0],'EdgeColor','none');
    alpha(0.5)

end