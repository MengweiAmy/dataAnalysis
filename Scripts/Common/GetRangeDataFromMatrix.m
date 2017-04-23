function range = GetRangeDataFromMatrix(start,endInde,matrix,colu)
if iscell(matrix) == 1
    newMatri = cellfun(@str2double,matrix(:,colu))
    ids = cellfun(@str2num,matrix(:,1))
else
    newMatri = matrix;
    ids = matrix(:,1)
end
startIdx = newMatri(:) > start;
leftmatrix = newMatri(startIdx,:);
leftIdx = ids(startIdx,:)
endIdx = leftmatrix(:) < endInde;
range = leftmatrix(endIdx,:)
rangeId = leftIdx(endIdx,:)
range = [rangeId,range]
