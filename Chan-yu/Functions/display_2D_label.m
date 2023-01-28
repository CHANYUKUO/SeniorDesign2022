function display_2D_label(Labeled,Original_img)
%% obtain the x y z range
[x y z]=size(Labeled)
index=[];
for i=1:x
    for j=1:y
        for k=1:z
            if Labeled(i,j,k)>0
               index=[index; i j k];
            end
        end
    end
end
buffer = 10;
z_buffer=2;
x_max=max(index(:,1))+buffer;
x_min=min(index(:,1))-buffer;

y_max=max(index(:,2))+buffer;
y_min=min(index(:,2))-buffer;

z_max=max(index(:,3))+z_buffer;
z_min=min(index(:,3))-z_buffer;

new_labeled = Labeled(x_min:x_max, y_min:y_max,z_min:z_max);
new_Original = Original_img(x_min:x_max, y_min:y_max,z_min:z_max);
[x y z] = size(new_labeled)

%%

%%
uif = uifigure('Name','Plot'); 
uif.Position = [500 500 4*(x_max-x_min)+10 4*(y_max-y_min)];
p = uipanel(uif,'Position',[0 0 4*(x_max-x_min)+10 4*(y_max-y_min)]);
sp = uipanel('Parent',p,'Title','Tissue Indexed','FontSize',12,...
              'Position',[0 40 200 200]);
ax=uiaxes(sp,'Position',[0 0 200 200]);
sp2 = uipanel('Parent',p,'Title','Raw Image','FontSize',12,...
              'Position',[180 40 200 200]);
ax2=uiaxes(sp2,'Position',[0 0 200 200]);
ax.Visible='off';ax2.Visible='off';
sld = uislider(uif,'Value',20, 'Limits', [0,z_max-z_min],'Position',[100 30 200 100], ...
    'ValueChangingFcn',@(sld,event) update_image(new_labeled,new_Original,event.Value,ax,ax2));


%imshow(new_labeled(:,:,uis.Value),[0,5]);
%imshow(new_Original(:,:,uis.Value));
        

end
function update_image(new_labeled,new_Original,initialValues,ax,ax2)
    map=[[0,0,0];[0,0,1];[0,1,0];[1,0,0];[0,1,1];[1,1,0]];
    img1=ind2rgb(new_labeled(:,:,round(initialValues)),map);
    imshow(img1,'parent',ax);
    img2=ind2rgb(new_Original(:,:,round(initialValues)),gray(256));
    imshow(img2,'parent',ax2);
    text('Parent',ax2)

end
