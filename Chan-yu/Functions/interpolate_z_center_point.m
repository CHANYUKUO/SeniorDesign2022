function [interpolated_x,interpolated_y,interpolated_z]=interpolate_z_center_point(x,y,z)
   %% interpolate if centerline have centerpoints missing in one or two slices
    interpolated_x=[];interpolated_y=[];interpolated_z=[];
    for index=1:length(z)-1
        delta_x=x(index+1)-x(index);
        delta_y=y(index+1)-y(index);
        delta_z=z(index+1)-z(index);
        interpolated_z(end+1)=z(index);
        interpolated_x(end+1)=x(index);
        interpolated_y(end+1)=y(index);
        for interpolation_index=1:delta_z-1 
            interpolated_z(end+1)=z(index)+interpolation_index;
            interpolated_x(end+1)=x(index)+delta_x/delta_z*interpolation_index;
            interpolated_y(end+1)=x(index)+delta_y/delta_z*interpolation_index;
        end
    end
    interpolated_z(end+1)=z(end);
    interpolated_x(end+1)=x(end);
    interpolated_y(end+1)=y(end);
end