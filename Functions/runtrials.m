function runtrials(design,datFile,visual,scr, moneyFile, info)


Screen(scr.main, 'Flip');
GetSecs;
WaitSecs(.2);
FlushEvents('keyDown');

% consignes
imConsigne = imread(sprintf('%d_%d_%s.jp2',info.cond, design.anchorAngle, info.lang), 'ReductionLevel', 1);
handle = Screen('MakeTexture',scr.main, imConsigne);
Screen(scr.main,'FillRect',visual.bgColor);
Screen('DrawTexture',scr.main, handle,[], []);
Screen(scr.main,'Flip');
KbWait; 

% create data fid
datFid = fopen(datFile, 'w');

% unify keynames for different operating systems
KbName('UnifyKeyNames');
percent_correct_total = 0;
percent_correct = 0;
nb_correct = 0;
nb_correct_total = 0;
nb_trial_block = 0;

for t = 1: design.nbTrials
    ct = design.trials(t);
    nb_trial_block = nb_trial_block +1;
    dataT = runTrial(ct,visual,scr, design);
    nb_correct = nb_correct + dataT.correct;
    nb_correct_total = nb_correct_total + dataT.correct;
    percent_correct = nb_correct / nb_trial_block * 100;
    percent_correct_total = nb_correct_total / t * 100;

    % write to datFile
    dataStr = sprintf('%i\t%i\t%i\t%i\t%i\t%i\t%i\t%4.2f\t%i\n', t,design.condition, design.trials(t).anchorAngle, design.trials(t).diffAngle, design.trials(t).oddAngle, design.trials(t).posOdd, dataT.resp, dataT.time, dataT.correct);

    % write data to datFile
    fprintf(datFid,dataStr);
    
    if ~mod(t,design.break)
        Screen('TextFont',scr.main, 'Times');
        Screen('TextSize',scr.main, 30);
        TextWidth_0 =  Screen('TextBounds',scr.main, sprintf('%i / %i',t,design.nbTrials));
        DrawFormattedText(scr.main, sprintf('%i / %i',t,design.nbTrials),scr.centerX-TextWidth_0(3)/2,scr.centerY/2,[0 0 0],[],[],[],[],[]);
        Screen('TextSize',scr.main, 20);
        if (info.lang == 'EN')
            TextWidth_1 = Screen('TextBounds',scr.main, sprintf('This part: %4.2f%% correct - You earned %4.2feur but could have earned %4.2feur',percent_correct, nb_correct*design.amountPerTrial, design.break*design.amountPerTrial)); 
            Screen('DrawText',scr.main, sprintf('This part: %4.2f%% correct - You earned %4.2feur but could have earned %4.2feur',percent_correct, nb_correct*design.amountPerTrial, design.break*design.amountPerTrial),scr.centerX-TextWidth_1(3)/2,scr.centerY+1.5*visual.pixPerDeg,[0 125 125]);

        else
            TextWidth_1 = Screen('TextBounds',scr.main, sprintf('Cette partie: %4.2f%% corrects - Vous gagnez %4.2feur mais auriez pu avoir %4.2feur',percent_correct, nb_correct*design.amountPerTrial, design.break*design.amountPerTrial)); 
            Screen('DrawText',scr.main, sprintf('Cette partie: %4.2f%% corrects - Vous gagnez %4.2feur mais auriez pu avoir %4.2feur',percent_correct, nb_correct*design.amountPerTrial, design.break*design.amountPerTrial),scr.centerX-TextWidth_1(3)/2,scr.centerY+1.5*visual.pixPerDeg,[0 125 125]);
        end
        if (info.lang == 'EN')
            TextWidth_2 = Screen('TextBounds',scr.main, sprintf('Total: %4.2f%% correct - You earned %4.2feur but could have earned %4.2feur',percent_correct_total,nb_correct_total*design.amountPerTrial, t*design.amountPerTrial)); 
            DrawFormattedText(scr.main, sprintf('Total: %4.2f%% correct - Vous gagnez %4.2feur but could have earned %4.2feur',percent_correct_total,nb_correct_total*design.amountPerTrial, t*design.amountPerTrial),scr.centerX-TextWidth_2(3)/2,scr.centerY+3.5*visual.pixPerDeg,[125 125 0]);
        else
            TextWidth_2 = Screen('TextBounds',scr.main, sprintf('Total: %4.2f%% corrects - Vous gagnez %4.2feur mais auriez pu avoir %4.2feur',percent_correct_total, nb_correct_total*design.amountPerTrial, t*design.amountPerTrial)); 
            DrawFormattedText(scr.main, sprintf('Total: %4.2f%% corrects - Vous gagnez %4.2feur mais auriez pu avoir %4.2feur',percent_correct_total, nb_correct_total*design.amountPerTrial, t*design.amountPerTrial),scr.centerX-TextWidth_2(3)/2,scr.centerY+3.5*visual.pixPerDeg,[125 125 0]);
        end
        
        Screen(scr.main,'Flip');
        KbWait; 
        nb_trial_block = 0;
        percent_correct = 0;
        nb_correct = 0;
    end 
end

fclose(datFid);
% adds to earnings file
moneyFid = fopen(moneyFile, 'a+');
moneyStr = sprintf('%4.2f\t%4.2f\n',percent_correct_total, nb_correct_total*design.amountPerTrial);
fprintf(moneyFid, moneyStr);
fclose(moneyFid);
% that's all folks if last block
if info.nblock == 7
    imEnd = imread(ct.imEnd);
    handle = Screen('MakeTexture',scr.main, imEnd);
    Screen('DrawTexture',scr.main, handle,[], []);
    Screen(scr.main,'Flip');
    WaitSecs(1);
end
Screen('CloseAll');


end