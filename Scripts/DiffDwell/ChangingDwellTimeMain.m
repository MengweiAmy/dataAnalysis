
%% Main body of functions
blocksize = 3
folder = '/data/NEW-G28-3B-CpRan'
mfig('boxplot of Pupil Size'); clf;
parentPath = pwd;
filePath = strcat(parentPath,folder);
[gazematrix,wholeClGaze] = GetGazeControlPupilRadium(folder,blocksize);
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
    grp = [repmat({'Firste Sentence'}, length(gzgrp1), 1); 
        repmat({'Second Sentence'}, length(gzgrp2), 1); 
        repmat({'Third Sentence'}, length(gzgrp3), 1);
        repmat({'Fouth Sentence'}, length(gzgrp4), 1);
        repmat({'Fifth Sentence'}, length(gzgrp5), 1)]
elseif blocksize == 3
    grp = [repmat({'First Sentence'}, length(gzgrp1), 1); 
        repmat({'Second Sentence'}, length(gzgrp2), 1); 
        repmat({'Third Sentence'}, length(gzgrp3), 1)]
else
    grp = [repmat({'Firste Sentence'}, length(gzgrp1), 1);]
end
boxplot(gazematrix(:,5),grp)

%% Pupil Curve
mfig('Plot of pupil size'); clf;
grp1 = gazematrix(gazematrix(:,13) == 1,:);
plot(grp1(:,5));hold on;
grp2 = gazematrix(gazematrix(:,13) == 2,:);
plot(grp2(:,5));hold on;
grp3 = gazematrix(gazematrix(:,13) == 3,:);
plot(grp3(:,5));

legend({'First Sentence','Second Sentence','Third Sentence'})
xlabel('Data point')
ylabel('Pupil Size')
title('Pupil size change for different Dwell time')

%% Performance analysis
matrix = CompareFinishTime(folder,blocksize, 1, 0);
mfig('WPM calculation'); clf;
bar(matrix,'BarWidth', 0.1)