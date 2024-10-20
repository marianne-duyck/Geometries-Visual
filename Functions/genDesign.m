function design = genDesign(info,fileDir,visual,scr)

% Variables design
design.condition = info.cond;
design.block = info.block;
design.anchorAngleCrossed = [25, 55, 80, 90, 100, 125, 155];% 5 distrators 
design.anchorAngleNotCrossed = [0, 10, 25, 55, 80, 90, 100, 125];% 5 distrators 

if design.condition == 1
    design.anchorAngle = design.anchorAngleCrossed(design.block);    
elseif design.condition == 0
    design.anchorAngle = design.anchorAngleNotCrossed(design.block);
end
    
%design.oddDiffAngle = [-12, -9, -6, -3, 3, 6, 9, 12];
if (design.anchorAngle == 10)
    design.oddDiffAngle = [-10, -7, -3, 3, 7, 12, 18];
elseif (design.anchorAngle == 80)
    design.oddDiffAngle = [-18, -12, -7, -3, 3, 7, 10, 12, 18];
elseif (design.anchorAngle == 100)
    design.oddDiffAngle = [-18, -10, -12, -7, -3, 3, 7, 12, 18];
else
    design.oddDiffAngle = [-18, -12, -7, -3, 3, 7, 12, 18];
end
    
%design.oddDiffAngle = [-18,18];

design.nbPositions = 6;
design.nbTrialsPerCond = 3;
design.nbTrials = size(design.anchorAngle,2) * design.nbTrialsPerCond * design.nbPositions * size(design.oddDiffAngle,2);

% display
design.bigRadius = 6; %cm
design.placeholdersRadius = 2.5; %cm
design.maxEdges = 0.2; % dist min from placeholder edges
design.refLength = 1.5;

% Variables autres constantes
% space
design.centerX = visual.scrCenter(1);
design.centerY = visual.scrCenter(2);
design.fiSi = round(0.2*visual.pixPerDeg);  % fixation dot size pix
design.fiCol = visual.fgColor; 


% time  
design.fiDur = 0.2;                          % fixation duration 
design.fiJi = 0.400;                        % fixation jitter (added to the initial fixation)
design.angleDu = 5;                     % angle presentation duration 
design.iti = 0.5;                         % inter-trial interval
design.break = round(design.nbTrials/4);
design.minDu = 0.250;                   % minimum duration of display before answer                                         

%money
design.amountMaxPerBlock = 2; %?
design.amountPerTrial = design.amountMaxPerBlock / design.nbTrials;

t = 0;
for i = 1:size(design.anchorAngle,2)
    for k = 1:size(design.oddDiffAngle,2)
        for j = 1:design.nbPositions
            for l = 1: design.nbTrialsPerCond
               t = t + 1;
               trial(t).anchorAngle = design.anchorAngle(i);
               trial(t).oddAngle = design.oddDiffAngle(k)+design.anchorAngle(i);
               trial(t).diffAngle = design.oddDiffAngle(k);
               [trial(t).angles, trial(t).centerPos, trial(t).direction, trial(t).length, trial(t).displacement, trial(t).fails] = calcAnglesPos(design.anchorAngle(i), trial(t).oddAngle, visual, j, design);
               trial(t).posOdd = j;
               trial(t).angleDu = design.angleDu;
               trial(t).iti = design.iti;
               % Fix
               trial(t).fixCol = design.fiCol;
               trial(t).fixPos = round([design.centerX design.centerY design.centerX design.centerY]+[-design.fiSi -design.fiSi design.fiSi design.fiSi]./2);
               trial(t).fixDur = design.fiDur + design.fiJi*rand; 
               trial(t).imEnd = 'that''s all folks.jpg';
           end 
        end 
    end
    
end
design.trials = trial(randperm(t));
save(sprintf('%s%s_%i_%i_%i_%i_%s.mat',fileDir,info.name,info.cond,info.block,info.nblock,info.blockNum, date),'info','design','visual','scr');


end