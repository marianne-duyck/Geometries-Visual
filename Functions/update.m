function update()

global info initSubj ageSubj Var1 Var2 Var3 Var4 Var5 Var6 Var7 Key1 Key2 validate subj age gender handness block cond


    if strcmp(get(initSubj,'string'),'xxx') ||strcmp(get(ageSubj,'string'),'xx') ||length(find([get(Var1,'value') get(Var2,'value') get(Var3,'value') get(Var4,'value') get(Var5,'value') get(Var6,'value') get(Var7,'value')]))~=1||length(find([get(Key1,'value') get(Key2,'value')]))~=1
        set(validate,'enable','off')
    else
        set(validate,'enable','on')
    end
    
    
    if strcmp(get(validate,'enable'),'on') % correspond ? on mais callback de validation
        % Output Variables
        subj = get(initSubj,'string');
        age = str2num(get(ageSubj,'string'));

        b = get(handness,'value');
        if b == 1
            handness = 'Right';
        elseif b==2
            handness = 'Left';
        end
        
        c = get(gender,'value');
        if c==1
            gender = 'F';
        elseif c==2
            gender = 'M';
        end
        
        d = find([get(Key1,'value') get(Key2,'value')]);
        if d==1
            cond = 1;
        elseif d==2
            cond = 0;
        end
        
        e = find([get(Var1,'value') get(Var2,'value') get(Var3,'value') get(Var4,'value') get(Var5,'value') get(Var6,'value') get(Var7,'value')]);
        if e==1
            block = 1;
        elseif e==2
            block = 2;
        elseif e==3
            block = 3;
        elseif e==4
            block = 4;
        elseif e==5
            block = 5;
        elseif e==6
            block = 6;
        elseif e==7
            block = 7;
        end

        
        %close(gcf);

    end    
end