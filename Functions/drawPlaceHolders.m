function drawPlaceHolders(scr, design, ct, visual)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    for placeholder = 1:design.nbPositions
        Screen(scr.main,'FillOval',[240, 240, 240],[(scr.centerX+ct.centerPos{placeholder}(1) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerX+ct.centerPos{placeholder}(1) + design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) + design.placeholdersRadius*visual.pixPerDeg)]);
    end
    
end

