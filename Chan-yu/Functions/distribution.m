function D=distribution(label)

    %get labeled matrix of tissue types 
    %label=TID(vessel,2);
    dim=size(label);
    
    %compute the histogram counts of each tissue type 
    for i=1:dim(3)
        slice=label(:,:,i);
        C1 = categorical(slice,[1 2 3 4 5],{'fat', 'muscle', 'vessel', 'blood', 'calcium'}); 
        [N,Categories] = histcounts(C1);
        fat(i)=N(1);
        muscle(i)=N(2);
        vessel(i)=N(3);
        blood(i)=N(4);
        calcium(i)=N(5);
       
    end
    
    %calculate distribution  
    tot=dim(1)*dim(2)*dim(3);
    advxyz = sum(vessel)/(tot);
    aoxyz = sum(blood)/(tot);
    musxyz = sum(muscle)/(tot);
    fatxyz = sum(fat)/(tot);
    caxyz = sum(calcium)/(tot);
    
    %record data in a table as percentage 
    Types={'Vessel', 'Muscle', 'Fat', 'Calcium', 'Blood'}'; 
    Data=[advxyz, musxyz, fatxyz, caxyz, aoxyz]';
    D=table(Types, Data*100); 
end
