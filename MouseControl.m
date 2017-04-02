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

