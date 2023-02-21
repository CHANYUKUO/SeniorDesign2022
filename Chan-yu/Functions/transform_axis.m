function [matrix,min_value,tag_2_transform_back]=transform_axis(matrix,lesion_axis_st,x_value,y_value,z_value)
    if lesion_axis_st=="x-z"
        matrix=permute(matrix,[2 3 1]);
        min_value=x_value;
        tag_2_transform_back="z-x";
    end
    if lesion_axis_st=="y-z"
        matrix=permute(matrix,[1 3 2]);
        min_value=y_value;
        tag_2_transform_back="z-y";
    end
    if lesion_axis_st=="z-z"
        matrix=permute(matrix,[1 2 3]);
        min_value=z_value;
        tag_2_transform_back="z-z";
    end
    if lesion_axis_st=="z-x"
        matrix=permute(matrix,[3 1 2]);
        min_value=0;
        tag_2_transform_back="";
    end
    if lesion_axis_st=="z-y"
        matrix=permute(matrix,[1 3 2]);
        min_value=0;
        tag_2_transform_back="";
    end
end