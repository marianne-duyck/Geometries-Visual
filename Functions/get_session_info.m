function  [subj age gender handness block cond] =  get_session_info()

global info initSubj ageSubj Var1 Var2 Var3 Var4 Var5 Var6 Var7 Key1 Key2 validate subj age gender handness block cond

info = figure;
bg_color = [1 1 1].* [rand(1) rand(1) rand(1)];
text_color = [1 1 1] - bg_color;
set(info,'MenuBar','none');
screenSize = get(0,'ScreenSize'); 

set(info,'Name','Experiment Information','NumberTitle','off','Position',[screenSize(3)/2-150 screenSize(4)/2-200 300 400],'Color',bg_color) %'Position'



% Categories Names
textInit = uicontrol(gcf,'style','text','position',[20 360 100 25],'string', 'Initiales:');
textAge = uicontrol(gcf,'style','text','position',[20 320 50 25],'string', 'Age:');
textHandness = uicontrol(gcf,'style','text','position',[20 280 120 25],'string', 'Handedness:');
textBlockNumber = uicontrol(gcf,'style','text','position',[160 220 100 25],'string', 'Block Number:');
textCondition = uicontrol(gcf,'style','text','position',[20 220 100 25],'string', 'Condition:');%170
set([textInit, textAge, textBlockNumber,textHandness,textCondition],'FontWeight','bold','FontName','Arial','BackgroundColor',bg_color,'FontSize',12,'ForegroundColor',text_color);

% Validation
validate = uicontrol(gcf,'style','push','position',[100 50 100 30], 'string', 'Ok','enable','off','callback','close(gcf)');

% Response
initSubj = uicontrol('style','edit','position',[160 360 100 25],'Max',1,'string','xxx','callback','get(initSubj,''string'')','callback','update');
ageSubj = uicontrol('style','edit','position',[80 320 60 25],'Max',1,'string','xx','callback','get(ageSubj,''string'')','callback','update');
gender = uicontrol('Style','popup','string','F|M','Position',[150 320 120 25]);
handness = uicontrol('Style','popup','string','Right|Left','Position',[150 280 120 25]);
set([initSubj, ageSubj, gender, handness],'FontName','Arial','FontSize',12);

Var1 = uicontrol(gcf,'style','Radio','Position',[170 180 60 25],'string','1','callback','update');
Var2 = uicontrol(gcf,'style','Radio','Position',[170 160 60 25],'string','2','callback','update');
Var3 = uicontrol(gcf,'style','Radio','Position',[170 140 60 25],'string','3','callback','update');
Var4 = uicontrol(gcf,'style','Radio','Position',[200 120 60 25],'string','4','callback','update');
Var5 = uicontrol(gcf,'style','Radio','Position',[230 180 60 25],'string','5','callback','update');
Var6 = uicontrol(gcf,'style','Radio','Position',[230 160 60 25],'string','6','callback','update');
Var7 = uicontrol(gcf,'style','Radio','Position',[230 140 60 25],'string','7','callback','update');

set([Var1,Var2,Var3, Var4, Var5, Var6, Var7],'FontWeight','bold','FontName','Arial','FontSize',12,'ForegroundColor',text_color);
Key1 = uicontrol(gcf,'style','Radio','Position',[30 170 100 25],'string','Crossed','callback','update');
Key2 = uicontrol(gcf,'style','Radio','Position',[30 150 100 25],'string','Not crossed','callback','update');
set([Key1,Key2],'FontWeight','bold','FontName','Arial','FontSize',12,'ForegroundColor',text_color);

uiwait(gcf);
subj;age;gender;handness;block;cond;

end
