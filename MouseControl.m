%% Load files
% Get Fixation raw data
fid = fopen('fixation.dat','r');
C2 = textscan(fid,'%s%s%s%s%s%s%s%s%s%s', 'CollectOutput',1);
fclose(fid);
fixationRaw = C2{1,1};
% Get column names from fixation data
attriFixaName = fixationRaw(1,:);

%Get Fixation index data
fidInd = fopen('fixtionIndex.dat','r');
C1 = textscan(fidInd,'%s%s%s%s%s%s', 'CollectOutput',1);
fclose(fidInd);
fixaIndex = C1{1,1};
% Get column names from fixation index data
attriNaFixInd = fixaIndex(1,:);

%% Handle raw fixation data
% Remove eye found 0 lines
% Plot Raw data based on timestamp
fixaDoul = cellfun(@str2double,fixationRaw(2:end,:));
fixaDoul = fixaDoul(all(fixaDoul,2),:);
%plot(fixaDoul(:,3),fixaDoul(:,4),'o');hold on;
[badrows,c]=find(fixaDoul(:,3:4)<0);
newA = fixaDoul(setdiff(1:size(fixaDoul,1),badrows),:)

%Plot pupil size carve
plot(newA(:,5));

%% Handle fixation data 
fixaIndDoul = cellfun(@str2double,fixaIndex(2:end,:));
%plot(fixaIndDoul(:,2),fixaIndDoul(:,3),'.');
