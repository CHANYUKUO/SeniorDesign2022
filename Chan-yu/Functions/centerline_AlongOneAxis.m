function [x_cl,y_cl,z_cl] = ...
    centerline_AlongOneAxis(segmentedImage)
[x_size,y_size,z_size]=size(segmentedImage);
x_cl=[];
y_cl=[];
z_cl=[];
    for z_index = 1:z_size
        minx=1000; % value holder
        maxx=0; % value holder
        miny=1000; % value holder
        maxy=0; % value holder
        for y_index= 1:y_size
            for x_index= 1:x_size
                if segmentedImage(x_index,y_index,z_index)==1
                    if x_index<minx
                       minx=x_index;
                    end
                    if x_index>maxx
                       maxx=x_index;
                    end
                    if y_index<miny
                       miny=y_index;
                    end
                    if y_index>maxy
                       maxy=y_index;
                    end
                end
            end
        end
        centx = floor((minx + maxx) / 2);
        centy = floor((miny + maxy) / 2);
        x_cl=[x_cl; centx];
        y_cl=[y_cl; centy];
        z_cl=[z_cl;z_index];
    end
end
