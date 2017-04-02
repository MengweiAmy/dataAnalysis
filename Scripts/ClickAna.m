function r = ClickAna()
%Get Fixation index data
fidInd = fopen('ClickInfo-Mouse Control.dat','r');
C1 = textscan(fidInd,'%s%s%s%s%s%s', 'CollectOutput',1);
fclose(fidInd);
fixaIndex = C1{1,1};
% Get column names from fixation index data
attriNaFixInd = fixaIndex(7,:);


% Extract unique class names from the first row
classLabels = fixaIndex(7:end,2);
classNames = unique(classLabels);

%% Handle fixation data 
letter = fixaIndex(8:end,1:2);
pureData = cellfun(@str2double,fixaIndex(8:end,3:end));
%plot(fixaIndDoul(:,2),fixaIndDoul(:,3),'.');
timeStart = fixaIndex(8,4);
timeEnd = cellfun(@str2double,fixaIndex(end,4));