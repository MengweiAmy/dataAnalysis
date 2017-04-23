blocksize = 1;

%% WPM calculation for 3 blocks
matrix = CompareFinishTime('/data/NEW-G24-1B-Cp-75,250',1, 1, 1);
%matrix2 = CompareFinishTime('/data/NEW-G23-1B-Cp-75,200',blocksize, 1, 1);
%matrix3 = CompareFinishTime('/data/NEW-G22-1B-Cp-75,150',blocksize, 1, 1);
%new = cat(1,matrix,matrix2,matrix3);
mfig('WPM/KSPS calculation'); clf;
subplot(1,2,1)
bar(matrix,'BarWidth', 0.1)
title(strcat('WPM Compare between Mouse and Gaze for  ',num2str(blocksize),' Block(s)'));
if blocksize == 1 
    labels = {'Gaze','Mouse'}
end
for i1=1:2
    text(i1,matrix(i1),num2str(matrix(i1),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
set(gca,'XTick',1:2,'XTickLabel',labels);
ylabel('WPM(Words Per Minute)')

%% KSPS calculation for 3 blocks
matrix = CompareFinishTime('/data/NEW-G24-1B-Cp-75,250',blocksize, 0, 1);
%mfig('KSPS calculation'); clf;
subplot(1,2,2)
bar(matrix,'BarWidth', 0.1)
if blocksize == 1 
    labels = {'Gaze','Mouse'}
end
title(strcat('KSPS Compare between Mouse and Gaze for  ',num2str(blocksize),' Blocks'));
for i1=1:2
    text(i1,matrix(i1),num2str(matrix(i1),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
set(gca,'XTick',1:2,'XTickLabel',labels);
ylabel('KSPS(KeyStrokes Per Seconds)')

%% Pupile radium gaze boxplot for 3 blocks
mfig('boxplot of Pupil Size'); clf;
[gazematrix,wholeClGaze] = GetGazeControlPupilRadium('/data/NEW-G24-1B-Cp-75,250/Gaze',blocksize);
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
elseif blocksize == 3
    grp = [repmat({'Group1'}, length(gzgrp1), 1); 
        repmat({'Group2'}, length(gzgrp2), 1); 
        repmat({'Group3'}, length(gzgrp3), 1)]
else
    grp = [repmat({'Group1'}, length(gzgrp1), 1);]
end

subplot(2,1,1)
boxplot(gazematrix(:,5),grp)

%% Pupil radium mouse boxplot for 3 blocks
[mousematrix,wholeClMous] = GetGazeControlPupilRadium('/data/NEW-G24-1B-Cp-75,250/Mouse',blocksize);
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
elseif blocksize == 3
    grp = [repmat({'Group1'}, length(mcgrp1), 1); 
        repmat({'Group2'}, length(mcgrp1), 1); 
        repmat({'Group3'}, length(mcgrp1), 1)]
else
    grp = [repmat({'Group1'}, length(mcgrp1), 1);]
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


