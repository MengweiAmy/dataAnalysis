%% WPM calculation for 3 blocks
matrix = CompareFinishTime('/data/NEW-G16-3B-Cp-75,300',3, 1);
mfig('WPM calculation'); clf;
bar(matrix)
title('WPM for 3 Blocks')
labels = {'Group1', 'Group2', 'Group3'}
set(gca,'XTick',1:3,'XTickLabel',labels);
ylabel('WPM(Words Per Minute)')
legend('Gaze Control', 'Mouse Control');

%% KSPS calculation for 3 blocks
matrix = CompareFinishTime('/data/NEW-G16-3B-Cp-75,300',3, 0);
mfig('KSPS calculation'); clf;
bar(matrix)
title('KSPS for 3 Blocks')
labels = {'Group1', 'Group2', 'Group3'}
set(gca,'XTick',1:3,'XTickLabel',labels);
ylabel('KSPS(KeyStrokes Per Minute)')
legend('Gaze Control', 'Mouse Control');

%% Pupile radium gaze boxplot for 3 blocks
mfig('boxplot of Pupil Size'); clf;
[gazematrix,wholeClGaze] = GetGazeControlPupilRadium('/data/NEW-G16-3B-Cp-75,300/Gaze',3);
group1 = [];
group2 = [];
group3 = [];
for c= 1:3
    if c == 1
        group1 = gazematrix(gazematrix(:,13) == c);
    elseif c == 2
        group2 = gazematrix(gazematrix(:,13) == c);
    else c == 3
        group3 = gazematrix(gazematrix(:,13) == c);
    end
end
%grp = [zeros(1,length(group1)),ones(1,length(group2)),ones(1,length(group3))];
grp = [repmat({'Group1'}, length(group1), 1); repmat({'Group2'}, length(group2), 1); repmat({'Group3'}, length(group3), 1)]
subplot(2,1,1)
boxplot(gazematrix(:,5),grp)

%% Pupil radium mouse boxplot for 3 blocks
[mousematrix,wholeClMous] = GetGazeControlPupilRadium('/data/NEW-G16-3B-Cp-75,300/Mouse',3);
group1 = [];
group2 = [];
group3 = [];
for c= 1:3
    if c == 1
        group1 = mousematrix(mousematrix(:,13) == c);
    elseif c == 2
        group2 = mousematrix(mousematrix(:,13) == c);
    else c == 3
        group3 = mousematrix(mousematrix(:,13) == c);
    end
end
%grp = [zeros(1,length(group1)),ones(1,length(group2)),ones(1,length(group3))];
grp = [repmat({'Group1'}, length(group1), 1); repmat({'Group2'}, length(group2), 1); repmat({'Group3'}, length(group3), 1)]
subplot(2,1,2)
boxplot(mousematrix(:,5),grp)

%% Compare the pupil from gaze and mouse
mfig('boxplot of Pupil Size for Mouse and Gaze'); clf;
data = cat(1,mousematrix,gazematrix)
datagrp = [repmat({'Mouse Pupil'}, length(mousematrix), 1); repmat({'Gaze Pupil'}, length(gazematrix), 1);]
boxplot(data(:,5),datagrp)

%% Analysis pupil size change
mfig('Plot of pupil size'); clf;
plot(mousematrix(:,5));

mfig('Plot of pupil size'); clf;
plot(gazematrix(:,5));

%% find the biggest pupil size position
% find out the time when pupil size is larger than 6.6
idBigg = gazematrix(:,5) > 6.6;
biggestPuMat = gazematrix(idBigg,:)
tPeriSt = biggestPuMat(1,10)
tPeriEnd = biggestPuMat(length(biggestPuMat),10)

%get the point from Click data where gaze size is larger than 6.6
clickMa = GetRangeDataFromMatrix(tPeriSt,tPeriEnd,wholeClGaze,4)

%% Pupil size range based on the word length


