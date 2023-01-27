function newImage=segmented_vessel_flipped(segmentedImage)
[x y z]=size(segmentedImage);
x
newImage=zeros(x, y, z);
    for i=1:x
        for j=1:y
            for k=1:z
                newImage(i,j,k)=segmentedImage(x-i+1,j,k);
            end
        end
    end
end