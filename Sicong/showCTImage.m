function  showCTImage(img,time,stopslice)
%SHOWCTIMAGE output the CT images. The two input arguments:
%img: the CT image name that client wants to display
%time: the time between two slices
%stopslice: the slice that the image stop showing, max = 256


for i = 1:stopslice
    imshow(img(:,:,i));
    pause(time);
    hold off;
end

