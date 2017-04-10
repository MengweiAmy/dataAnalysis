function timeMatrix = CompareFinishTime(filepath,blockSize)
timeMatrix=[];
for s = 1: blockSize
    %%Compare the same sentence time assuming 
    parentpath = pwd(); 
    fileNameGaze = strcat(filepath,'/Gaze/ClickInfo-Gaze Control_',num2str(s));
    path = fullfile(parentpath,strcat(fileNameGaze,'.dat'));
    gaze = handleData(path,6);

    fileName = strcat(filepath,'/Mouse/ClickInfo-Mouse Control_',num2str(s));
    mousepath = fullfile(parentpath,strcat(fileName,'.dat'));
    mouse = handleData(mousepath,6);

    %Get time period of gaze control
    timeGazStart = cellfun(@str2double,gaze(6,4));
    timeGazEnd = cellfun(@str2double,gaze(length(gaze),4));
    gazePeriod =timeGazEnd - timeGazStart;

    %Get time period of mouse control
    timeMousStart = cellfun(@str2double,mouse(6,4));
    timeMousEnd = cellfun(@str2double,mouse(length(mouse),4));
    mousePeriod = timeMousEnd - timeMousStart;
    r = [gazePeriod mousePeriod]
    if s == 1 
        timeMatrix = r;
    else 
        timeMatrix = cat(1,timeMatrix,r)
    end
end