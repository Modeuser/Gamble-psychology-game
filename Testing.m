Screen('Preference', 'SkipSyncTests', 1);

%training window
[training_win,~] = Screen('OpenWindow', 0, [0 0 0]);
Screen('Flip',training_win);

%%Obtain current computer screensize
set(0,'units','pixels');
compsize = get(0,'ScreenSize');
compsizex = compsize(:,3);
compsizey = compsize(:,4);

%%%%
%show bluex in top right corner
%%%%
shape_bluex = imread('bluex.png');
tex_bluex = Screen('MakeTexture', training_win, shape_bluex);
%based on screen size, make origin points for each corner
pos1x = compsizex*(1/4);
pos1y = compsizey*(1/4);
%use origin point instead of selective xy position to ensure 
%the aspect ratio of the image doesn't get distorted
Screen('DrawTexture', training_win, tex_bluex, [], [pos1x - 200,pos1y - 200,pos1x + 200,pos1y + 200]);

%%%%
%show greenpenta in top left corner
%%%%
shape_greenpenta = imread('greenpenta.png');
tex_greenpenta = Screen('MakeTexture', training_win, shape_greenpenta);
%based on screen size, make origin points for each corner
pos2x = compsizex*(3/4);
pos2y = compsizey*(1/4);
%use origin point instead of selective xy position to ensure 
%the aspect ratio of the image doesn't get distorted
Screen('DrawTexture', training_win, tex_greenpenta, [], [pos2x - 200,pos2y - 200,pos2x + 200,pos2y + 200]);

%%%%
%show pinkcircle in bottom left corner
%%%%
shape_pinkcircle = imread('pinkcircle.png');
tex_pinkcircle = Screen('MakeTexture', training_win, shape_pinkcircle);
%based on screen size, make origin points for each corner
pos3x = compsizex*(1/4);
pos3y = compsizey*(3/4);
%use origin point instead of selective xy position to ensure 
%the aspect ratio of the image doesn't get distorted
Screen('DrawTexture', training_win, tex_pinkcircle, [], [pos3x - 200,pos3y - 200,pos3x + 200,pos3y + 200]);

%%%%
%show redtri in bottom left corner
%%%%
shape_redtri = imread('redtri.png');
tex_redtri = Screen('MakeTexture', training_win, shape_redtri);
%based on screen size, make origin points for each corner
pos4x = compsizex*(3/4);
pos4y = compsizey*(3/4);
%use origin point instead of selective xy position to ensure 
%the aspect ratio of the image doesn't get distorted
Screen('DrawTexture', training_win, tex_redtri, [], [pos4x - 200,pos4y - 200,pos4x + 200,pos4y + 200]);

%%%%
%show current money
%%%%
money = "You currently have " + 4 + " dollar";
%convert to char since DrawFortmattedText doesn't work with string
money = convertStringsToChars(money);
%display money
DrawFormattedText(training_win, money, 'center', 'center', [255,255,255]);
Screen('FillRect',training_win, [0,0,0], [compsizex/2-200,compsizey/2-100,compsizex/2+200,compsizey/2+100]);




%test ending commands
Screen('Flip',training_win);
WaitSecs(1.5);
Screen('CloseAll');

%%%%%%%%%%%%%%%%
%testing user input dlg
%%%%%%%%%%%%%%%%%%%%%%%%
prompt = {'First name:','Last name:'};
profile = inputdlg(prompt, 'Please enter your name and profile',[1 35]);

%testing group input dlg
list = {'No ailments', 'Alcohol addication'};
[indx,tf] = listdlg('PromptString','What is your ailment?','SelectionMode','single','ListString',list);

%saving patient profile into a file
letterFirst = profile(1);
letterLast = profile(2);
letterFirst = char(letterFirst);
letterLast = char(letterLast);
letterLast = letterLast(1,1);
filename = "profile" + letterFirst + letterLast + "group" + indx + ".mat";
save(filename, 'indx')
%plus more variables as we want






