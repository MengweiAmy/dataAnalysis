
%Get Fixation index data
clickIndo = fopen('ClickInfo-Mouse Control.dat','r');
C1 = textscan(clickIndo,'%s%s%s%s%s%s', 'CollectOutput',1);
fclose(clickIndo);
clickIndex = C1{1,1};
% Get column names from fixation index data
attriNaClick = clickIndex(7,:);

% Extract unique class names from the first row
classLabels = clickIndex(7:end,2);
classNames = unique(classLabels);

%% Handle fixation data 
letter = clickIndex(8:end,1:2);
pureClickData = cellfun(@str2double,clickIndex(8:end,3:end));
%plot(fixaIndDoul(:,2),fixaIndDoul(:,3),'.');
timeStart = clickIndex(8,4);
timeEnd = cellfun(@str2double,clickIndex(end,4));
plot(pureClickData(:,3), pureClickData(:,4),'o');hold on;
%% Get fixation Index data
%Get Fixation index data
fidInd = fopen('fixtionIndex.dat','r');
C1 = textscan(fidInd,'%s%s%s%s%s%s', 'CollectOutput',1);
fclose(fidInd);
fixaIndex = C1{1,1};
% Get column names from fixation index data
attriNaFixInd = fixaIndex(1,:);
pureInData = cellfun(@str2double,fixaIndex(1:end,:));
plot(pureInData(:,2), pureInData(:,3),'*');
