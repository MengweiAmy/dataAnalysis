function timeMatrix = CompareFinishTime(filepath,blockSize,isWPM,isMouseGaze)
timeMatrix=[];
for s = 1: blockSize
    %%Compare the same sentence time assuming 
    parentpath = pwd(); 
    if isMouseGaze == 1
        Path = strcat(filepath,'/Gaze/')
    else
        Path = filepath
    end
    fileNameGaze = strcat(Path,'/ClickInfo_',num2str(s));
    
    path = fullfile(parentpath,strcat(fileNameGaze,'.dat'));
    gaze = ReadData(path,6);
    for st= 1:10
        if cellfun(@str2double,gaze(st,1)) == 0
            startIndex = st
            break
        end
    end 
    %Number of key stroke when using gaze control
    if isWPM == 1
        str=cellstr(gaze(startIndex:end,2));
        ids = []
        for c=1:length(str)
            if strcmp(char(str(c)),'bksp') == 0
                ids = cat(1,ids,c);
            end
        end
        gazeKeyClick = gaze(ids,:)
    else
        gazeKeyClick = gaze(startIndex:end,:)
    end

    glettersize = length(gazeKeyClick);
    
    if isMouseGaze == 1
        fileName = strcat(filepath,'/Mouse/ClickInfo_',num2str(s));
        mousepath = fullfile(parentpath,strcat(fileName,'.dat'));
        mouse = ReadData(mousepath,6);
        for st= 1:10
            if cellfun(@str2double,mouse(st,1)) == 0
                mouseStartIndex = st
                break
            end
        end 
        %Number of key stroke when using gaze control
        str=cellstr(mouse(mouseStartIndex:end,2));
        if isWPM == 1
            ids = []
            for c=1:length(str)
                if strcmp(char(str(c)),'bksp') == 0
                    ids = cat(1,ids,c);
                end
            end
            mouseKeyClick = mouse(ids,:)
        else
            mouseKeyClick = mouse(mouseStartIndex:end,:)
        end

        mlettersize = length(mouseKeyClick);
        
        %Get time period of mouse control
        timeMousStart = cellfun(@str2double,mouse(mouseStartIndex,4));
        timeMousEnd = cellfun(@str2double,mouse(length(mouse),4));
        mousePeriod = timeMousEnd - timeMousStart;
    end


    %Get time period of gaze control
    timeGazStart = cellfun(@str2double,gaze(startIndex,4));
    timeGazEnd = cellfun(@str2double,gaze(length(gaze),4));
    gazePeriod =timeGazEnd - timeGazStart;

    if isMouseGaze == 1
        if isWPM == 1
            r = [WPM(glettersize,gazePeriod) WPM(mlettersize,mousePeriod)]
        else 
            r = [KSPS(glettersize,gazePeriod) KSPS(mlettersize,mousePeriod)]
        end
    else
         if isWPM == 1
            r = WPM(glettersize,gazePeriod)
        else 
            r = KSPS(glettersize,gazePeriod)
        end
    end
    
   
    if s == 1 
        timeMatrix = r;
    else 
        timeMatrix = cat(1,timeMatrix,r)
    end
end