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
segmentedVessel_Expansion=CylindricalExpansion(segmentedVessel,x,y,z,10); %% input xyz of center line and expand by 10 (p
%% Defining TID (Step4: Modified from 2020Danielle)
[Labeled_expansion,total_tissue_type] = TID(rawImage,segmentedVessel_Expansion);
[Labeled_vessel,total_tissue_type] = TID(rawImage,segmentedVessel);
%% display Labeled (Step5: Visually Display the Segmented data and where specific label located)
%display_3D_label(Labeled_vessel,segmentedVessel);
display_3D_label(Labeled_expansion,segmentedVessel_Expansion);
%% display_2D_label(Labeled,Original_img), only register z as the start and end 
%display_2D_label(Labeled_vessel,rawImage);
[lesion_start,lesion_end,z_min]=display_2D_label(Labeled_expansion,rawImage);
%% Here is the lesion starting and end points
lesion_start.Value 
lesion_end.Value
%% Assuming only across z_slices ((currently using segmentedVessel))
[relative_coordinate_matrix,xy_relative_coordinate,interpolated_x_centerpoint,interpolated_y_centerpoint]=straighten_expanded_region(segmentedVessel,Labeled_vessel,round(lesion_start.Value),round(lesion_end.Value),z_min);
%% calculate the % of tissue at the same x,y,z location
[graph]=pixel_percentage(relative_coordinate_matrix,xy_relative_coordinate,interpolated_x_centerpoint(1,1),interpolated_y_centerpoint(1,2),total_tissue_type);
%% Calculating TID percentage (Step6: 2019DirectCopy Function 2020VanessaSameCode)
DataTable=distribution(Labeled);



