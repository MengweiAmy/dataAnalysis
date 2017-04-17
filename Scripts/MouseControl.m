%% Load files
% Get Fixation raw data
fid = fopen('fixation.dat','r');
C2 = textscan(fid,'%s%s%s%s%s%s%s%s%s%s%s%s', 'CollectOutput',1);
fclose(fid);
fixationRaw = C2{1,1};
% Get column names from fixation data
attriFixaName = fixationRaw(2,:);

%% Prepeare data
fixaDoul = cellfun(@str2double,fixationRaw(3:end,:));%convert cells to double
idx = fixaDoul(:,4) < 268;
textArea = fixaDoul(idx,:);% get fixation when look at text area

%remove eye found zero rows
zeroId = (fixaDoul(:,2) == 1);
zeroLine = fixaDoul(zeroId,:);

%remove non-fixation (-1) rows
nonFixId = (zeroLine(:,12) ~= -1);
realAnayData = zeroLine(nonFixId,:);

%% START handling read data
%% First simple handling on raw data
%1. Plot the pupil size change during the whole input process
mfig('Fixation & Pupil Size'); clf;
plot(realAnayData(:,5));hold on;
%plot(realAnayData(:,3),realAnayData(:,4),'*');
title('Pupil size changed based on Index');
ylabel('Pupile Size');

%2. Plot the click position
mfig('Fixation & Click Info'); clf;
plot(realAnayData(:,3),realAnayData(:,4),'*');
xlabel('X position');
ylabel('Y position');

%3. Boxplotting of the pupil size based on each fixation

fixIndexLabel = realAnayData(:,12);
fixIndex = unique(fixIndexLabel);
[y_,y] = ismember(fixIndexLabel, fixIndex); y = y'-1;

mfig('Boxplot of normalized attributes');clf;

for c=0:5
  boxplot(realAnayData(y==c,5));hold on;  
end

%boxplot(realAnayData(:,5),attriFixaName(:,5));
title('Boxplot of the attributes (normalized)');

%ClickInfo = ClickAna();
%plot(ClickInfo(:,3),ClickInfo(:,4),'o');


