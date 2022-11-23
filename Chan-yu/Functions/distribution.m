function D=distribution(label)

    %get labeled matrix of tissue types 
    %label=TID(vessel,2);
    dim=size(label);
    
    %compute the histogram counts of each tissue type 
    for i=1:dim(3)
        slice=label(:,:,i);
        C1 = categorical(slice,[0 1 2 3 4 5],{'connt', 'adv', 'ao', 'mus', 'fat', 'ca'}); 
        [N,Categories] = histcounts(C1);
        conn(i)=N(1);
        adv(i)=N(2);
        ao(i)=N(3);
        mus(i)=N(4);
        fat(i)=N(5);
        ca(i)=N(6);
       
    end
    
    %calculate distribution  
    tot=dim(1)*dim(2)*dim(3);
    connxyz = sum(conn)/(tot);
    advxyz = sum(adv)/(tot);
    aoxyz = sum(ao)/(tot);
    musxyz = sum(mus)/(tot);
    fatxyz = sum(fat)/(tot);
    caxyz = sum(ca)/(tot);
    
    %record data in a table as percentage 
    Types={'Adventitia', 'Muscle', 'Fat', 'Connective Tissue', 'Calcium', 'Aortic Wall'}'; 
    Data=[advxyz, musxyz, fatxyz, connxyz, caxyz, aoxyz]';
    D=table(Types, Data*100); 
end
