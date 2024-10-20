function [angles, centerPos, direction, len, displacement, fails]= calcAnglesPos(anchorAngle, oddAngle, visual, posOdd, design)
% Creates coordinates of the 4 extremities (2 lines) that will be displayed
%   Detailed explanation goes here

%%params construction    
    minVar = 2/3;
    maxVar = 3/2;
    startAngleDiff = [-2*pi/3, -pi/3, 0, pi/3, 2*pi/3, pi];
    addRandomAngleMin = -30;
    addRandomAngleMax = 30;
    anglesDeg = zeros(1,design.nbPositions);
    anglesDeg(find(anglesDeg == 0))=anchorAngle;
    anglesDeg(posOdd) = oddAngle;
    anglesRad = deg2rad(anglesDeg);
    addDisplacement_min_y = 0.3 * visual.pixPerDeg; 
    addDisplacement_max_y = 1.3 * visual.pixPerDeg;
    addDisplacement_min_x = -0.5; 
    addDisplacement_max_x = 0;

    
    diffFromVertical_min = 10;
    
    initCoord = [1;0];
    angles = cell(6,1);
    centerPos = calcCenterPositions(design.nbPositions, visual, design);

    
%%for this set
    t_startAngle = randi([0,round(2*pi*1000)])/1000 + Shuffle(startAngleDiff);
    t_addRandom = deg2rad(randi([addRandomAngleMin, addRandomAngleMax], 1,design.nbPositions));
    nb_failed = 0;
    for i = 1 : size(anglesRad,2)
        noangle = true;
        while noangle
            failed = false;
            length(i) = randi([round(2/3*1000), round(3/2*1000)],1)/1000 * design.refLength * visual.pixPerDeg;
            %length(i) = 3/2 * design.refLength * visual.pixPerDeg;
            startRotationMatrix{i} = [cos(t_startAngle(i)+t_addRandom(i)) -sin(t_startAngle(i)+t_addRandom(i)); sin(t_startAngle(i)+t_addRandom(i)) cos(t_startAngle(i)+t_addRandom(i))];
            angleRotationMatrix{i} = [cos(anglesRad(i)) -sin(anglesRad(i)); sin(anglesRad(i)) cos(anglesRad(i))];


            side1coord{i} = startRotationMatrix{i} * initCoord * length(i);
            side2coord{i} = angleRotationMatrix{i} * startRotationMatrix{i} * initCoord * length(i);


            %%checks orientations not in [-diffFromVertical, +diffFromVertical] from vertical and horizontal
            while (-diffFromVertical_min < mod(rad2deg(atan(side1coord{i}(2)/side1coord{i}(1))),90) && mod(rad2deg(atan(side1coord{i}(2)/side1coord{i}(1))),90) < diffFromVertical_min) ||...
                    (-diffFromVertical_min < mod(rad2deg(atan(side2coord{i}(2)/side2coord{i}(1))),90) && mod(rad2deg(atan(side2coord{i}(2)/side2coord{i}(1))),90) < diffFromVertical_min) 
                t_addRandom(i) = deg2rad(randi([addRandomAngleMin, addRandomAngleMax], 1,1));
                startRotationMatrix{i} = [cos(t_startAngle(i)+t_addRandom(i)) -sin(t_startAngle(i)+t_addRandom(i)); sin(t_startAngle(i)+t_addRandom(i)) cos(t_startAngle(i)+t_addRandom(i))];
                side1coord{i} = startRotationMatrix{i} * initCoord * length(i);
                side2coord{i} = angleRotationMatrix{i} * startRotationMatrix{i} * initCoord * length(i);
            end
            %%translation of the second side in the not crossed condition
            if design.condition == 0
                trans_vect = [randi([addDisplacement_min_x*1000, addDisplacement_max_x*1000],1,1)/1000*length(i); randi([round(addDisplacement_min_y*1000), round(addDisplacement_max_y*1000)],1,1)/1000];
                displacement{i} = [trans_vect(1)/length(i), trans_vect(2) / round(visual.pixPerDeg)];
                if mod(anglesRad(i),pi)==0
                    newtrans_vect = [(trans_vect(1)*cos(t_startAngle(i)+t_addRandom(i))-trans_vect(2)*sin(t_startAngle(i)+t_addRandom(i))); (trans_vect(1)*sin(t_startAngle(i)+t_addRandom(i))+trans_vect(2)*cos(t_startAngle(i)+t_addRandom(i)))];
                else
                    newtrans_vect = [(trans_vect(1)*cos(t_startAngle(i)+t_addRandom(i))-sign(anglesRad(i))*trans_vect(2)*sin(t_startAngle(i)+t_addRandom(i))); (trans_vect(1)*sin(t_startAngle(i)+t_addRandom(i))+sign(anglesRad(i))*trans_vect(2)*cos(t_startAngle(i)+t_addRandom(i)))];
                end
                point2coord{i} = translation(newtrans_vect,side2coord{i}, visual,0); % second side jittered
                sommet2coord{i} = translation(newtrans_vect,[0;0], visual,0);
                sommet1coord{i} = [0;0];
                point1coord{i} = side1coord{i}; 
            else
                displacement{i} = [0, 0];
                point2coord{i} = side2coord{i};
                sommet2coord{i} = [0;0];
                sommet1coord{i} = [0;0];
                point1coord{i} = side1coord{i}; 
            end
            %%translation in placeholder
            translation_v = findTranslation(point2coord{i},point1coord{i},sommet1coord{i}, sommet2coord{i}, design, visual);
            if ~translation_v
                failed = true;
            else
                newpoint2coord{i} = translation(translation_v, point2coord{i}, visual,0);
                newsommet2coord{i} = translation(translation_v, sommet2coord{i}, visual,0);
                newpoint1coord{i} = translation(translation_v, side1coord{i}, visual,0);
                newsommet1coord{i} = translation(translation_v, [0;0], visual,0);
                iter = 0;
                while   (newpoint1coord{i}(1)^2 + newpoint1coord{i}(2)^2 > ((design.placeholdersRadius - design.maxEdges)*visual.pixPerDeg)^2) ||...
                        (newsommet1coord{i}(1)^2 + newsommet1coord{i}(2)^2 > ((design.placeholdersRadius - design.maxEdges)*visual.pixPerDeg)^2)||...
                        (newpoint2coord{i}(1)^2 + newpoint2coord{i}(2)^2 > ((design.placeholdersRadius - design.maxEdges)*visual.pixPerDeg)^2) ||...
                        (newsommet2coord{i}(1)^2 + newsommet2coord{i}(2)^2 > ((design.placeholdersRadius - design.maxEdges)*visual.pixPerDeg)^2)
                    iter = iter+1;

                    translation_v = findTranslation(point2coord{i},point1coord{i},sommet1coord{i}, sommet2coord{i}, design, visual);
                    if ~translation_v
                        failed = true;
                        break
                    end
                    newpoint2coord{i} = translation(translation_v, point2coord{i}, visual,0);
                    newsommet2coord{i} = translation(translation_v, sommet2coord{i}, visual,0);
                    newpoint1coord{i} = translation(translation_v, point1coord{i}, visual,0);
                    newsommet1coord{i} = translation(translation_v, sommet1coord{i}, visual,0);
                    if iter > 100
                        failed = true;
                        break
                    end
                end
            end
            if ~failed
                noangle = false;
            else
                nb_failed = nb_failed + 1;
                fails(nb_failed, 1) = length(i)/(design.refLength * visual.pixPerDeg);
                fails(nb_failed, 2) = anglesDeg(i); 
            end
        end
        
        sommet2{i} = translation(translation_v + centerPos{i}, sommet2coord{i}, visual,1);
        sommet1{i} = translation(translation_v + centerPos{i}, sommet1coord{i}, visual,1);
        point2{i} = translation(translation_v + centerPos{i}, point2coord{i}, visual,1);
        point1{i} = translation(translation_v + centerPos{i}, point1coord{i}, visual,1);
        
       
        angles{i,1} = sommet1{i};
        angles{i,2} = sommet2{i};
        angles{i,3} = point1{i};
        angles{i,4} = point2{i};
        angles{i,5} = length(i);
        angles{i,6} = length(i);
        angles{i,7} = t_startAngle(i)+t_addRandom(i);
        
        direction{i} = [atan((point1coord{i}(2) - sommet1coord{i}(2))/(point1coord{i}(1) - sommet1coord{i}(1))), atan((point2coord{i}(2) - sommet2coord{i}(2))/(point2coord{i}(1) - sommet2coord{i}(1)))];
        len = length/visual.pixPerDeg;
        
    end
    if nb_failed == 0
        fails = 0;
    end
    

end

