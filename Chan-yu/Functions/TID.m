function [Labeled,total_tissue_type] = TID(rawImage,segmented_image)
    %% Modified from 2022 
    %% Step1: Threshold Values
    MAX=max(max(max(rawImage)));
    total_tissue_type=5;% amount of tissue we classify
        vessel_high=625
        vessel_low=277
        % Labeling blood =4
        blood_high=990; 
        blood_low=626;
        % Labeling vessel = 3
        % Muscle = 2
        muscle_high=60;
        muscle_low=0;
        % fat = 1
        fat_high=0;
        fat_low=-100;
        %Labeling Lesion = 5
        calcified_high=MAX;
        calcified_low=990;
     % Design: sliding bars 3D visualization (If possible) 
%% Step 2: Label image based on segmented_image
    [x y z]=size(segmented_image);
    Labeled=zeros(x, y, z);
    for i=1:x
        for j=1:y
            for k=1:z
                if segmented_image(i,j,k)==1
                    if rawImage(i,j,k)>=fat_low && rawImage(i,j,k)<=fat_high
                       Labeled(i,j,k)=1;
                    elseif rawImage(i,j,k)>=muscle_low && rawImage(i,j,k)<=muscle_high
                       Labeled(i,j,k)=2;
                    elseif rawImage(i,j,k)>=blood_low && rawImage(i,j,k)<=blood_high
                       Labeled(i,j,k)=3;
                    elseif rawImage(i,j,k)>=calcified_low && rawImage(i,j,k)<=calcified_high
                       Labeled(i,j,k)=4;
                    elseif rawImage(i,j,k)>=vessel_low && rawImage(i,j,k)<=vessel_high
                       Labeled(i,j,k)=5;
                    else
                       Labeled(i,j,k)=0; 
                    end    
                end
            end
        end
    end
end