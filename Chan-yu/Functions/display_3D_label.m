function display_3D_label(Labeled,segmentedImage,TID_info)
    userinput = true;
    %pixel_length_ratio=2.0480; %% pixel per mm
    unit = 'mm'
    figure(3)
    while userinput
        map_type = menu('What would you like to color?',TID_info.text_array(1),TID_info.text_array(2),TID_info.text_array(3),TID_info.text_array(4),'quit');
        close 3;
        if map_type==5
            userinput = false;
            disp('Thank you! See you soon.');
            break
        end
        tissue_index =TID_info.index_array(map_type);
        legend_text = TID_info.text_array(map_type);
        prompt = {'Enter pixel resolution (pixel/mm)','Slice Thickness (mm)'};
        dlgtitle = 'Voxel Resolution';
        dims = [1 35];
        definput = {'2.0480','0.625'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        pixel_length_ratio = str2double(answer{1});
        Slice_height_per_pixel = str2double(answer{2});
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
            pixel_count=0;
            for i=1:x
                for j=1:y
                    for k=1:z
                        if Labeled(i,j,k)==tissue_index
                            newImage(i,j,k)=1;
                            pixel_count=pixel_count+1;
                        end
                    end
                end
            end
            hiso = patch(isosurface(newImage,0),...
                'FaceColor',[1,1,0],'EdgeColor',[1,1,0]);
            alpha(0.5)
            dim = [.65 .32 .5 .5];
            volume = pixel_count/(pixel_length_ratio)^2*Slice_height_per_pixel;
            annotation('textbox',dim,'String',[legend_text ' size is ' num2str(volume) ' ' unit '^3'],'FitBoxToText','on');
            
        %%
        newImage = zeros(x, y, z);
            %% for blood 
            pixel_count=0;
            for i=1:x
                for j=1:y
                    for k=1:z
                        if Labeled(i,j,k)==TID_info.index_array(3) %% this is blood 
                            newImage(i,j,k)=1;
                            pixel_count=pixel_count+1;
                        end
                    end
                end
            end
            hiso = patch(isosurface(newImage,0),...
                'FaceColor',[1,0,0],'EdgeColor','none');
            alpha(0.5)
            dim = [.65 .32 .5 .5];
            legend('Region Of Interest',legend_text,'blood')
    end
end