textAreaPosi = [1920;268]
parentPath=pwd()
filepath = strcat('/data/textArea/')
fileNFix = strcat(filepath,'/fixation.dat');
path = fullfile(parentPath,fileNFix);
gaze = ReadData(path,12)

%Get time period of whole entry procedure
timeMousStart = cellfun(@str2double,gaze(3,9));
timeMousEnd = cellfun(@str2double,gaze(length(gaze),9));
mousePeriod = timeMousEnd - timeMousStart;
x = mousePeriod/10 + .001
timePeriod = int16(x)+1

%%Group the raw data based on the time period
% Need to figure out should analyze the fixation or data point
gazeDou = cellfun(@str2double,gaze(3:end,:))
clearGaze = ClearFixationInvalidData(gazeDou)
ypos = clearGaze(:,3) <= textAreaPosi(2);
gazeXpo = clearGaze(ypos,:);% get fixation when look at text area

count1=0
count2=0
count3=0
count4=0
count5=0
count6=0
count7=0
count8=0
count9=0
count10=0

countTotal = [];
%%Point to the time period for each data point
for c = 1: length(gazeXpo)
    time = gazeXpo(c,9);
    period = int16((time-timeMousStart)/timePeriod) + 1
    switch period
        case 1
            count1 = count1+1
            countTotal(1) = count1
        case 2
            count2 = count2 +1
            countTotal(2) = count2
        case 3
            count3 = count3 +1
            countTotal(3) = count3
        case 4
            count4 = count4 +1
            countTotal(4) = count4
        case 5
            count5 = count5 +1
            countTotal(5) = count5
        case 6
            count6 = count6 +1
             countTotal(6) = count6
        case 7
            count7 = count7 +1
             countTotal(7) = count7
        case 8
            count8 = count8 +1
             countTotal(8) = count8
        case 9
            count9 = count9 +1
             countTotal(9) = count9
        case 10
            count10 = count10 +1
            countTotal(10) = count10
    end
end
bar(countTotal)


