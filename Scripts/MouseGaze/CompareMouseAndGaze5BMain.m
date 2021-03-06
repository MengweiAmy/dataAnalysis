blocksize = 5;
folder = '/data/EX-G3-5B-75,250'
%% WPM calculation for 3 blocks
matrix = CompareFinishTime(folder,blocksize, 1, 1);
mfig('WPM calculation'); clf;
subplot(1,2,1)
bar(matrix)
[m,n] = size(matrix)
for i1=1:n
    for i2 = 1:m
        if i1 == 1
            xpos = i2 - 0.15
        else
            xpos = i2 + 0.15
        end
        text(xpos,matrix(i2,i1),num2str(matrix(i2,i1),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
    end
end
title(strcat('WPM Compare between Mouse and Gaze for  ',num2str(blocksize),' Block(s)'));
if blocksize == 5
    labels = {'Group1', 'Group2', 'Group3','Group4','Group5'};
else
    labels = {'Group1', 'Group2', 'Group3'}
end
set(gca,'XTick',1:blocksize,'XTickLabel',labels);
ylabel('WPM(Words Per Minute)')
legend('Gaze Control', 'Mouse Control');

%% KSPS calculation for 3 blocks
matrix = CompareFinishTime(folder,blocksize, 0, 1);
%mfig('KSPS calculation'); clf;
subplot(1,2,2)
bar(matrix)
[m,n] = size(matrix)
for i1=1:n
    for i2 = 1:m
        if i1 == 1
            xpos = i2 - 0.15
        else
            xpos = i2 + 0.15
        end
        text(xpos,matrix(i2,i1),num2str(matrix(i2,i1),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
    end
end
if blocksize == 5
    labels = {'Group1', 'Group2', 'Group3','Group4','Group5'}
else
    labels = {'Group1', 'Group2', 'Group3'}
end
title(strcat('KSPS Compare between Mouse and Gaze for  ',num2str(blocksize),' Blocks'));
set(gca,'XTick',1:blocksize,'XTickLabel',labels);
ylabel('KSPS(KeyStrokes Per Minute)')
legend('Gaze Control', 'Mouse Control');

%% Pupile radium gaze boxplot for 3 blocks
mfig('boxplot of Pupil Size'); clf;
[gazematrix,wholeClGaze] = GetGazeControlPupilRadium(strcat(folder,'/Gaze'),blocksize);
gzgrp1 = [];
gzgrp2 = [];
gzgrp3 = [];
gzgrp4 = [];
gzgrp5 = [];
for c= 1:blocksize
    if c == 1
        gzgrp1 = gazematrix(gazematrix(:,13) == c);
    elseif c == 2
        gzgrp2 = gazematrix(gazematrix(:,13) == c);
    elseif c == 3
        gzgrp3 = gazematrix(gazematrix(:,13) == c);
    end
    if blocksize == 5
        if c == 4
            gzgrp4 = gazematrix(gazematrix(:,13) == c);
        elseif c == 5
            gzgrp5 = gazematrix(gazematrix(:,13) == c);
        end
    end
end
%grp = [zeros(1,length(group1)),ones(1,length(group2)),ones(1,length(group3))];
if blocksize == 5
    grp = [repmat({'Group1'}, length(gzgrp1), 1); 
        repmat({'Group2'}, length(gzgrp2), 1); 
        repmat({'Group3'}, length(gzgrp3), 1);
        repmat({'Group4'}, length(gzgrp4), 1);
        repmat({'Group5'}, length(gzgrp5), 1)]
else
    grp = [repmat({'Group1'}, length(gzgrp1), 1); 
        repmat({'Group2'}, length(gzgrp2), 1); 
        repmat({'Group3'}, length(gzgrp3), 1)]
end

subplot(2,1,1)
boxplot(gazematrix(:,5),grp)

%% Pupil radium mouse boxplot for 3 blocks
[mousematrix,wholeClMous] = GetGazeControlPupilRadium(strcat(folder,'/Mouse'),blocksize);
mcgrp1 = [];
mcgrp2 = [];
mcgrp3 = [];
mcgrp4 = [];
mcgrp5 = [];
for c= 1:blocksize
    if c == 1
        mcgrp1 = mousematrix(mousematrix(:,13) == c);
    elseif c == 2
        mcgrp2 = mousematrix(mousematrix(:,13) == c);
    elseif c == 3
        mcgrp3 = mousematrix(mousematrix(:,13) == c);
    end
    if blocksize == 5
        if c == 4
            mcgrp4 = mousematrix(mousematrix(:,13) == c);
        elseif c == 5
            mcgrp5 = mousematrix(mousematrix(:,13) == c);
        end
    end
        
end
%grp = [zeros(1,length(group1)),ones(1,length(group2)),ones(1,length(group3))];
if blocksize == 5
    grp = [repmat({'Group1'}, length(mcgrp1), 1);
        repmat({'Group2'}, length(mcgrp2), 1); 
        repmat({'Group3'}, length(mcgrp3), 1);
        repmat({'Group4'}, length(mcgrp4), 1);
        repmat({'Group5'}, length(mcgrp5), 1)]
else
    grp = [repmat({'Group1'}, length(mcgrp1), 1); 
        repmat({'Group2'}, length(mcgrp2), 1);
        repmat({'Group3'}, length(mcgrp3), 1)]
end
subplot(2,1,2)
boxplot(mousematrix(:,5),grp)

%% Compare the pupil from gaze and mouse
mfig('boxplot of Pupil Size for Mouse and Gaze'); clf;
data = cat(1,mousematrix,gazematrix)
datagrp = [repmat({'Mouse Pupil'}, length(mousematrix), 1); repmat({'Gaze Pupil'}, length(gazematrix), 1);]
boxplot(data(:,5),datagrp)

%% Analysis pupil size change
mfig('Plot of pupil size'); clf;
plot(mousematrix(:,5));hold on;
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
mfig('Plot of pupil size For Each Sentence'); clf;
grp1 = gazematrix(gazematrix(:,13) == 1,:);
plot(grp1(:,5));hold on;
grp2 = gazematrix(gazematrix(:,13) == 2,:);
plot(grp2(:,5));hold on;
grp3 = gazematrix(gazematrix(:,13) == 3,:);
plot(grp3(:,5));hold on;
grp4 = gazematrix(gazematrix(:,13) == 4,:);
plot(grp4(:,5));
grp5 = gazematrix(gazematrix(:,13) == 5,:);
plot(grp5(:,5));


legend({'First Sentence','Second Sentence','Third Sentence'})
xlabel('Data point')
ylabel('Pupil Size')
title('Pupil size change for different Dwell time')
