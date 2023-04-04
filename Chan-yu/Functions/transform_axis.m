function [matrix,min_value,x_cl_return,y_cl_return,z_cl_return,tag_2_transform_back]=transform_axis(matrix,lesion_axis_st,x_value,y_value,z_value,x_cl,y_cl,z_cl)
    if lesion_axis_st=="x-z"
        matrix=permute(matrix,[2 3 1]);
        min_value=x_value;
        tag_2_transform_back="z-x";
        x_cl_return=y_cl;
        y_cl_return=z_cl;
        z_cl_return=x_cl;
    end
    if lesion_axis_st=="y-z"
        matrix=permute(matrix,[1 3 2]);
        min_value=y_value;
        tag_2_transform_back="z-y";
        x_cl_return=x_cl;
        y_cl_return=z_cl;
        z_cl_return=y_cl;
    end
    if lesion_axis_st=="z-z"
        matrix=permute(matrix,[1 2 3]);
        min_value=z_value;
        tag_2_transform_back="z-z";
        x_cl_return=x_cl;
        y_cl_return=y_cl;
        z_cl_return=z_cl;
    end
    if lesion_axis_st=="z-x"
        matrix=permute(matrix,[3 1 2]);
        min_value=0;
        tag_2_transform_back="";
        x_cl_return=x_cl;
        y_cl_return=y_cl;
        z_cl_return=z_cl;
    end
    if lesion_axis_st=="z-y"
        matrix=permute(matrix,[1 3 2]);
        min_value=0;
        tag_2_transform_back="";
        x_cl_return=x_cl;
        y_cl_return=y_cl;
        z_cl_return=z_cl;
    end
end