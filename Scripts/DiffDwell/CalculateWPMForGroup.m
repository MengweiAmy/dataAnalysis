function [wpm,ksps] = CalculateWPMForGroup(group,clickGroup)
    tGazStgrp1= group(1,10);
    tGazEndgrp1 = group(length(group),10);
    grp1Period = tGazEndgrp1 - tGazStgrp1;
    str=cellstr(clickGroup(:,2));
    ids = []
    for c = 1: length(clickGroup)
        if strcmp(char(str(c)),'bksp') == 0
            ids = cat(1,ids,c);
         end
    end
    
    %WPM will ignore the bksp stroke
    glettersize = length(clickGroup(ids,:));
    wpm = WPM(glettersize,grp1Period)
    
    %ksps will conclude all the key stroke, include the bksp
    ksps = KSPS(length(clickGroup),grp1Period)
end