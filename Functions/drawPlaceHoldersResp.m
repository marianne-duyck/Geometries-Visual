function drawPlaceHoldersResp(scr, design, ct, visual, positionClicked)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
move = 10; %pix
Screen(scr.main,'FillRect',visual.bgColor);
    for placeholder = 1:design.nbPositions
        if placeholder == positionClicked
            Screen(scr.main,'FillOval',[240, 240, 240],[(scr.centerX+ct.centerPos{placeholder}(1) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) + move - design.placeholdersRadius*visual.pixPerDeg),(scr.centerX+ct.centerPos{placeholder}(1) + design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2)+ move + design.placeholdersRadius*visual.pixPerDeg)]);

        else
            Screen(scr.main,'FillOval',[240, 240, 240],[(scr.centerX+ct.centerPos{placeholder}(1) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerX+ct.centerPos{placeholder}(1) + design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) + design.placeholdersRadius*visual.pixPerDeg)]);

        end
    end
Screen(scr.main, 'Flip')
WaitSecs(0.1)

Screen(scr.main,'FillRect',visual.bgColor);
    for placeholder = 1:design.nbPositions
        if placeholder == positionClicked
            Screen(scr.main,'FillOval',[240, 240, 240],[(scr.centerX+ct.centerPos{placeholder}(1) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerX+ct.centerPos{placeholder}(1) + design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) + design.placeholdersRadius*visual.pixPerDeg)]);

        else
            Screen(scr.main,'FillOval',[240, 240, 240],[(scr.centerX+ct.centerPos{placeholder}(1) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) - design.placeholdersRadius*visual.pixPerDeg),(scr.centerX+ct.centerPos{placeholder}(1) + design.placeholdersRadius*visual.pixPerDeg),(scr.centerY+ct.centerPos{placeholder}(2) + design.placeholdersRadius*visual.pixPerDeg)]);

        end
    end
Screen(scr.main, 'Flip');
WaitSecs(0.25);
end