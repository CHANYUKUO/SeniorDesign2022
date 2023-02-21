function []=straighten_expanded_region(segmentedVessel_Expansion,Labeled_expansion,lesion_start,lesion_end,lesion_axis_st,x_min,y_min,z_min)
    %% cut the image from start to end based on z_slice
    [Labeled_expansion,z_min,tag_2_transform_back]=transform_axis(Labeled_expansion,lesion_axis_st,x_min,y_min,z_min);
    [segmentedVessel_Expansion,~,~]=transform_axis(segmentedVessel_Expansion,lesion_axis_st,x_min,y_min,z_min);
    
    lesion_start_256=lesion_start+z_min;lesion_end_256=lesion_end+z_min;
    if lesion_start<lesion_end
       lesion_segmented_image=segmentedVessel_Expansion(:,:,lesion_start_256:lesion_end_256);
       lesion_labeled=Labeled_expansion(:,:,lesion_start_256:lesion_end_256);
    else
       lesion_segmented_image=segmentedVessel_Expansion(:,:,lesion_end_256:lesion_start_256);
       lesion_labeled=Labeled_expansion(:,:,lesion_start_256:lesion_end_256);
    end
    %% 
    %[lesion_start,lesion_end,z_min]=display_2D_label(lesion_labeled,rawImage)
    [x_centerpoint,y_centerpoint,z_centerpoint,~]=centerline_func_seg(lesion_segmented_image,'centerline of selected lesion region');
    lesion_start_slice = lesion_segmented_image(:,:,z_centerpoint(1));
    [x_range,y_range,z_range] = size(lesion_segmented_image)
    x_relative_coordinates=[];
    y_relative_coordinates=[];
    for x_index = 1:x_range
       for y_index=1:y_range
            if lesion_start_slice(x_index,y_index)>=1 % 
                x_relative_coordinates=[x_relative_coordinates; x_index-x_centerpoint(1)];
                y_relative_coordinates=[y_relative_coordinates; y_index-y_centerpoint(1)];
                %xy_relative_coordinate=[xy_relative_coordinate;x_relative_coordinates y_relative_coordinates];
            end
       end
    end
    %% showing lesion_start_slie for visual pupose
    %imshow(lesion_start_slice);
    lesion_st = zeros(size(lesion_labeled));
    visual_lesion_st=lesion_st;
    for index = 1:length(x_relative_coordinates)% give all first column (or x)
            for c_index = 1:length(z_centerpoint)
                if all([x_relative_coordinates(index)==0,y_relative_coordinates(index)==0])
                    visual_lesion_st(x_relative_coordinates(index)+x_centerpoint(1),y_relative_coordinates(index)+y_centerpoint(1),z_centerpoint(c_index))=6;
                else
                    visual_lesion_st(x_relative_coordinates(index)+x_centerpoint(1),y_relative_coordinates(index)+y_centerpoint(1),z_centerpoint(c_index))=lesion_labeled(x_relative_coordinates(index)+x_centerpoint(c_index),y_relative_coordinates(index)+y_centerpoint(c_index),z_centerpoint(c_index));
                end
                lesion_st(x_relative_coordinates(index)+x_centerpoint(1),y_relative_coordinates(index)+y_centerpoint(1),z_centerpoint(c_index))=lesion_labeled(x_relative_coordinates(index)+x_centerpoint(c_index),y_relative_coordinates(index)+y_centerpoint(c_index),z_centerpoint(c_index));
            end
    end

%imshow(lesion_st);
[lesion_start,lesion_end,z_min]=display_2D_label(visual_lesion_st,zeros(size(lesion_st)),'lesion')
[straightend_transformed_back_lesion,~,~]=transform_axis(lesion_st,tag_2_transform_back,x_min,y_min,z_min);
end


