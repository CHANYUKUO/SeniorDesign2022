clear

%% Importing Functions
addpath(pwd);
addpath("Functions/")% Function Created by Senior Design
addpath("Functions/Skeleton3D/"); % Function Required For centerline_func_seg
%% Step1
   rawImageDir = uigetdir; % load the folder containing 2D dicom CT images
   segmentedImageFile = uigetdir; % load the folder containing segmented .nii files

%% Loading Images (Step1: Modified from 2020Sean)
[rawImage,segmentedImage] = LoadingImagesOntoMatLab(rawImageDir,segmentedImageFile); % load the specific .nii file

%% Defining TID (Step2: Modified from 2020Danielle)
Labeled = TID(rawImage,segmentedImage);

%% Calculating TID percentage (Step3: 2019DirectCopyFunction 2020VanessaSameCode)
DataTable=distribution(Labeled)

%% centerline_func_seg (Step4: Modified from 2019centerline_func_seg,xyz is the center line coordinate)
[x,y,z,skel] = centerline_func_seg(segmentedImage);

%% 
[lin_vessel,err] = ct_linearize(Labeled,[x;y;z],[1,1,1],3,5);