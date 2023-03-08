function [cylindrical_Mask]=CylindricalExpansion(myImage,x,y,z,r_max)
cylindricalMask=zeros(size(myImage));
width=1;
 
for i=1:size(x,1)-1
    vector=[x(i+1) y(i+1) z(i+1)]-[x(i) y(i) z(i)];
    %display(vector)
    %step_size=min(1/vector(1), min(1/vector(2),1/vector(3)));
    step_size=min(1/abs(vector(1)), min(1/abs(vector(2)),min(1/abs(vector(3)), 0.001)));
    t_max=max((x(i+1)-x(i))/vector(1),max((y(i+1)-y(i))/vector(2),(z(i+1)-z(i))/vector(3))); %0.0001; (x(i+1)-x(i))/vector(1);
    t=0;
    X=zeros([size(myImage,1)*size(myImage,2)+1 1]);
    Y=zeros([size(myImage,1)*size(myImage,2)+1 1]);
    currMask=zeros(size(myImage));
    
    while t<t_max
        coord=[vector(1)*t+x(i) vector(2)*t+y(i) vector(3)*t+z(i)];
        
        %do xy and xz planes
        for ii=int32(max(1,coord(1)-r_max)):int32(min(size(myImage,1),coord(1)+r_max))
            ii_actual=int32(min(max(1,ii),size(myImage,1)));
            kk=int32(min(max(1,coord(3)),size(myImage,3))); % const z position
            
            %do xy plane cross-section
            cylindricalMask(ii_actual,max(1,int32(coord(2)-abs(sqrt(double(r_max^2-(ii-coord(1))^2))))):int32(min(coord(2)+abs(sqrt(double(r_max^2-(ii-coord(1))^2))),size(myImage,2))),kk)=1;
            
            %do xz plane cross-section
            jj=int32(min(max(1,coord(2)),size(myImage,2))); % const y position
            cylindricalMask(ii_actual,jj,max(1,int32(coord(3)-abs(sqrt(double(r_max^2-(ii-coord(1))^2))))):int32(min(coord(3)+abs(sqrt(double(r_max^2-(ii-coord(1))^2))),size(myImage,3))))=1;
        end
        
        %do yz plane
        for jj=int32(max(1,coord(2)-r_max)):int32(min(size(myImage,2),coord(2)+r_max))
            jj_actual=int32(min(max(1,jj),size(myImage,2)));
            ii=int32(min(max(1,coord(1)),size(myImage,1))); %const x position
           
            cylindricalMask(ii,jj_actual,max(1,int32(coord(3)-abs(sqrt(double(r_max^2-(jj-coord(2))^2))))):int32(min(coord(3)+abs(sqrt(double(r_max^2-(jj-coord(2))^2))),size(myImage,3))))=1;
        %end
        
        
        t=t+abs(step_size);
        
    end
    
end
    
    
%end
cylindrical_Mask=cylindricalMask;
end

