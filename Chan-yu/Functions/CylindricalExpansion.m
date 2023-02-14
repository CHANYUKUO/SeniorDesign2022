function [cylindrical_Mask]=CylindricalExpansion(myImage,x,y,z,r_max)
cylindricalMask=zeros(size(myImage));
width=1;
for i=1:size(x,1)-1
    vector=[x(i+1) y(i+1) z(i+1)]-[x(i) y(i) z(i)];
    step_size=min(1/vector(1), min(1/vector(2),1/vector(3)));
    t_max=(x(i+1)-x(i))/vector(1);
    t=0;
    X=zeros([size(myImage,1)*size(myImage,2)+1 1]);
    Y=zeros([size(myImage,1)*size(myImage,2)+1 1]);
    currMask=zeros(size(myImage));
    while t<t_max
        coord=[vector(1)*t+x(i) vector(2)*t+y(i) vector(3)*t+z(i)];
        for ii=int32(max(1,coord(1)-r_max)):int32(min(size(myImage,1),coord(1)+r_max))

            ii_actual=int32(min(max(1,ii),size(myImage,1)));
            kk=int32(min(max(1,coord(3)),size(myImage,3)));
            cylindricalMask(ii_actual,max(1,int32(coord(2)-abs(sqrt(double(r_max^2-(ii-coord(1))^2))))):int32(min(coord(2)+abs(sqrt(double(r_max^2-(ii-coord(1))^2))),size(myImage,2))),kk)=1;
        end
        
        t=t+abs(step_size);
        
    end
    display(100*i/size(x,1)+" % done");
end
    
    
%end
cylindrical_Mask=cylindricalMask;
end



