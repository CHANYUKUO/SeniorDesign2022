clear

%% Importing Functions
addpath(pwd);
addpath("Functions/")% Function Created by Senior Design
addpath("Functions/Skeleton3D/"); % Function Required For centerline_func_seg

%% Loading Images (Step1: Modified from 2020Sean)
[rawImage,segmentedVessel,info] = LoadingImagesOntoMatLab(menu('What is the Structure of the Data?','2D Volume','3D Volume')); 
% allow user to choose either volume data. 
%% centerline_func_seg (Step2: Modified from 2019centerline_func_seg,xyz is the center line coordinate)
[x,y,z,skel] = centerline_func_seg(segmentedVessel);
%% Defining TID (Step2: Modified from 2020Danielle)
Labeled = TID(rawImage,segmentedVessel);

%% display Labeled (Step3: Visually Display the Segmented data and where specific label located)
display_label(Labeled,segmentedVessel,menu('What would you like to color?','1','2'))
%% Calculating TID percentage (Step4: 2019DirectCopyFunction 2020VanessaSameCode)
DataTable=distribution(Labeled)

