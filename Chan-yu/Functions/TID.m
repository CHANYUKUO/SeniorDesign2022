function [labeled_ROI,TID_info] = TID(raw_image,segmented_ROI,segmented_vessel)
    %% Modified from 2022 
    %% Step1: Threshold Values
    fat_high=-71;
    fat_low=-148;
    fat_index=1;
    muscle_high=100;
    muscle_low=-70;
    muscle_index=2;
    blood_high=800;
    blood_low=194;
    blood_index=3;
    MAX=max(max(max(raw_image)));
    calcium_high=MAX;
    calcium_low=900;
    calcium_index=4;


    TID_info.high_array=[fat_high muscle_high blood_high calcium_high];
    TID_info.low_array=[fat_low muscle_low blood_low calcium_low];
    TID_info.index_array=[fat_index muscle_index blood_index calcium_index];
    TID_info.text_array=["fat" "muscle" "blood" "calcium"];
    
     % Design: sliding bars 3D visualization (If possible) 
%% Step 2: Label image based on segmented_ROI
    [x y z]=size(segmented_ROI);
    labeled_ROI=zeros(x, y, z);
    for i=1:x
        for j=1:y
            for k=1:z
                %default blood index for vessel
                continue_check=false;
                if segmented_vessel(i,j,k)==1
                    labeled_ROI(i,j,k)=blood_index;
                    continue_check=true;
                end
                %relabel for ROI 
                if segmented_ROI(i,j,k)==1
                    for array_index=1:size(TID_info.high_array,2)
                        if raw_image(i,j,k)>=TID_info.low_array(array_index) && raw_image(i,j,k)<=TID_info.high_array(array_index)
                           labeled_ROI(i,j,k)=TID_info.index_array(array_index);
                           continue_check=true;
                        end 
                    end
                    if continue_check
                        continue
                    end
                    labeled_ROI(i,j,k)=0;    
                end
            end
        end
    end
end