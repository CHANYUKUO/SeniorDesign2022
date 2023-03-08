function [start_value,end_value,axis_st]=classify(start_value,end_value,axis_value)
    groups=[0 6 12 18 24 30 36 42 48 266]; % 6 groups, 0-6, 6-12,12-24,24-48,48-96,96+ (z slice won't go over 266)
    if end_value>start_value
        range=end_value-start_value;
        mid_point=round(range/2)+start_value;
    else
        range=start_value-end_value;
        mid_point=range/2+end_value;
    end
    for group_index = 1: length(groups)
        if groups(group_index)<=range & groups(group_index+1)>range
            classified_range=groups(group_index+1)
            start_value=mid_point-classified_range/2;
            end_value=mid_point+classified_range/2;
            if end_value<=0
                % in case when the end_value is lower than 1
                % move start value higher and set end_value to 1
                start_value=start_value+(1-end_value); 
                end_value=1;
            end
            break
        end
    end
   % display axis
    if axis_value==1
       display("Lesion selected along x-axis");
       axis_st="x-z";
    end
    if axis_value==2
       display("Lesion selected along y-axis");
       axis_st="y-z";
    end
    if axis_value==3
       display("Lesion selected along z-axis");
       axis_st="z-z";
    end
end