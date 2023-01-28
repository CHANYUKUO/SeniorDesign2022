clear

%% Importing Functions
addpath(pwd);
addpath("Functions/")% Function Created by Senior Design
addpath("Functions/Skeleton3D/"); % Function Required For centerline_func_seg

%% Loading Images (Step1: Modified from 2020Sean)
[rawImage,segmentedVessel,info] = LoadingImagesOntoMatLab(menu('What is the Structure of the Data?','2D Volume','3D Volume')); 
% allow user to choose either volume data. 
% data loaded compare to itk-snap: x-> y; y-> x; 
%% flipping only for recent 62481_Coronary case (Optional Step)
segmentedVessel=segmented_vessel_flipped(segmentedVessel); 


%% centerline_func_seg (Step2: Modified from 2019centerline_func_seg,xyz is the center line coordinate)
[x,y,z,skel] = centerline_func_seg(segmentedVessel);

% Provide detail description: what information is displayed
%% (Step3: Expansion from Vessel of interest to Region of interest)

%% Defining TID (Step4: Modified from 2020Danielle)
Labeled = TID(rawImage,segmentedVessel);

%% display Labeled (Step5: Visually Display the Segmented data and where specific label located)
display_label(Labeled,segmentedVessel)

%% display_2D_label(Labeled,Original_img)
display_2D_label(Labeled,rawImage)
%% Calculating TID percentage (Step6: 2019DirectCopy Function 2020VanessaSameCode)
DataTable=distribution(Labeled)
%%
%% Waiting for implementation in expansion. Transformation between coordinates
%Transform Image(Step5)
%segmentedVessel_transformation=TransformImage(segmentedVessel,x,y,z,32,50,50);
%rawImage_transformation=TransformImage(rawImage,x,y,z,32,50,50);


