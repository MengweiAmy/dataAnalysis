%% Basic Idea is :
%Find out the character before and after "bksp", in order to calculate the
%percent of most highest error typing ones

parentpath=pwd()
filepath = strcat('/data/EX_G1_3B_Ran')
blocksize = 3

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
    
    characters = clickData(startIndex:end,:)
    
    beforeids = []
    afterids = []
    str=cellstr(characters(:,2));
    ids = []
    for s=1:length(str)
        str(s)
        if strcmp(char(str(s)),'bksp') == 1% if equals bksp, then return 1
            %if s > 2
            %    beforeids = cat(1,beforeids,s-2)
            %end
            beforeids = cat(1,beforeids,s-1)
            ids = cat(1,ids,s);
            %if s > 2
            %    afterids = cat(1,afterids,s+2)
            %end
            afterids = cat(1,afterids,s+1)
        end
    end
    [m,n] = size(afterids)
    bkspChars = characters(ids,:)
    resultChars = characters(beforeids,:)
    targetChars = characters(afterids,:)
    
    mfig(strcat('BKSP Pattern for Sentance :',c)); clf;
    
    for a = 1:m
        subplot(1,m,a)
        % Get the click time of the button before and after bksp
        timeBefoBksp = cellfun(@str2double,resultChars(a,4))
        timeafterBksp = cellfun(@str2double,targetChars(a,4))
        bksptime = cellfun(@str2double,bkspChars(a,4))
        
        idsBksp = pupilData(:,9) <= bksptime;

        idsEnd = pupilData(:,9) <= timeafterBksp
        peridEnd = pupilData(idsEnd,:)
        idsStar = peridEnd(:,9) >= timeBefoBksp
        
        % Get the period between previous button and bksp button and after
        % button
        final = peridEnd(idsStar,:)
        
        %Get pupil Data before the bksp button
        peridPupi = pupilData(idsBksp,:);
        puStar = peridPupi(:,9) >= timeBefoBksp
        bkspPupi = peridPupi(puStar,:);
        
        %Plot the pupil data
        plot(final(:,9),final(:,5));hold on;
        
        %Find the closet time point in fixation compared with the bksp
        %occured time
        [c curindex] = min(abs(final(:,9)-bksptime))
        closetDaPoint = final(curindex,:)
        plot(closetDaPoint(9),closetDaPoint(5),'rs'); hold on;
        txt1 = strcat('\leftarrow bksp',':',num2str(closetDaPoint(5)));
        text(closetDaPoint(9),closetDaPoint(5),txt1)
        
        %Add previous bksp button on plot
        [c preindex] = min(abs(final(:,9)-timeBefoBksp))
        lastClick = final(preindex,:)
        plot(lastClick(9),lastClick(5),'rs'); hold on;
        txt1 = strcat('\leftarrow ',resultChars(a,2),':',num2str(lastClick(5)));
        text(lastClick(9),lastClick(5),txt1)
        
        %Add next bksp button on plot
        [c index] = min(abs(final(:,9)-timeafterBksp))
        nextclick = final(index,:)
        plot(nextclick(9),nextclick(5),'rs') ; 
        txt1 = strcat('\leftarrow ',targetChars(a,2),':',num2str(nextclick(5)));
        text(nextclick(9),nextclick(5),txt1)
        
        % Add maximum pupil size marker on plot
        [c index] = max(abs(final(preindex:curindex,5)))
        maxi = final(index,:)
        plot(maxi(9),maxi(5),'rs') ; 
        txt1 = strcat('\leftarrow Maximum:',num2str(c));
        text(maxi(9),maxi(5),txt1)
       
        %TODO Add prepare click the bksp timing
        
        
        %Calculate the pupil change percent
        pupilPre = lastClick(5);
        pupilAft = closetDaPoint(5);
        maximum = max(final(:,5));
        percentBef = pupilPre./maximum;
        percentAfe = pupilAft./maximum;
        xlabel(strcat('BKSP button occured time :',num2str(bksptime)))
        ylabel('Pupil Size')
    end
end
%%
%Analysis the last sentence of the blocks
mfig(strcat('Focus points',c)); clf;
plot(bkspPupi(:,3),bkspPupi(:,4),'o');
xlabel('X position in keyboard')
ylabel('Y position in keyboard')
title('Foucs position in specific time period')