function [lesion_st]=straighten_expanded_region(segmentedVessel_Expansion, ...
    Labeled_expansion,lesion_start,lesion_end,lesion_axis_st,x_min,y_min,z_min,x_cl,y_cl,z_cl)
    %% cut the image from start to end based on z_slice
    [Labeled_expansion,z_min,x_cl,y_cl,z_cl,tag_2_transform_back]=transform_axis(Labeled_expansion,lesion_axis_st,x_min,y_min,z_min,x_cl,y_cl,z_cl);
    [segmentedVessel_Expansion,~,~,~,~,~]=transform_axis(segmentedVessel_Expansion,lesion_axis_st,x_min,y_min,z_min,x_cl,y_cl,z_cl);
    lesion_start_256=lesion_start+z_min;
    lesion_end_256=lesion_end+z_min;
    if lesion_start<lesion_end
       lesion_segmented_image=segmentedVessel_Expansion(:,:,lesion_start_256:lesion_end_256);
       lesion_labeled=Labeled_expansion(:,:,lesion_start_256:lesion_end_256);
       [x_centerpoint,y_centerpoint,z_centerpoint] = centerline_AlongOneAxis(lesion_segmented_image); % here is the code to be replaced by the following
       size(x_centerpoint)
       %{ 
          Note: This line of code save time for centerline_func_seg, but
          might be buggy
       if find(z_cl==lesion_end_256,1)>find(z_cl==lesion_start_256,1)
           start_cl_index = find(z_cl==lesion_start_256,1);% assume along at z axis
           end_cl_index = find(z_cl==lesion_end_256,1);
       else
           end_cl_index = find(z_cl==lesion_start_256,1);% assume along at z axis
           start_cl_index= find(z_cl==lesion_end_256,1);
       end
       x_centerpoint=x_cl(start_cl_index:end_cl_index);
       y_centerpoint=y_cl(start_cl_index:end_cl_index);
       z_centerpoint=z_cl(start_cl_index:end_cl_index)-lesion_start_256+1;
       %}
    else
       lesion_segmented_image=segmentedVessel_Expansion(:,:,lesion_end_256:lesion_start_256);
       lesion_labeled=Labeled_expansion(:,:,lesion_end_256:lesion_start_256);
       [x_centerpoint,y_centerpoint,z_centerpoint,~] = centerline_AlongOneAxis(lesion_segmented_image); % here is the code to be replaced by the following
       %{
       if find(z_cl==lesion_end_256,1)>find(z_cl==lesion_start_256,1)
           start_cl_index = find(z_cl==lesion_start_256,1);% assume along at z axis
           end_cl_index = find(z_cl==lesion_end_256,1);
       else
           end_cl_index = find(z_cl==lesion_start_256,1);% assume along at z axis
           start_cl_index= find(z_cl==lesion_end_256,1);
       end
       x_centerpoint=x_cl(start_cl_index:end_cl_index);
       y_centerpoint=y_cl(start_cl_index:end_cl_index);
       z_centerpoint=z_cl(start_cl_index:end_cl_index)-lesion_end_256+1;
       %}
    end
    %% 
    %[lesion_start,lesion_end,z_min]=display_2D_label(lesion_labeled,rawImage)
    [x_centerpoint,y_centerpoint,z_centerpoint]=remove_redundant(x_centerpoint,y_centerpoint,z_centerpoint);
    range=size(x_centerpoint,1);
    ref_index=round(range/2);
    lesion_start_slice = lesion_segmented_image(:,:,ref_index);
    [x_range,y_range,z_range] = size(lesion_segmented_image);
    x_relative_coordinates=[];
    y_relative_coordinates=[];
    for x_index = 1:x_range
       for y_index=1:y_range
            if lesion_start_slice(x_index,y_index)>=1 % 
                x_relative_coordinates=[x_relative_coordinates; x_index-x_centerpoint(ref_index)];
                y_relative_coordinates=[y_relative_coordinates; y_index-y_centerpoint(ref_index)];
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
                    visual_lesion_st(x_relative_coordinates(index)+x_centerpoint(ref_index),y_relative_coordinates(index)+y_centerpoint(ref_index),z_centerpoint(c_index))=5;
                else
                    visual_lesion_st(x_relative_coordinates(index)+x_centerpoint(ref_index),y_relative_coordinates(index)+y_centerpoint(ref_index),z_centerpoint(c_index))=lesion_labeled(x_relative_coordinates(index)+x_centerpoint(c_index),y_relative_coordinates(index)+y_centerpoint(c_index),z_centerpoint(c_index));
                end
                lesion_st(x_relative_coordinates(index)+x_centerpoint(ref_index),y_relative_coordinates(index)+y_centerpoint(ref_index),z_centerpoint(c_index))=lesion_labeled(x_relative_coordinates(index)+x_centerpoint(c_index),y_relative_coordinates(index)+y_centerpoint(c_index),z_centerpoint(c_index));
            end
    end

%imshow(lesion_st);
visual_lesion_st=reformating(visual_lesion_st);
lesion_st=reformating(lesion_st);
%[visual_lesion_st,~,~,~,~,~]=transform_axis(visual_lesion_st,tag_2_transform_back,x_min,y_min,z_min,x_cl,y_cl,z_cl);
%[straightend_transformed_back_lesion,~,~,~,~,~]=transform_axis(lesion_st,tag_2_transform_back,x_min,y_min,z_min,x_cl,y_cl,z_cl);
size(visual_lesion_st)
[~,~,~]=display_2D_label(visual_lesion_st,zeros(size(visual_lesion_st)),'lesion');

%straightend_transformed_back_reformat_lesion=reformating(straightend_transformed_back_lesion);
%size(straightend_transformed_back_reformat_lesion)
end


function [x_centerpoint_rm,y_centerpoint_rm,z_centerpoint_rm]=remove_redundant(x_centerpoint,y_centerpoint,z_centerpoint)
    [v, w] = unique( z_centerpoint, 'stable' );
    size(x_centerpoint)
    duplicate_indices = setdiff( 1:numel(z_centerpoint), w );
    x_centerpoint_rm=x_centerpoint;y_centerpoint_rm=y_centerpoint;z_centerpoint_rm=z_centerpoint;
    x_centerpoint_rm(duplicate_indices)=[];y_centerpoint_rm(duplicate_indices)=[];z_centerpoint_rm(duplicate_indices)=[];
    
end
function new_labeled=reformating(Labeled)
%% obtain the x y z range
    [x y z]=size(Labeled);
    index=[];
    for i=1:x
        for j=1:y
            for k=1:z
                if Labeled(i,j,k)>0
                   index=[index; i j k];
                end
            end
        end
    end
    x_max=max(index(:,1));
    x_min=min(index(:,1));
    y_max=max(index(:,2));
    y_min=min(index(:,2));
    z_min=min(index(:,3));
    z_max=max(index(:,3));
% to ensure we have 20*20 dimension
% assuming we are going along z-axis
    x_sub_max=floor((x_max+x_min)/2)+10;
    x_sub_min=floor((x_max+x_min)/2)-10;
    y_sub_max=floor((y_max+y_min)/2)+10;
    y_sub_min=floor((y_max+y_min)/2)-10;

    
    new_labeled = Labeled(x_sub_min:x_sub_max, y_sub_min:y_sub_max,z_min:z_max);
end

