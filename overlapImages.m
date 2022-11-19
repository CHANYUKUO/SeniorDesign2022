function [overlapedImage] = overlapImages(CT,nii)
%OVERLAPIMAGES overlaps the nii file and the original CT file. The output
%should be overlap the hounsfield unit get by CT image on the nii pixel=1
%regions (white regions will be given the original Hounsfield unit)

x = 512; % row
y = 512; % column
z = 256; % depth

% for here, the CT and the segmented nii images should have the same
% dimenstion because we cannot achieve the separation of coronary vessel
% from ITK-SNAP, so the nii file should include all the blood flow area
% from aorta to apex.

for i = 1:x
    for j = 1:y
        for k = 1:z
            if(nii(i,j,k) == 1)
                nii(i,j,k) = CT(i,j,k);
            end
        end
    end
end
overlapedImage = nii;

end

