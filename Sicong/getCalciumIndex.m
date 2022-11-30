function [Indexarray] = getCalciumIndex(overlappednii)
%GETCALCIUMINDEX returns the x,y,z index of detected calcium signal


labeled = labelImage(overlappednii);
z = getCalciumSlices(labeled);
Indexarray = cell(1,3,length(z));

for i = 1:length(z)
    [row,col] = find(labeled(:,:,z(i)) == 5);
    Indexarray{1,1,i} = row;
    Indexarray{1,2,i} = col;
    Indexarray{1,3,i} = z(i);
end

end

