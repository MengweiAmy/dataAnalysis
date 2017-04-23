function pupil = GetPupilDataFromFixation(filepath)
%Get current folder name
parentpath = pwd(); 

%Get fixation data
fileNFix = strcat(filepath,'/fixation');
path = fullfile(parentpath,strcat(fileNFix,'.dat'));
fixationRaw = ReadData(path,12);
fixaDoul = cellfun(@str2double,fixationRaw(3:end,:));%convert cells to double
pupil = ClearFixationInvalidData(fixaDoul);