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
[x,y,z,skel] = centerline_func_seg(segmentedVessel,'centerline of segmented vessel');

%% (Bryce: Step3: Expansion from Vessel of interest to Region of interest)
segmentedVessel_Expansion=CylindricalExpansion(segmentedVessel,x,y,z,10); %% input xyz of center line and expand by 10 radius
%% Defining TID (Step4: Modified from 2020Danielle)
[Labeled_expansion,total_tissue_type] = TID(rawImage,segmentedVessel_Expansion);
[Labeled_vessel,total_tissue_type] = TID(rawImage,segmentedVessel);
%% display Labeled (Step5: Visually Display the Segmented data and where specific label located)
%display_3D_label(Labeled_vessel,segmentedVessel);
display_3D_label(Labeled_expansion,segmentedVessel_Expansion);
%% display_2D_label(Labeled,Original_img), only register z as the start and end 
%display_2D_label(Labeled_vessel,rawImage);
[lesion_start,lesion_end,lesion_axis,x_min,y_min,z_min]=display_2D_label(Labeled_expansion,rawImage,"use size of labeled_vessel");
%% Here is the lesion starting and end points in one of the three axis, 
lesion_start.Value 
lesion_end.Value
lesion_axis.Value
%% classify the starting and end points into 4 categories by z_length
% This section of the code should only run after lesion_start.Value and 
[start_value,end_value,lesion_axis_st]=classify(round(lesion_start.Value) ,round(lesion_end.Value),round(lesion_axis.Value));
%% Assuming only across z_slices ((currently using segmentedVessel))
[lesion_labeled]=straighten_expanded_region(segmentedVessel_Expansion,Labeled_expansion,start_value,end_value,lesion_axis_st,x_min,y_min,z_min);
%% Calculating TID percentage (Step6: 2019DirectCopy Function 2020VanessaSameCode)
%DataTable=distribution(Labeled);



