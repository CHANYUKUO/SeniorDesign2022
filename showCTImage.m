function  showCTImage(img,time)
%SHOWCTIMAGE output the CT images. The two input arguments:
%img: the CT image name that client wants to display
%time: the time between two slices

slices = size(img);
slices = slices(3);

for i = 1:slices
    imshow(img(:,:,i));
    pause(time);
    hold off;
end

