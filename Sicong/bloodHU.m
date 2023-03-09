clear; clc;
close all;
%% Importing Functions
addpath(pwd);
addpath("Functions/")% Function Created by Senior Design
addpath("Functions/Skeleton3D/"); % Function Required For centerline_func_seg
[rawImage,segmentedVessel,info] = LoadingImagesOntoMatLab(menu('What is the Structure of the Data?','2D Volume','3D Volume')); 

%% Labeling image
%overlapping images
segmentedVessel=segmented_vessel_flipped(segmentedVessel); 
overlappednii = overlapImages(rawImage,segmentedVessel);                   % overlapped nii image is the segmented image projected on the CT
whitePixelsIndex = find(overlappednii ~= 0);                               % find the index of the white pixels
bloodHUval = overlappednii(whitePixelsIndex);                              % get the value of each white pixel (this should give us the HU value of the pixel)





