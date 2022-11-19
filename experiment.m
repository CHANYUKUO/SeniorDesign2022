%% run Masterscript first to get the CT (rawImage), Nifti (segementedImage)

newnii = overlapImages(rawImage,segmentedImage);
%showCTImage(newnii,0.5,256);
labeled = labelImage(newnii);

%% find region of interest (Pseudofinding, needs more accurate)
calciumslices = getCalciumSlices(labeled);