function visual = useful_visual(scr)

visual.bgColor = [200 200 200];
visual.fgColor = [0 0 0];

visual.pixPerDeg = va2pix(1,scr);
visual.scrCenter = [scr.centerX;scr.centerY];

% set Priority of window activities to Maximum
priorityLevel=MaxPriority(scr.main);
Priority(priorityLevel);


end
