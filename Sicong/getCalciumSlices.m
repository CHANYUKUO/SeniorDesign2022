function [calcium_slices] = getCalciumSlices(img)
%GETCALCIUMSLICES return the slices from the labeled overlapped nii images that calcium is detected

z = size(img,3); % z is the depth/height of the image (should be 256)
counter = 1; 
for i = 1:z
    if(any(img(:,:,i) == 5,"all") ) % Calcium is labeled as 5
        calcium_slices(counter) = i;
        counter = counter + 1;
    end
end


   

end

