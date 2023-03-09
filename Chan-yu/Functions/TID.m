function [Labeled,total_tissue_type] = TID(rawImage,segmented_image)
    %% Modified from 2022 
    %% Step1: Threshold Values
    MAX=max(max(max(rawImage)));
    total_tissue_type=5;% amount of tissue we classify
    % Thresholds need to be changed
    % Describing Tissue Bounds    
        aorta_high=700;%565; %419 
        aorta_low=194;%302; %344
    %Comments: Fixing the name and range: Blood,
    %Comments: Might have to do each heart individually
        adventitia_high=0; 
        adventitia_low=0;
        
        muscle_high=55; %40
        muscle_low=35; %10
        
        fat_high=-90; %-50
        fat_low=-120; %-100
        
        calcified_high=MAX;
        calcified_low=1000;
     % Design: sliding bars 3D visualization (If possible) 
%% Step 2: Label image based on segmented_image
    [x y z]=size(segmented_image);
    Labeled=zeros(x, y, z);
    for i=1:x
        for j=1:y
            for k=1:z
                if segmented_image(i,j,k)==1
                   % Labeling Adipose Tissue = 1
                    if rawImage(i,j,k)>=fat_low && rawImage(i,j,k)<=fat_high
                       Labeled(i,j,k)=1;
                    % Labeling Muscle Tissue = 2
                    elseif rawImage(i,j,k)>=muscle_low && rawImage(i,j,k)<=muscle_high
                       Labeled(i,j,k)=2;
                    % Labeling Adventitia = 3
                    elseif rawImage(i,j,k)>=adventitia_low && rawImage(i,j,k)<=adventitia_high
                       Labeled(i,j,k)=3;
                    % Labeling Aorta = 4
                    elseif rawImage(i,j,k)>=aorta_low && rawImage(i,j,k)<=aorta_high
                       Labeled(i,j,k)=4;
                    % Labeling Lesion = 5
                    elseif rawImage(i,j,k)>=calcified_low && rawImage(i,j,k)<=calcified_high
                       Labeled(i,j,k)=5;
                    % Labeling Outside VOI/Background = 0
                    else
                       Labeled(i,j,k)=0; 
                    end    
                end
            end
        end
    end
end