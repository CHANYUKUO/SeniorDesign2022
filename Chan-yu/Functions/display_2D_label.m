function [lesion_start,lesion_end,sld_btn,x_min,y_min,z_min]=display_2D_label(Labeled,Original_img,mode)
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
    x_max=max(index(:,1));
    x_min=min(index(:,1));
    y_max=max(index(:,2));
    y_min=min(index(:,2));
    z_min=min(index(:,3));
    z_max=max(index(:,3));    
    new_labeled = Labeled(x_min:x_max, y_min:y_max,z_min:z_max);
    new_Original = Original_img(x_min:x_max, y_min:y_max,z_min:z_max);
    [x y z] = size(new_labeled);
    %%
    map=[[0,0,0];[0,0,1];[0,1,0];[1,0,0];[0,1,1];[1,1,0];[1,1,1]];
    if mode=="lesion"
        x_ui_value=2*(x_max-x_min);
        y_ui_value=2*(y_max-y_min);
        r_title='Empty';
        button_factor=false;
    else
        x_ui_value=x_max-x_min;
        y_ui_value=y_max-y_min;
        r_title='Raw Image';
        button_factor=true;
    end
    uif = uifigure('Name','Plot'); 
    uif.Position = [300 300 6*x_ui_value 10*y_ui_value];
    p = uipanel(uif,'Position',[0 y_ui_value 6*x_ui_value 10*y_ui_value]);
    sp = uipanel('Parent',p,'Title','x-Tissue Indexed','FontSize',12,...
                  'Position',[0 5*y_ui_value 3*x_ui_value 5*y_ui_value]);
    x_ax=uiaxes(sp,'Position',[0 0 3*x_ui_value 4*y_ui_value]);
    sp2 = uipanel('Parent',p,'Title','y-Tissue Indexed','FontSize',12,...
                  'Position',[3*x_ui_value 5*y_ui_value 3*x_ui_value 5*y_ui_value]);
    y_ax=uiaxes(sp2,'Position',[0 0 3*x_ui_value 4*y_ui_value]);
    sp3 = uipanel('Parent',p,'Title',r_title,'FontSize',12,...
                  'Position',[0 0 3*x_ui_value 5*y_ui_value]);
    r_ax=uiaxes(sp3,'Position',[0 0 3*x_ui_value 4*y_ui_value]);
    sp4 = uipanel('Parent',p,'Title','z-Tissue Indexed','FontSize',12,...
                  'Position',[3*x_ui_value 0 3*x_ui_value 5*y_ui_value]);
    z_ax=uiaxes(sp4,'Position',[0 0 3*x_ui_value 4*y_ui_value]);
    x_ax.Visible='off';y_ax.Visible='off';r_ax.Visible='off';z_ax.Visible='off';
    %sldx = uislider(uif,'Value',20, 'Limits', [0,x_max-x_min],'Position',[100 30 200 100], ...
        %'ValueChangingFcn',@(sld,event) update_image(new_labeled,new_Original,event.Value,ax,ax2));
    x = uigauge('Parent',uif,'Position',[0 0 0 0]);
    y = uigauge('Parent',uif,'Position',[0 0 0 0]);
    z = uigauge('Parent',uif,'Position',[0 0 0 0]);
    lesion_axis = uigauge('Parent',uif,'Position',[0 0 0 0]);
    lesion_start = uigauge('Parent',uif,'Position',[0 0 0 0]); %% lesion start ui value
    lesion_end = uigauge('Parent',uif,'Position',[0 0 0 0]); %% lesion end ui value
    sldx = uislider(sp,'Value',1, 'Limits', [1,x_max-x_min],'Position',[x_ui_value/2 y_ui_value/1.5 2*x_ui_value y_ui_value], ...
        'ValueChangingFcn',@(sldx,event) update_image(new_labeled,new_Original,event.Value,x_ax,y_ax,z_ax,r_ax,x,y,z,'x',map));
    sldy = uislider(sp2,'Value',1, 'Limits', [1,y_max-y_min],'Position',[x_ui_value/2 y_ui_value/1.5 2*x_ui_value y_ui_value], ...
        'ValueChangingFcn',@(sldy,event) update_image(new_labeled,new_Original,event.Value,x_ax,y_ax,z_ax,r_ax,x,y,z,'y',map));
    sldz = uislider(sp4,'Value',1, 'Limits', [1,z_max-z_min],'Position',[x_ui_value/2 y_ui_value/1.5 2*x_ui_value y_ui_value], ...
        'ValueChangingFcn',@(sldz,event) update_image(new_labeled,new_Original,event.Value,x_ax,y_ax,z_ax,r_ax,x,y,z,'z',map));
    if button_factor
        sld_btn = uislider(uif,'Value',3, 'Limits', [1,3],'Position',[2.5*x_ui_value y_ui_value/1.5 x_ui_value y_ui_value]);

        btn = uibutton(uif,'Text','Start of Lesion','Position',[0 0 2*x_ui_value y_ui_value] ...
            ,'ButtonPushedFcn',@(btn,event) start_end_recorder(btn,sld_btn,lesion_start,x,y,z,"start")); 
                                                
        btn2 = uibutton(uif,'Text','End of Lesion','Position',[4*x_ui_value 0 2*x_ui_value y_ui_value] ...
            ,'ButtonPushedFcn',@(btn2,event) start_end_recorder(btn2,sld_btn,lesion_end,x,y,z,"end")); 
    else
        sld_btn=0;

    end
end
function update_image(new_labeled,new_Original,new_value,x_ax,y_ax,z_ax,r_ax,x,y,z,factor,map)
    if factor == 'x'
        x.Value=new_value;
        img_x=ind2rgb(squeeze(new_labeled(round(new_value),:,:)),map);
        imshow(img_x,'parent',x_ax)
        updated_image=new_labeled(round(new_value),:,:);
    end
    if factor == 'y'
        y.Value=new_value;
        % change the new_label
        img_y=ind2rgb(squeeze(new_labeled(:,round(new_value),:)),map);
        imshow(img_y,'parent',y_ax);
        updated_image=new_labeled(:,round(new_value),:);
    end
    if factor == 'z'
        z.Value=new_value
        img_z=ind2rgb(squeeze(new_labeled(:,:,round(new_value))),map);
        imshow(img_z,'parent',z_ax);
        img_r=ind2rgb(new_Original(:,:,round(new_value)),gray(256));%% raw image display based on z value
        imshow(img_r,'parent',r_ax);
        updated_image=new_labeled(:,:,round(new_value));
    end
    display_colorbar(updated_image)
end
function start_end_recorder(btn,sld_btn,holder,x,y,z,st_end_text)
    if round(sld_btn.Value)==1
        holder.Value=x.Value;
        axis_text='x';
    end
    if round(sld_btn.Value)==2
        holder.Value=y.Value;
        axis_text='y';
    end
    if round(sld_btn.Value)==3
        holder.Value=z.Value;
        axis_text='z';
    end
    display("register "+axis_text+" position for "+st_end_text+" of lesion: "+holder.Value);
end

function display_colorbar(new_labeled)
        for num = 0:6
            if any(new_labeled(:)==num)
                display(int2str(num)+" present")
            end
        end
end
