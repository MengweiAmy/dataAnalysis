%% WPM calculation for 3 blocks
matrix = CompareFinishTime('/data/NEW-G16-3B-Cp-75,300',3, 1);
bar(matrix)
title('WPM for 3 Blocks')
labels = {'Group1', 'Group2', 'Group3'}
set(gca,'XTick',1:3,'XTickLabel',labels);
ylabel('WPM(Words Per Minute)')
legend('Gaze Control', 'Mouse Control');

%% KSPM calculation for 3 blocks
matrix = CompareFinishTime('/data/NEW-G16-3B-Cp-75,300',3, 0);
bar(matrix)
title('KSPS for 3 Blocks')
labels = {'Group1', 'Group2', 'Group3'}
set(gca,'XTick',1:3,'XTickLabel',labels);
ylabel('KSPS(KeyStrokes Per Minute)')
legend('Gaze Control', 'Mouse Control');

%% Pupile radium gaze boxplot for 3 blocks
matrix = GetGazeControlPupilRadium('/data/NEW-G16-3B-Cp-75,300/',3);
group1 = [];
group2 = [];
group3 = [];
for c= 1:3
    if c == 1
        group1 = matrix(matrix(:,13) == c);
    elseif c == 2
        group2 = matrix(matrix(:,13) == c);
    else c == 3
        group3 = matrix(matrix(:,13) == c);
    end
end
%grp = [zeros(1,length(group1)),ones(1,length(group2)),ones(1,length(group3))];
grp = [repmat({'Group1'}, length(group1), 1); repmat({'Group2'}, length(group2), 1); repmat({'Group3'}, length(group3), 1)]
boxplot(matrix(:,5),grp)

%% Pupil radium mouse boxplot for 3 blocks
matrix = GetGazeControlPupilRadium('/data/NEW-G16-3B-Cp-75,300/Mouse',3);
group1 = [];
group2 = [];
group3 = [];
for c= 1:3
    if c == 1
        group1 = matrix(matrix(:,13) == c);
    elseif c == 2
        group2 = matrix(matrix(:,13) == c);
    else c == 3
        group3 = matrix(matrix(:,13) == c);
    end
end
%grp = [zeros(1,length(group1)),ones(1,length(group2)),ones(1,length(group3))];
grp = [repmat({'Group1'}, length(group1), 1); repmat({'Group2'}, length(group2), 1); repmat({'Group3'}, length(group3), 1)]
boxplot(matrix(:,5),grp)