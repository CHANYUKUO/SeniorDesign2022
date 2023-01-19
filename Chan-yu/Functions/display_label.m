function display_label(Labeled,segmentedImage)
    userinput = true;
    figure(3)
    while userinput
        map_type = menu('What would you like to color?','fat','muscle','vessel wall','blood','calcium','quit');
        close 3;
        switch map_type
            case 1
                tissue_index =1;
                legend_text = 'fat';
            case 2
                tissue_index = 2;
                legend_text = 'muscle';
            case 3
                tissue_index =3;
                legend_text = 'vessel';
            case 4
                tissue_index =4;
                legend_text = 'blood';
            case 5
                tissue_index =5;
                legend_text = 'calcium';
            case 6
                userinput = false;
                disp('Thank you! See you soon.');
                break
        end
 %% Segmented Image Section
    figure(3);
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
        legend('Region Of Interest',legend_text)
    end
end