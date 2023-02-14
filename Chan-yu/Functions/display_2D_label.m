function [lesion_start,lesion_end,z_min]=display_2D_label(Labeled,Original_img)
%% obtain the x y z range
    [x y z]=size(Labeled);
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
    x_ui_value=(x_max-x_min);
    y_ui_value=(y_max-y_min);
    uif = uifigure('Name','Plot'); 
    uif.Position = [300 300 6*x_ui_value 7*y_ui_value];
    p = uipanel(uif,'Position',[0 y_ui_value 6*x_ui_value 6*y_ui_value]);
    sp = uipanel('Parent',p,'Title','x-Tissue Indexed','FontSize',12,...
                  'Position',[0 3*y_ui_value 3*x_ui_value 3*y_ui_value]);
    x_ax=uiaxes(sp,'Position',[0 0 3*x_ui_value 3*y_ui_value]);
    sp2 = uipanel('Parent',p,'Title','y-Tissue Indexed','FontSize',12,...
                  'Position',[3*x_ui_value 3*y_ui_value 3*x_ui_value 3*y_ui_value]);
    y_ax=uiaxes(sp2,'Position',[0 0 3*x_ui_value 3*y_ui_value]);
    sp3 = uipanel('Parent',p,'Title','Raw Image','FontSize',12,...
                  'Position',[0 0 3*x_ui_value 3*y_ui_value]);
    r_ax=uiaxes(sp3,'Position',[0 0 3*x_ui_value 3*y_ui_value]);
    sp4 = uipanel('Parent',p,'Title','z-Tissue Indexed','FontSize',12,...
                  'Position',[3*x_ui_value 0 3*x_ui_value 3*y_ui_value]);
    z_ax=uiaxes(sp4,'Position',[0 0 3*x_ui_value 3*y_ui_value]);
    x_ax.Visible='off';y_ax.Visible='off';r_ax.Visible='off';z_ax.Visible='off';
    %sldx = uislider(uif,'Value',20, 'Limits', [0,x_max-x_min],'Position',[100 30 200 100], ...
        %'ValueChangingFcn',@(sld,event) update_image(new_labeled,new_Original,event.Value,ax,ax2));
    x = uigauge('Parent',uif,'Position',[0 0 0 0]);
    y = uigauge('Parent',uif,'Position',[0 0 0 0]);
    z = uigauge('Parent',uif,'Position',[0 0 0 0]);
    lesion_start = uigauge('Parent',uif,'Position',[0 0 0 0]); %% lesion start ui value
    lesion_end = uigauge('Parent',uif,'Position',[0 0 0 0]); %% lesion end ui value
    sldx = uislider(sp,'Value',20, 'Limits', [0,x_max-x_min],'Position',[x_ui_value/2 y_ui_value/2 2*x_ui_value y_ui_value], ...
        'ValueChangingFcn',@(sldx,event) update_image(new_labeled,new_Original,event.Value,x_ax,y_ax,z_ax,r_ax,x,y,z,'x'));
    sldy = uislider(sp2,'Value',20, 'Limits', [0,y_max-y_min],'Position',[x_ui_value/2 y_ui_value/2 2*x_ui_value y_ui_value], ...
        'ValueChangingFcn',@(sldy,event) update_image(new_labeled,new_Original,event.Value,x_ax,y_ax,z_ax,r_ax,x,y,z,'y'));
    sldz = uislider(sp4,'Value',20, 'Limits', [0,z_max-z_min],'Position',[x_ui_value/2 y_ui_value/2 2*x_ui_value y_ui_value], ...
        'ValueChangingFcn',@(sldz,event) update_image(new_labeled,new_Original,event.Value,x_ax,y_ax,z_ax,r_ax,x,y,z,'z'));
    
    btn = uibutton(uif,'Text','Start of Lesion','Position',[0 0 x_ui_value y_ui_value] ...
        ,'ButtonPushedFcn',@(btn,event) start_end_recorder(btn,z,lesion_start)); 

    btn2 = uibutton(uif,'Text','End of Lesion','Position',[2*x_ui_value 0 x_ui_value y_ui_value] ...
        ,'ButtonPushedFcn',@(btn,event) start_end_recorder(btn,z,lesion_end)); 
end
function update_image(new_labeled,new_Original,new_value,x_ax,y_ax,z_ax,r_ax,x,y,z,factor)
    map=[[0,0,0];[0,0,1];[0,1,0];[1,0,0];[0,1,1];[1,1,0]];
    [x_range,y_range,z_range]=size(new_labeled);
    if factor == 'x'
        x.Value=new_value;
        img_x=ind2rgb(squeeze(new_labeled(round(new_value),:,:)),map);
        imshow(img_x,'parent',x_ax)
    end
    if factor == 'y'
        y.Value=new_value;
        % change the new_label
        img_y=ind2rgb(squeeze(new_labeled(:,round(new_value),:)),map);
        imshow(img_y,'parent',y_ax);
    end
    if factor == 'z'
        z.Value=new_value;
        img_z=ind2rgb(squeeze(new_labeled(:,:,round(new_value))),map);
        imshow(img_z,'parent',z_ax);
        img_r=ind2rgb(new_Original(:,:,round(new_value)),gray(256));%% raw image display based on z value
        imshow(img_r,'parent',r_ax);
    end
end
function start_end_recorder(btn,z,holder)
    holder.Value=z.Value;
    display("register z_position for lesion: "+holder.Value);
end
