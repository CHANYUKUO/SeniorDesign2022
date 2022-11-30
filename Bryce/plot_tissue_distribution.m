rgb_Labeled=zeros(x,y,z,3) 
%%% test
%display(size(rgb_Labeled))
for i=1:x
    for j=1:y
        for k=1:z
            rgb_Labeled(i,j,k,1)=255*mod(Labeled(i,j,k),2); % RED component 
            rgb_Labeled(i,j,k,2)=255/3*mod(Labeled(i,j,k),3); % GREEN component
            rgb_Labeled(i,j,k,3)=256/5*mod(Labeled(i,j,k),5); % BLUE component
        end
    end
end
    
plane="" % Can change this later to either xy, xz or yz plane
slice=1 % Can change to slice of interest with respect ot z,y, or x component keeping constant
if plane=="xy"
    matrix_plot=reshape(rgb_Labeled(:,:,slice,:),x,y,3);
elseif plane=="xz"
    matrix_plot=reshape(rgb_Labeled(:,slice,:,:),x,z,3);
else
    matrix_plot=reshape(rgb_Labeled(slice,:,:,:),y,z,3);
imshow(matrix_plot)

end
    
    
