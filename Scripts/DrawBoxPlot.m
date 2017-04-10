MainMatrix = realAnayData(y==0,5);
labels = repmat({num2str(0)},length(MainMatrix),1);
for c=1:length(fixIndex)
    cur = realAnayData(y==c,5);
    MainMatrix = cat(1,MainMatrix,cur);
    l = repmat({num2str(c)},length(cur),1);
    labels = cat(1,labels,l)
end
mfig('Boxplot of pupilsize attributes');clf;
boxplot(MainMatrix,labels);

timeMatrix = CompareFinishTime('/data/NEW-G16-3B-Cp-75,300',3);
bar(matrix)