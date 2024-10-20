%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Experiment RightAngle - MAD                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clear mex;

commandwindow;

p = path;
addpath('Functions/');
addpath('Consignes/');

% get or create info subj
mainDir = cd;
d = dir(sprintf('%s%sData',mainDir,filesep));
isub = [d(:).isdir];
existing_subjs = {d(isub).name}';
existing_subjs(ismember(existing_subjs,{'.','..'})) = [];
new = input('New participant (y/n) : ','s');
if new == 'y'
    info.name = input('Initiales : ','s');
    info.age = input('Age : ','s');
    info.genre = input('Gender (M/F) : ', 's');
    info.handedness = input('Handedness (L/R): ','s');
else
    existing_subjs'
    info.name = input('which ? ','s');
end

info.cond = input('condition (0=not crossed/1=crossed) : ');
info.nblock = input('block nbr : ');
info.lang = input('language (FR = french, EN = english) : ', 's');

if ~isdir(sprintf('Data%s%s',filesep,info.name));
    mkdir(sprintf('Data%s%s',filesep,info.name));
end

ListenChar(2)

% datafile creation 1
subFilesdir = dir(sprintf('%s%sData%s%s%s*.dat',cd,filesep,filesep,info.name,filesep));
info.blockNum = length(subFilesdir) + 1;

fileDir = sprintf('%s%sData%s%s',cd,filesep,filesep,info.name,filesep);


% Screen Preparation and useful visual variables
scr = prepare_screen;
visual = useful_visual(scr);

% Identification du bloc
if info.cond == 1
    if info.nblock == 1
        run_order = Shuffle([1:1:7]);
        %run_order = [1:1:7]; %#to run blocks in order
        dlmwrite(sprintf('%s%s_%s.csv',fileDir,info.name,'order_crossed'),run_order, ';');
    else 
        run_order = dlmread(sprintf('%s%s_%s.csv',fileDir,info.name,'order_crossed'),';');
    end
elseif info.cond == 0
    if info.nblock == 1
        run_order = Shuffle([1:1:8]);
        %run_order = [1:1:8]; %#to run blocs in order
        dlmwrite(sprintf('%s%s_%s.csv',fileDir,info.name,'order_not_crossed'),run_order, ';');
    else 
        run_order = dlmread(sprintf('%s%s_%s.csv',fileDir,info.name,'order_not_crossed'),';');   
    end
end
    
info.block = run_order(info.nblock);


% datafile creation 2
datFile = sprintf('%s%s_%i_%i_%i_%i_%s.dat',fileDir,info.name,info.cond,info.block,info.nblock,info.blockNum,date);

% Creation des essais du bloc
design = genDesign(info,fileDir,visual,scr);

% earnings_file creation
moneyFile = sprintf('%s%s_earnings.txt', fileDir, info.name);

% Run Trials
runtrials(design,datFile,visual,scr, moneyFile, info);

ListenChar(0);
path(p);



