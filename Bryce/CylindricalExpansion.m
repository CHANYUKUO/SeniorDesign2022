function [cylindrical_Mask]=CylindricalExpansion(myImage,x,y,z,r_max)
cylindricalMask=zeros(size(myImage));
width=1;
% TID labeling reads 0 through 1--labels only if it has a 1
%n=3;
%t=zeros(size(x))+1:size(x,1);
%xyz_of_t=[polyfit(t,x,n);polyfit(t,y,n);polyfit(y,z,n)];
%xyz_of_t_prime=[polyder(xyz_of_t(1));polyder(xyz_of_t(2));polyder(xyz_of_t(3))];

%okat to cut through

%0.4 mm


 %for ii=max(x(i)-r_max,1):min(x(i)+r_max,size(myImage,1))
         %   for jj=max(y(i)-r_max,1):min(y(i)+r_max,size(myImage,2))
          %     minz=max(0,(-width-vector(1)*(x-x(i))-vector(2)*(y-y(i)))/vector(3)+y(i));
           %    maxz=min((width-vector(1)*(x-x(i))-vector(2)*(y-y(i)))/vector(3)+y(i),size(myImage,3));
            %       for kk=max(minz,1):min(maxz,size(myImage,2))
             %       if pdist2 ([x(i) y(i) z(i)] ,[ii jj kk],'euclidean')<=r_max
                        %display([ii jj kk])
                        %abs(vector(1)*(ii-x(i))+ vector(2)*(jj-y(i))+vector(3)*(kk-z(i)))<=width &&
                        
              %      end
               %     end
            %end
        %end
    %end
    %x_vector=[x(i+1) y(i+1) z(i+1)]-[x(i) y(i) z(i)];
    %x_vector=x_vector/norm(x_vector);
    %y_vector=[1;1;-(x_vector(1,1)+x_vector(2,1))/x_vector(3,1)];
    %y_vector=y_vector/norm(y_vector);
    %z_vector=cross(x_vector,y_vector);
    %z_vector=z_vector/norm(z_vector);
    
%for i=1:size(x,1)-1

% consider how big is a voxel--0.4 mm is xy; z slice 0.6mm

% # of voxels is 

%width=% difference between centerline points

% max(min(y,1)-r_max,1):min(max(y,1)+r_max, max(size(myImage,2)))
for i=1:size(x,1)-1
    vector=[x(i+1) y(i+1) z(i+1)]-[x(i) y(i) z(i)];
    %display(vector)
    step_size=min(1/vector(1), min(1/vector(2),1/vector(3)));
    t_max=(x(i+1)-x(i))/vector(1);
    t=0;
    X=zeros([size(myImage,1)*size(myImage,2)+1 1]);
    Y=zeros([size(myImage,1)*size(myImage,2)+1 1]);
    currMask=zeros(size(myImage));
    while t<t_max
        coord=[vector(1)*t+x(i) vector(2)*t+y(i) vector(3)*t+z(i)];
        for ii=int32(max(1,coord(1)-r_max)):int32(min(size(myImage,1),coord(1)+r_max))
            
            %display(ii)
            %display(int32(max(1,coord(2)-sqrt(r_max^2-(ii-coord(1))^2))))
            %display(int32(min(coord(2)+sqrt(double(r_max^2-(ii-coord(1))^2),size(myImage,2))))
            %display(coord(3))
            ii_actual=int32(min(max(1,ii),size(myImage,1)));
            kk=int32(min(max(1,coord(3)),size(myImage,3)));
            
            %display(int32(coord(2)-sqrt(double(r_max^2-(ii-coord(1))^2))));
            cylindricalMask(ii_actual,max(1,int32(coord(2)-abs(sqrt(double(r_max^2-(ii-coord(1))^2))))):int32(min(coord(2)+abs(sqrt(double(r_max^2-(ii-coord(1))^2))),size(myImage,2))),kk)=1;
        end
        
        t=t+abs(step_size);
        
    end
    %cylindricalMask(x(i)-5:x(i)+5, y(i)-5:y(i)+5,z(i))=1;
    %imshow(reshape(cylindricalMask(:,:,z(i)),[512,512]))
    %pause(1)
    display(100*i/size(x,1)+" % done");
end
    
    
%end
cylindrical_Mask=cylindricalMask;
end




%1 is region of interest--radially outward