function [translationVector] = findTranslation(point2, point1, sommet1, sommet2, design, visual)
%Use square that surrounds the solutions (i.e square around the intersection of the 4 circles)

maxRadius = (design.placeholdersRadius - design.maxEdges)*visual.pixPerDeg;

trans_min_x = max(max(max(-point1(1), -point2(1)),-sommet1(1)),-sommet2(1))-maxRadius;
trans_max_x = min(min(min(-point1(1), -point2(1)),-sommet1(1)),-sommet2(1))+maxRadius;
trans_min_y = max(max(max(-point1(2), -point2(2)),-sommet1(1)), -sommet2(2))-maxRadius;
trans_max_y = min(min(min(-point1(2), -point2(2)),-sommet1(1)), -sommet2(2))+maxRadius;

if trans_min_x > trans_max_x || trans_min_y > trans_max_y
    translationVector = false;
    %disp "did_not_find_translation"
else
    trans_x = randi([round(trans_min_x*1000), round(trans_max_x*1000)],1,1)/1000;   
    trans_y = randi([round(trans_min_y*1000), round(trans_max_y*1000)],1,1)/1000;
    translationVector = [trans_x ; trans_y];
end

end

