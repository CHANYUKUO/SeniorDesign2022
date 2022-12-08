%function transformed_Image= Transform_Image(Image,x,y,z,center_coord,n=2,x_width,y_width, z_width)
    % create a couple of test cases
    x=[1 2 3 4 5];
    y=[2 4 6 8 10];
    z=[1 4 9 16 25];
    center_coord=[100;100;100];
    n=2;
    x_width=50;
    y_width=50;
    z_width=50;

    epsilon=0.5;
    t=x; % parametric equations
    xyz_of_t=[polyfit(t,x,n);polyfit(t,y,n);polyfit(y,z,n)]; % polyfit based off of parametric equations
  
    t_at_center_coord=[0;0;0];%p_inv(xyz_of_t)*center_coord;
    x_vector=xyz_of_t*(t_at_center_coord+epsilon)-xyz_of_t*(t_at_center_coord-epsilon);
    x_vector=x_vector/norm(x_vector);
    y_vector=[1;1;-(x_vector(1,1)+x_vector(2,1))/x_vector(3,1)];
    y_vector=y_vector/norm(y_vector);
    z_vector=cross(x_vector,y_vector);
    z_vector=z_vector/norm(z_vector);
    
    % Need to transform old coordinate axis into new coordinate axis
    basis=[x_vector, y_vector, z_vector]; % T*basis=I
    transformation=inv(basis);
    transformed_Image=zeros(x_width,y_width,z_width); % NOT SURE WHAT SIZE TO MAKE THIS
    count=0;
    othercount=0;
    for i=1:size(Image,1)
        for j=1:size(Image,2)
            for k=1:size(Image,3)
                new_coordinates=int32(transformation*([i;j;k]-center_coord));
                %print(new_coordinates)
                if(new_coordinates(1)>0 && new_coordinates(1)<=x_width && new_coordinates(2)>0 && new_coordinates(2)<=y_width && new_coordinates(3)>0 && new_coordinates(3)<=z_width)
                    %display(new_coordinates)
                    count=count+1;
                    %if(Image(i,j,k)~=0)
                    transformed_Image(new_coordinates(1),new_coordinates(2), new_coordinates(3))=Image(i,j,k);
                        %display(Image(i,j,k))
                    othercount=othercount+1;
                    %end
                end
            end
        end
        %display(i/size(Image,1))
    end
    
% create 3-D test matrix
x_arr=zeros(size(Image,1)*size(Image,2)*size(Image,3),1);
y_arr=zeros(size(Image,1)*size(Image,2)*size(Image,3),1);
z_arr=zeros(size(Image,1)*size(Image,2)*size(Image,3),1);
c_arr=zeros(size(Image,1)*size(Image,2)*size(Image,3),1);

count=1;
for i=1:size(Image,1)
        for j=1:size(Image,2)
            for k=1:size(Image,3)
                
                x_arr(count)=i;
                y_arr(count)=j;
                z_arr(count)=k;
                c_arr(count)=int32((Image2(i,j,k)+2100)/100);
                count=count+1;
                if(c_arr(count-1)<=0)
                    display(c_arr(count))
                end
            end
        end
        %display(i/size(Image,1))
    end

