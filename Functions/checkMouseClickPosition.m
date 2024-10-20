 function [inArea, positionNumber] = checkMouseClickPosition(scr,ct,design,visual,x,y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if ((x-(ct.centerPos{1}(1)+scr.centerX))^2 + (y-(ct.centerPos{1}(2)+scr.centerY))^2) <= ((design.placeholdersRadius*visual.pixPerDeg)^2);
    inArea = true;
    positionNumber = 1;
elseif ((x-(ct.centerPos{2}(1)+scr.centerX))^2 + (y-(ct.centerPos{2}(2)+scr.centerY))^2) <= ((design.placeholdersRadius*visual.pixPerDeg)^2);
    inArea = true;
    positionNumber = 2;
elseif ((x-(ct.centerPos{3}(1)+scr.centerX))^2 + (y-(ct.centerPos{3}(2)+scr.centerY))^2) <= ((design.placeholdersRadius*visual.pixPerDeg)^2);
    inArea = true;
    positionNumber = 3;
elseif ((x-(ct.centerPos{4}(1)+scr.centerX))^2 + (y-(ct.centerPos{4}(2)+scr.centerY))^2) <= ((design.placeholdersRadius*visual.pixPerDeg)^2);
    inArea = true;
    positionNumber = 4;
elseif ((x-(ct.centerPos{5}(1)+scr.centerX))^2 + (y-(ct.centerPos{5}(2)+scr.centerY))^2) <= ((design.placeholdersRadius*visual.pixPerDeg)^2);
    inArea = true;
    positionNumber = 5;
elseif ((x-(ct.centerPos{6}(1)+scr.centerX))^2 + (y-(ct.centerPos{6}(2)+scr.centerY))^2) <= ((design.placeholdersRadius*visual.pixPerDeg)^2);
    inArea = true;
    positionNumber = 6;
else
    inArea = false;
    positionNumber = NaN;

end

end

