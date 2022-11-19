function [Labeled] = labelImage(img)
%LABELIMAGE Label the tissue shown on the image input

MAX=max(max(max(img)));
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

[x,y,z]=size(img);
Labeled=img; % This is so we don't lose the data from Vessel1
 
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
123123123123123123123123123
end