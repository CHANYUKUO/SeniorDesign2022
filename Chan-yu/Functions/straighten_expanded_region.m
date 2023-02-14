
function [relative_coordinate_matrix,xy_relative_coordinate,interpolated_x_centerpoint,interpolated_y_centerpoint]=straighten_expanded_region(segmentedVessel_Expansion,Labeled_expansion,lesion_start,lesion_end,z_min)
    lesion_start_256=lesion_start+z_min;lesion_end_256=lesion_end+z_min;
    if lesion_start<lesion_end
       lesion_segmented_image=segmentedVessel_Expansion(:,:,lesion_start_256:lesion_end_256);
    else
       lesion_segmented_image=segmentedVessel_Expansion(:,:,lesion_end_256:lesion_start_256);
    end
    [not_interpolated_x_centerpoint,not_interpolated_y_centerpoint,not_interpolated_z_centerpoint,skel]=centerline_func_seg(lesion_segmented_image,'centerline of selected lesion region');
    %[interpolated_x_centerpoint,interpolated_y_centerpoint,interpolated_z_centerpoint]=interpolate_z_center_point(not_interpolated_x_centerpoint,not_interpolated_y_centerpoint,not_interpolated_z_centerpoint);
    % no need to interpolate
    
    %find a reference plane
    interpolated_x_centerpoint=not_interpolated_x_centerpoint;interpolated_y_centerpoint=not_interpolated_y_centerpoint;interpolated_z_centerpoint=not_interpolated_z_centerpoint;
    
    lesion_start_slice = lesion_segmented_image(:,:,interpolated_z_centerpoint(1)); %% get the bottom slice of lesion interested
    %obtain each pixel relative x,y compare to centerline z
    [x_range,y_range,z_range] = size(lesion_segmented_image);
    xy_relative_coordinate=[];
    for x_index = 1:x_range
       for y_index=1:y_range
            if lesion_start_slice(x_index,y_index)==1
                x_relative_coordinates=x_index-interpolated_x_centerpoint(1);
                y_relative_coordinates=y_index-interpolated_y_centerpoint(1);
                xy_relative_coordinate=[xy_relative_coordinate;x_relative_coordinates y_relative_coordinates];
            end
       end
    end
    %xy_relative_coordinate
    %imshow(squeeze(lesion_segmented_image(:,:,1)));
   % xy_relative_coordinate is the relative coordinate compare to centerpoint that we will be using for the remainder of the test
   %% find each x_y_coordinate across z slice
   relative_coordinate_matrix=zeros(size(lesion_segmented_image));
   for index=1:size(xy_relative_coordinate,1)
       first_sliced_absolute_coordinate=[xy_relative_coordinate(index,1)+interpolated_x_centerpoint(1) xy_relative_coordinate(index,2)+interpolated_y_centerpoint(1)];
       for z_index=1:interpolated_z_centerpoint(end)-interpolated_z_centerpoint(1)
           % find the centerpoint at z_index
           % compute the absolute x,y coordinate
           x_coordinate=xy_relative_coordinate(index,1)+interpolated_x_centerpoint(z_index); % convert back to absolute coordinate
           y_coordinate=xy_relative_coordinate(index,2)+interpolated_y_centerpoint(z_index);
           % find the index 
           TID=Labeled_expansion(x_coordinate,y_coordinate,z_index+interpolated_z_centerpoint(1)+z_min);
           relative_coordinate_matrix(first_sliced_absolute_coordinate(1),first_sliced_absolute_coordinate(2),z_index+interpolated_z_centerpoint(1));
       end
   end
%relative_coordinate_matrix=lesion_segmented_image;

   %% drawing 
   [x y z]=size(relative_coordinate_matrix);
   newImage = zeros(x, y, z);
    pixel_count=0;
    for i=1:x
        for j=1:y
            for k=1:z
                if relative_coordinate_matrix(i,j,k)>0
                    newImage(i,j,k)=1;
                    pixel_count=pixel_count+1;
                end
            end
        end
    end
    figure(5);
    col=[.7 .7 .8];
    hiso = patch(isosurface(newImage,0),...
        'FaceColor',col,'EdgeColor','none');
    axis equal;axis off;
    lighting phong;
    set(gca,'DataAspectRatio',[1 1 1])
    camlight;
    alpha(0.5)
   % can't use negative to index ,
   % back to absolute coordinate of the first slice
   % relative_coordinate should have a straight cylinder 3d matrix 
end