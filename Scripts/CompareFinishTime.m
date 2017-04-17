function timeMatrix = CompareFinishTime(filepath,blockSize,isWPM)
timeMatrix=[];
for s = 1: blockSize
    %%Compare the same sentence time assuming 
    parentpath = pwd(); 
    fileNameGaze = strcat(filepath,'/Gaze/ClickInfo-Gaze Control_',num2str(s));
    path = fullfile(parentpath,strcat(fileNameGaze,'.dat'));
    gaze = ReadData(path,6);
    %Number of key stroke when using gaze control
    if isWPM == 1
        str=cellstr(gaze(6:end,2));
        ids = []
        for c=1:length(str)
            if strcmp(char(str(c)),'bksp') == 0
                ids = cat(1,ids,c);
            end
        end
        gazeKeyClick = gaze(ids,:)
    else
        gazeKeyClick = gaze(6:end,:)
    end

    glettersize = length(gazeKeyClick);

    fileName = strcat(filepath,'/Mouse/ClickInfo-Mouse Control_',num2str(s));
    mousepath = fullfile(parentpath,strcat(fileName,'.dat'));
    mouse = ReadData(mousepath,6);
    
    %Number of key stroke when using gaze control
    str=cellstr(mouse(6:end,2));
    if isWPM == 1
        ids = []
        for c=1:length(str)
            if strcmp(char(str(c)),'bksp') == 0
                ids = cat(1,ids,c);
            end
        end
        mouseKeyClick = mouse(ids,:)
    else
        mouseKeyClick = mouse(6:end,:)
    end

    mlettersize = length(mouseKeyClick);

    %Get time period of gaze control
    timeGazStart = cellfun(@str2double,gaze(6,4));
    timeGazEnd = cellfun(@str2double,gaze(length(gaze),4));
    gazePeriod =timeGazEnd - timeGazStart;

    %Get time period of mouse control
    timeMousStart = cellfun(@str2double,mouse(6,4));
    timeMousEnd = cellfun(@str2double,mouse(length(mouse),4));
    mousePeriod = timeMousEnd - timeMousStart;
    if isWPM == 1
        r = [WPM(glettersize,gazePeriod) WPM(mlettersize,mousePeriod)]
    else 
        r = [KSPS(glettersize,gazePeriod) KSPS(mlettersize,mousePeriod)]
    end
   
    if s == 1 
        timeMatrix = r;
    else 
        timeMatrix = cat(1,timeMatrix,r)
    end
end