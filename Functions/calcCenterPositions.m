function [centerPos] = calcCenterPositions(nbAngles, visual, design)
% fonction qui calcule en coordonnees cartesiennes, les coordonnes du
% centre des differents patchs disposes en cercle, evitant les positions
% centrales haut et bas

radius = design.bigRadius;

initCoord = [0;radius]; % starts with the vertical vector

for k = 1:nbAngles
    teta(k) = 2*pi/nbAngles/2 + (k-1) * 2*pi/nbAngles;
    angleRotationMatrix = [cos(-teta(k)) -sin(-teta(k)); sin(-teta(k)) cos(-teta(k))];
    %centerPos{k} = angleRotationMatrix * initCoord;
    centerPos{k} = angleRotationMatrix * initCoord * visual.pixPerDeg;
end

end

