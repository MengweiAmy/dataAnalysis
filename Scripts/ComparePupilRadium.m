function pupileRadium = ComparePupilRadium(filepath,blockSize)
pupileRadium=[];

%Get current folder name
parentpath = pwd(); 

%Get fixation data
fileNFix = strcat(filepath,'/Gaze/fixation');
path = fullfile(parentpath,strcat(fileNFix,'.dat'));
fixationRaw = ReadData(path,12);
fixaDoul = cellfun(@str2double,fixationRaw(3:end,:));%convert cells to double
fixaRealData = ClearFixationInvalidData(fixaDoul);
    
for s = 1: blockSize
%%Compare the same sentence time assuming 
    
    %filepath = '/data/NEW-G16-3B-Cp-75,300';
    fileNameGaze = strcat(filepath,'/Gaze/ClickInfo-Gaze Control_',num2str(s));
    path = fullfile(parentpath,strcat(fileNameGaze,'.dat'));
    gaze = ReadData(path,6);

    %Get the end time of current gaze period
    
    timeGazStart = cellfun(@str2double,gaze(6,4));
    timeGazEnd = cellfun(@str2double,gaze(length(gaze),4));
    
    if s==1
        timeGazStart = 0;
    end
        
    %%%%%%%%%%%%%%%%%%Get report time for now
    idxEnd = fixaRealData(:,10) < timeGazEnd;
    fixaForCurrGaze = fixaRealData(idxEnd,:);% get fixation when look at text area
    
    idxStar = fixaForCurrGaze(:,10) > timeGazStart;
    fixaForCurrGaze = fixaForCurrGaze(idxStar,:);
   
    if s == 1 
        pupileRadium = fixaForCurrGaze;
    else 
        pupileRadium = cat(1,pupileRadium,fixaForCurrGaze)
    end
    %boxplot(fixaForCurrGaze(:,5))
end