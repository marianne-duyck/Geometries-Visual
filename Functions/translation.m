% Translation puis transformation des coordonn?es du point en pixels

function [newCoord] = translation(vector, oldCoord, visual, add_center)
% translation and if add_center, translate coordonnates centered on (0,0)...
% to ones centered on screen center
if add_center
    newCoord = oldCoord + vector + visual.scrCenter;
else
    newCoord = oldCoord + vector;
end

end