function Labeled = TID(rawImage,segmentedImage)
    %Determining Segmentation Domain
    index=[];
    [x y z]=size(segmentedImage);
    for i=1:x
        for j=1:y
            for k=1:z
                if segmentedImage(i,j,k)>0
                   index=[index; i j k];
                end
            end
        end
    end
    
    x_max=max(index(:,1));
    x_min=min(index(:,1));
    
    y_max=max(index(:,2));
    y_min=min(index(:,2));
    
    z_max=max(index(:,3));
    z_min=min(index(:,3));
    %% Step 5: Automatic Segmentation
    b=5; %buffer
    Vessel1=rawImage(x_min-b:x_max+b,...
                   y_min-b:y_max+b,...
                   z_min-b:z_max+b);
    %% Step 6: Threshold Values
    MAX=max(max(max(Vessel1)));
    
    % Thresholds need to be changed
    % Describing Tissue Bounds    
        aorta_high=985; 
        aorta_low=650;
        
        adventitia_high=600; 
        adventitia_low=277;
        
        muscle_high=10;
        muscle_low=-70;
        
        fat_high=-71;
        fat_low=-148;
        
        calcified_high=MAX;
        calcified_low=1000;  
    %% Step 7: Relabeling Process
    % Run-Time should be short
    
    [x y z]=size(Vessel1);
    Labeled=Vessel1; % This is so we don't lose the data from Vessel1
    
    for i=1:x
        for j=1:y
            for k=1:z
                % Labeling Adipose Tissue = 1
                if Labeled(i,j,k)>=fat_low && Labeled(i,j,k)<=fat_high
                   Labeled(i,j,k)=1;
                % Labeling Muscle Tissue = 2
                elseif Labeled(i,j,k)>=muscle_low && Labeled(i,j,k)<=muscle_high
                   Labeled(i,j,k)=2;
                % Labeling Adventitia = 3
                elseif Labeled(i,j,k)>=adventitia_low && Labeled(i,j,k)<=adventitia_high
                   Labeled(i,j,k)=3;
                % Labeling Aorta = 4
                elseif Labeled(i,j,k)>=aorta_low && Labeled(i,j,k)<=aorta_high
                   Labeled(i,j,k)=4;
                % Labeling Lesion = 5
                elseif Labeled(i,j,k)>=calcified_low && Labeled(i,j,k)<=calcified_high
                   Labeled(i,j,k)=5;
                % Labeling Outside VOI/Background = 0
                else
                   Labeled(i,j,k)=0; 
                end    
            end
        end
    end
end