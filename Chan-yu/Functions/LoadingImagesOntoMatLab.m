function [rawImage,segmentedImage,info] = LoadingImagesOntoMatLab(data_type)
    functionFolder = pwd;
    
    switch data_type
        case 1
            %Load CT Images Stored as 2D Slices
            rawImageDir = uigetdir;
            cd(rawImageDir); %%(Retrieves 2D dicom image set. Selection must be of a folder, so make sure to keep dicom images within a known folder) 
            files = dir('*.dcm'); %%(Isolates 2D dicom slices within the folder that are part of the set and have the extension .dcm) 
            info = dicominfo(files(1,1).name); %%(Extracts releveant info of the image onto a MATLAB structure array. Only the first slice is used because the general info is the same throughout)
            for l = 1:numel(files) %%(For loop that parses through the different slices of the dicom image)
                img = dicomread(files(l,1).name); %%(Loads 2D image slice onto a MATLAB structure array)
                img = info.RescaleSlope.*img + info.RescaleIntercept; %%(Converts image data to Hounsfield Units)
                Image(:,:,l) = img; %%(Combines the different slices to create one 3D dicom image)
            end
            rawImage = double(Image); %%(Converts matrix values from symbolic values to double precision so they can undergo basic calculations)
        case 2 
            %Load CT Images Stored as a Volume
            [baseName, folder] = uigetfile('*.dcm');
            fullFileName = fullfile(folder, baseName)
            Image = dicomread(fullFileName); %%(Loads 3D dicom image onto MATLAB)

            info = dicominfo(fullFileName); %%(Extract releveant info of the image onto a MATLAB structure array with the variable name info)
            
           rawImage = double(Image); %%(Converts matrix values from symbolic values to double precision so they can undergo basic calculations)
    end



    %% Load NIfTI File
    cd(functionFolder)
    [baseName, folder] = uigetfile('*.nii');
    fullFileName = fullfile(folder, baseName);
    Image = niftiread(fullFileName); %%(Loads the NIfTI image onto MATLAB)
    vessel = zeros(size(Image,1),size(Image,2),size(Image,3));
    for k = 1:size(Image,3) %%For loop switches the x cord. and y cord. and also flips around the y axis to account for coordinate differences in MATLAB and ITK-SNAP  
        for j = 1:size(Image,2)
            vessel(j,:,k) = Image(:,size(Image,2)-(j-1),size(Image,3)-(k-1));
        end
    end
    segmentedImage = vessel; %%Loads the reconfigured image onto thye original image variable
    cd(functionFolder)
end