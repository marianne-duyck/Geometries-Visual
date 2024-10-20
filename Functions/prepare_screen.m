function scr = prepare_screen

%HideCursor;
ShowCursor(2)

% Chooses the expscreen among all the available screens
scr.allScreens = Screen('Screens');
scr.expScreen  = max(scr.allScreens);

% Variables regarding the screen
scr.subDist = 57;   % subject distance (cm)
scr.refRate = 100;
[scr.xres, scr.yres] = Screen('WindowSize', scr.expScreen);
%scr.width   = 400; % monitor (mm)
%scr.height  = 300;
scr.multisampling = 0;%16; % (for antialiasing)
scr.width = 285;
scr.height = 180;
% skip tests
Screen('Preference','SkipSyncTests', 1)
% Open window
[scr.main,scr.rect] = Screen('OpenWindow',scr.expScreen,[0 0 0],[],[],[],[],scr.multisampling,[],[]);
%[scr.main,scr.rect] = Screen(scr.expScreen,'OpenWindow',[0 0 0],[0 0 400 400]);

% Changes frame rate and display it
Screen('FrameRate', scr.main, 2, scr.refRate);
scr.hz = Screen('FrameRate',scr.main);  
fprintf(1,'\n\nFrame rate is %6.2f Hz.\n\n',scr.hz);

scr.fd   = 1000/scr.hz;                 % frame duration [ms]
scr.hash = scr.fd/2000;                 % hash time [ms] CHECK


% Get Screen Center Coordinates
[scr.centerX, scr.centerY] = WindowCenter(scr.main);

% put the mouse cursor at screen center
SetMouse(scr.centerX, scr.centerY, scr.expScreen)
ShowCursor(0, scr.expScreen)

% Give the display a moment to recover from the change of display mode when
% opening a window. It takes some monitors and LCD scan converters a few seconds to resync.
WaitSecs(2);

end