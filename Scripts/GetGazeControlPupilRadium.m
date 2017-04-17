function [r,z] = GetGazeControlPupilRadium(filepath,blockSize)
pupileRadium=[];

%Get current folder name
parentpath = pwd(); 

%Get fixation data
fileNFix = strcat(filepath,'/fixation');
path = fullfile(parentpath,strcat(fileNFix,'.dat'));
fixationRaw = ReadData(path,12);
fixaDoul = cellfun(@str2double,fixationRaw(3:end,:));%convert cells to double
fixaRealData = ClearFixationInvalidData(fixaDoul);
A = zeros(length(fixaRealData),1)
A(:)= -1
fixaRealData(:,13) = A;
wholeClickData = [];
    
for s = 1: blockSize
%%Compare the same sentence time assuming 
    
    %filepath = '/data/NEW-G16-3B-Cp-75,300';
    fileNameGaze = strcat(filepath,'/ClickInfo_',num2str(s));
    path = fullfile(parentpath,strcat(fileNameGaze,'.dat'));
    gaze = ReadData(path,6);
    wholeClickData = cat(1,wholeClickData,gaze(6:end,:))
    %Get the end time of current gaze period
    
    timeGazStart = cellfun(@str2double,gaze(6,4));
    timeGazEnd = cellfun(@str2double,gaze(length(gaze),4));
    
    if s==1
        timeGazStart = 0;
    end
        
    %%%%%%%%%%%%%%%%%%Get report time for now
    idxEnd = fixaRealData(:,10) <= timeGazEnd;
    fixaForCurrGaze = fixaRealData(idxEnd,:);% get fixation when look at text area
    
    idxStar = fixaForCurrGaze(:,10) >= timeGazStart;
    fixaPerid = fixaForCurrGaze(idxStar,:);
    fixaPerid(:,13) = s;%Add group number for each gaze group
    if s == 1 
        pupileRadium = fixaPerid;
    else 
        pupileRadium = cat(1,pupileRadium,fixaPerid)
    end
    %boxplot(fixaForCurrGaze(:,5))
end
r = pupileRadium
z = wholeClickData
end