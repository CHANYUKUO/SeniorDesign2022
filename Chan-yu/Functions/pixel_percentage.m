function [graph]=pixel_percentage(relative_coordinate_matrix,xy_relative_coordinate,rcmatrix_x_centerpoint,rcmatrix_y_centerpoint,total_tissue_type)
  for tissue_index=0:1
    for coordinate_index=1:length(xy_relative_coordinate)
        graph=zeros(size(relative_coordinate_matrix(:,:,1)));
        count=0;
        x_coordinate=xy_relative_coordinate(coordinate_index,1)+rcmatrix_x_centerpoint;
        y_coordinate=xy_relative_coordinate(coordinate_index,2)+rcmatrix_y_centerpoint;
        TID_array=[]
        for index=1:size(relative_coordinate_matrix,3)
            TID_array=[TID_array;relative_coordinate_matrix(x_coordinate,y_coordinate,index)];
        end
        for array_index=1:length(TID_array)
            if TID_array(array_index)==tissue_index
                count=count+1;
            end
        end
        percentage=count/length(TID_array)*100;
        graph(x_coordinate,y_coordinate)=percentage;
    end
  end
end