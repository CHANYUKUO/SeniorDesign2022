
%% Importing Functions
addpath(pwd);
addpath("Functions/")% Function Created by Senior Design
addpath("Functions/Skeleton3D/"); % Function Required For centerline_func_seg
[rawImage,segmentedVessel,info] = LoadingImagesOntoMatLab(menu('What is the Structure of the Data?','2D Volume','3D Volume')); 

%% Labeling image
%overlapping images
overlappednii = overlapImages(rawImage,segmentedVessel);
%showCTImage(newnii,0.5,256);
labeled = labelImage(overlappednii);

%% find region of interest (Pseudofinding, needs more accurate)
calciumslices = getCalciumSlices(labeled);

%% Testing Give color to calcium slices
%colored = colorSlices(overlappednii,[1:256]);
%showColoredImage(colored,0.1,256);

%% getCalciumIndex
calciumindex = getCalciumIndex(overlappednii);