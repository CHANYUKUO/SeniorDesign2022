function [cylindrical_Mask]=BruteForceCylindrical(myImage,x,y,z,r_max)
%deg=360;
%cyclindricalCoordinates=zeros([r_max,deg,size(x,1)])\
mask=zeros(size(myImage));
for i=1:size(myImage,1)
    for j=1:size(myImage,2)
        for k=1:size(myImage,2)
            corr=[0 0 0];
            best_r=r_max+1;
            
            for ii=1:size(x,1)-1
                
                vector=[x(ii+1) y(ii+1) z(ii+1)]-[x(ii) y(ii) z(ii)];
                step_size=min(1/vector(1), min(1/vector(2),1/vector(3)));
                t_max=(x(ii+1)-x(ii))/vector(1);
                t=0;
                while t<t_max
                    coord=[vector(1)*t+x(ii) vector(2)*t+y(ii) vector(3)*t+z(ii)];
                    %display([i j k]);
                    %display(coord);
                    p_v1=[i j k]-coord;
                    if pdist([[i j k];coord])<=r_max & dot(p_vl,vector)==0 
                        mask(i,j,k)=1;
                        break
                    end
                    t=t+abs(step_size);
                end
            end
        end
        display(100*i+j)/size(myImage)
    end
    display(100*i/size(myImage)+"% finished");
end
                


cylindrical_Mask=mask;
end




%1 is region of interest--radially outward