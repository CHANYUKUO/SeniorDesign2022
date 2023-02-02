clear

%% Importing Functions
addpath(pwd);
addpath("Functions/")% Function Created by Senior Design
addpath("Functions/Skeleton3D/"); % Function Required For centerline_func_seg

%% Loading Images (Step1: Modified from 2020Sean)
[rawImage,segmentedVessel,info] = LoadingImagesOntoMatLab(menu('What is the Structure of the Data?','2D Volume','3D Volume')); 
% allow user to choose either volume data. 
% data loaded compare to itk-snap: x-> y; y-> x; 
%% flipping only for All ITKsnap Segmentation results (Optional Step)
segmentedVessel=segmented_vessel_flipped(segmentedVessel); 

%% centerline_func_seg (Step2: Modified from 2019centerline_func_seg,xyz is the center line coordinate)
[x,y,z,skel] = centerline_func_seg(segmentedVessel);

%% (Bryce: Step3: Expansion from Vessel of interest to Region of interest)
segmentedVessel_Expansion=CylindricalExpansion(rawImage,x,y,z,10); %% input xyz of center line and expand by 10 (p
%% Defining TID (Step4: Modified from 2020Danielle)
Labeled = TID(rawImage,segmentedVessel_Expansion);
%% display Labeled (Step5: Visually Display the Segmented data and where specific label located)
display_3D_label(Labeled,segmentedVessel_Expansion);
%% display_2D_label(Labeled,Original_img)
display_2D_label(Labeled,rawImage);
%% Calculating TID percentage (Step6: 2019DirectCopy Function 2020VanessaSameCode)
DataTable=distribution(Labeled);



