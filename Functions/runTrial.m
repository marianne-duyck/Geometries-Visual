function dataT = runTrial(ct, visual, scr, design) % pour current trial

    % clear keyboard buffer
    FlushEvents('KeyDown');
    [yc, Fsc] = audioread('correct.wav');
    [yi, Fsi] = audioread('incorrect.wav');
    % fixation before angles diplay including placeholders
    Screen(scr.main,'FillRect',visual.bgColor);
    Screen(scr.main,'FillOval',ct.fixCol,ct.fixPos);
    drawPlaceHolders(scr, design, ct, visual);
    fixOn = Screen(scr.main,'Flip');
    WaitSecs(ct.fixDur);
    
    % fixation and angles display
    Screen(scr.main,'FillRect',visual.bgColor);
    Screen(scr.main,'FillOval',ct.fixCol,ct.fixPos);
    drawPlaceHolders(scr, design, ct, visual);
%     Screen('BlendFunction', scr.main, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA,[]);
    
    t0 = GetSecs;
    resp = false;
    displayed = false;

    while ~resp
        [x,y,buttons] = GetMouse;
        while ~any(buttons); % wait for press
            [x,y,buttons] = GetMouse;
            Screen(scr.main,'FillRect',visual.bgColor);
            Screen(scr.main,'FillOval',ct.fixCol,ct.fixPos);
            drawPlaceHolders(scr, design, ct, visual);
            
            if (GetSecs - t0) < design.angleDu;
                for i = 1:size(ct.angles,1)
                    Screen('BlendFunction', scr.main, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA,[]);
                    Screen('DrawLines',scr.main,[ct.angles{i,1}(1) ct.angles{i,3}(1) ; ct.angles{i,1}(2) ct.angles{i,3}(2)], 3, visual.fgColor, [],1);
                    Screen('DrawLines',scr.main,[ct.angles{i,2}(1) ct.angles{i,4}(1) ; ct.angles{i,2}(2) ct.angles{i,4}(2)], 3, visual.fgColor, [],1);;
                end
            end
            if checkTarPress(KbName('ESCAPE')); 
                Screen('CloseAll');
                ListenChar(0);
            end
            [vbl, onset] = Screen(scr.main,'Flip');

            if ~displayed;
                t0 = onset;
                displayed = true;
            end     
        end
        [inArea, position] = checkMouseClickPosition(scr,ct,design,visual,x,y);
        if inArea && (GetSecs - t0) > design.minDu;
            resp = true;
            tResp = GetSecs - t0;
        end
            
    end

drawPlaceHoldersResp(scr, design, ct, visual,position);
SetMouse(scr.centerX, scr.centerY, scr.expScreen)
Screen(scr.main,'FillRect',visual.bgColor);
Screen(scr.main, 'Flip');
if ct.posOdd == position;
    dataT.correct = 1; 
    sound(yc, Fsc);
else
    dataT.correct = 0;
    sound(yi, Fsi);
end

WaitSecs(ct.iti);


% Output variables
dataT.resp = position; dataT.time = tResp;

end