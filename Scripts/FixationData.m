function fixationData = FixationData(filePath)

fid = fopen('fixation.dat','r');
C2 = textscan(fid,'%s%s%s%s%s%s%s%s%s%s%s%s', 'CollectOutput',1);
fclose(fid);
fixationRaw = C2{1,1};
% Get column names from fixation data
attriFixaName = fixationRaw(2,:);
fixationData = 