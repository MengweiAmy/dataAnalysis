%% Compare the durition between two characters
% Get the most longest duration between two characters and then figure out
% the pupil size change pattern during that period

parentpath=pwd()
filepath = strcat('/data/NEW-G26-3B-Cp-75,250/gaze/')
blocksize = 1

pupilData = GetPupilDataFromFixation(filepath);

for c = 1: blocksize
    fileNameGaze = strcat(filepath,'/ClickInfo_',num2str(c));
    
    path = fullfile(parentpath,strcat(fileNameGaze,'.dat'));
    clickData = ReadData(path,6);
    
    if cellfun(@str2double,clickData(4,1)) == 0
        startIndex = 4
    elseif cellfun(@str2double,clickData(6,1)) == 0
        startIndex = 6
    end
    
    characters = cellfun(@str2double,clickData(startIndex:end,3:4));
    
    str=cellstr(clickData(startIndex:end,2));
    durations = []
    for s=1:length(str)
        if s == 1
            durations = 0.0
        else
            time = characters(s,2);
            prevTime = characters(s-1,2);
            dur = time - prevTime;
            durations = cat(1,durations,dur);
        end
    end
    characters(:,5) = durations;
    
    B=sortrows(characters,5)
    
    % Get the first 10 longest durationg
    LongestDur = B(length(B)-4:length(B)-1,:)
    %Analysis the pupil size change during the 10th characters
    
    [m,n] = size(LongestDur)
    mfig('WPM calculation'); clf;
    for l = 1: m
        subplot(2,2,l)
        timeSec = LongestDur(l,2);
        idsEnd = pupilData(:,9) <= timeSec+0.25
        peridEnd = pupilData(idsEnd,:)
        idsStar = peridEnd(:,9) >= timeSec-LongestDur(l,5)
        final = peridEnd(idsStar,:)
        
        plot(final(:,9),final(:,5));hold on;
        xlabel(strcat('Long duration next click time :',num2str(timeSec)))
        ylabel('Pupil Size')
    end
    
end