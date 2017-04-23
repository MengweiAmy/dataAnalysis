function r = GetFinishTime(path)
    parentpath = pwd(); 
    filepath = fullfile(parentpath,strcat(path,'.dat'));
    gaze = ReadData(filepath,6);
    if cellfun(@str2double,gaze(4,1)) == 0
        startIndex = 4
    elseif cellfun(@str2double,gaze(6,1)) == 0
        startIndex = 6
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
    r=0
end
