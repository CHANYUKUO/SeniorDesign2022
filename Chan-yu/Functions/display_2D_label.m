function display_2D_label(Labeled,Original_img)
%% View rbg Image as a volume

% Preallocate command to ask for user input
userinput = true;
figure(2);

% If the user is still inputing slide number
    while userinput
        prompt = {'Enter Z Slice Interested','Quit(Y/N)'};
        dlgtitle = '2D';
        dims = [1 35];
        definput = {'20','N'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        slicenumber = str2double(answer{1});

        % Test to see if the user exited the program
        if answer{1} == 'N'
            disp('Thank you! See you soon.');
            userinput = false;
            break;
        end
        
        % Test to see if the slice number is out of bound
        if slicenumber < 0 || slicenumber > sizesize(Labeled,3)
        disp('Slice number out of bound!');
        continue;
        end
        
        % Close previous figure
        close 2;
        
        % Display the image slide base on user input
        figure(2);
        hold on;
        subplot(1,2,1);
        imshow(Labeled(:,:,slicenumber),[0,5]);
        subplot(1,2,2);
        imshow(Original_img(:,:,slicenumber));
        
    end
end