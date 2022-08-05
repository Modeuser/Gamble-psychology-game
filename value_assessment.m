function value_assessment

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% Cognitive capacity for value assessment paradigm %%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Screen('Preference', 'SkipSyncTests', 1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% First we obtain the profile information of the participant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%using inputdlg to obtain name of participant
prompt = {'First name:','Last name:'};
profile = inputdlg(prompt, 'Please enter your name',[1 35]);

%using listdlg to obtain group of participant
list = {'No ailments', 'Alcohol addication'};
[indx,tf] = listdlg('PromptString','What is your ailment?','SelectionMode','single','ListString',list);

%their profile information will be saved along with their response data at the
%end of the experiment.

try

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% Experiment phase 1 setup codes
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %present the participants with instructions
    local_phase1instructions()
    %once they are ready, a click will register and setup continues
    
    % # of training trials, can be changed to as many as you'd like
    training_trials = 10;
    % # assessment trials, can be changed to as many as you'd like
    assess_trials = 20;
    
    %did they get the bonus?
    bonus = 0;

    %show cursor
    ShowCursor('Arrow');
    
    %default money for training phase
    money = 100;
    
    %Obtain current computer screensize
    set(0,'units','pixels');
    compsize = get(0,'ScreenSize');
    compsizex = compsize(:,3);
    compsizey = compsize(:,4);
    
    %setup window
    [win,~] = Screen('OpenWindow', 0, [0 0 0]);
    
    %%%%%%%%%%%%%%%%%% EXPERIMENT PHASE 1: TRAINING %%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% Load shapes into training window
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %load in blux
    shape_bluex = imread('bluex.png');
    tex_bluex = Screen('MakeTexture', win, shape_bluex);
    
    %load in greenpenta
    shape_greenpenta = imread('greenpenta.png');
    tex_greenpenta = Screen('MakeTexture', win, shape_greenpenta);
    
    %load in pinkcircle
    shape_pinkcircle = imread('pinkcircle.png');
    tex_pinkcircle = Screen('MakeTexture', win, shape_pinkcircle);
    
    %load in redtri
    shape_redtri = imread('redtri.png');
    tex_redtri = Screen('MakeTexture', win, shape_redtri);
    
    %load in whitesqu
    shape_whitesqu = imread('whitesqu.png');
    tex_whitesqu = Screen('MakeTexture', win, shape_whitesqu);
    
    %load in yellowpill
    shape_yellowpill = imread('yellowpill.png');
    tex_yellowpill = Screen('MakeTexture', win, shape_yellowpill);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% Assign values to each shape
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Values of the shapes must be random for each participant that runs the
    %script. This will control for the possibility that shapes/colors
    %might have innate value for some people.
    
    %However, the value assigned to each shape CANNOT be random for each
    %trial. Thus, these value-assignment codes are outside of the 'for'
    %loop that repeats the trials.
    
    %But they will be randomized the next time you run this script for
    %another participant.
    
    %range of values to assign:
    value_matrix = [-2,-1,0,1,2; 8,9,10,11,12; -8,-9,-10,-11,-12; 3,4,5,6,7; -3,-4,-5,-6,-7; -18,-19,-20,-21,-22];
    
    %assign a random row of values to bluex and remove that row
    bluex_row = randi(size(value_matrix,1));
    bluex_value = value_matrix(bluex_row,:);
    value_matrix(bluex_row,:) = [];
    
    %assign a random row of values to greenpenta and remove that row
    greenpenta_row = randi(size(value_matrix,1));
    greenpenta_value = value_matrix(greenpenta_row,:);
    value_matrix(greenpenta_row,:) = [];
    
    %assign a random row of values to pinkcircle and remove that row
    pinkcircle_row = randi(size(value_matrix,1));
    pinkcircle_value = value_matrix(pinkcircle_row,:);
    value_matrix(pinkcircle_row,:) = [];
    
    %assign a random row of values to redtri and remove that row
    redtri_row = randi(size(value_matrix,1));
    redtri_value = value_matrix(redtri_row,:);
    value_matrix(redtri_row,:) = [];
    
    %assign a random row of values to whitesqu and remove that row
    whitesqu_row = randi(size(value_matrix,1));
    whitesqu_value = value_matrix(whitesqu_row,:);
    value_matrix(whitesqu_row,:) = [];
    
    %assign a random row of values to yellowpill and remove that row
    yellowpill_row = randi(size(value_matrix,1));
    yellowpill_value = value_matrix(yellowpill_row,:);
    value_matrix(yellowpill_row,:) = [];
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Drawing the shapes in each trial
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%
    %set up the original position of where to draw
    %%%%
    
    %top left corner position
    pos1x = compsizex*(1/4);
    pos1y = compsizey*(1/4);
    
    %top right corner position
    pos2x = compsizex*(3/4);
    pos2y = compsizey*(1/4);
    
    %bottom left corner position
    pos3x = compsizex*(1/4);
    pos3y = compsizey*(3/4);
    
    %bottom right corner position
    pos4x = compsizex*(3/4);
    pos4y = compsizey*(3/4);
    
    %%%%
    %randomize the position of shapes in each trial
    %%%%
    for trials = 1:training_trials
        
        %%%%%%%%%%%%%%%%%%%
        %%%Drawing the training trials
        %%%%%%%%%%%%%%%%%%%
        
        %matrix of shapes must be inside the 'for' loop to reset the matrix
        %after each trial
        %matrix of shapes
        tex_shape_matrix = [tex_bluex;tex_greenpenta;tex_pinkcircle;tex_redtri; tex_whitesqu; tex_yellowpill];
        
        %pick a shape to draw in this position in this trial
        pos1_row = randi(size(tex_shape_matrix,1));
        pos1_shape = tex_shape_matrix(pos1_row,:);
        Screen('DrawTexture', win, pos1_shape, [], [pos1x - 200,pos1y - 200,pos1x + 200,pos1y + 200]);
        %remove that row so the next selections don't pick from it
        tex_shape_matrix(pos1_row,:) = [];
        
        %pick a shape to draw in this position in this trial
        pos2_row = randi(size(tex_shape_matrix,1));
        pos2_shape = tex_shape_matrix(pos2_row,:);
        Screen('DrawTexture', win, pos2_shape, [], [pos2x - 200,pos2y - 200,pos2x + 200,pos2y + 200]);
        %remove that row so the next selections don't pick from it
        tex_shape_matrix(pos2_row,:) = [];
        
        %pick a shape to draw in this position in this trial
        pos3_row = randi(size(tex_shape_matrix,1));
        pos3_shape = tex_shape_matrix(pos3_row,:);
        Screen('DrawTexture', win, pos3_shape, [], [pos3x - 200,pos3y - 200,pos3x + 200,pos3y + 200]);
        %remove that row so the next selections don't pick from it
        tex_shape_matrix(pos3_row,:) = [];
        
        %pick a shape to draw in this position in this trial
        pos4_row = randi(size(tex_shape_matrix,1));
        pos4_shape = tex_shape_matrix(pos4_row,:);
        Screen('DrawTexture', win, pos4_shape, [], [pos4x - 200,pos4y - 200,pos4x + 200,pos4y + 200]);
        %remove that row so the next selections don't pick from it
        tex_shape_matrix(pos4_row,:) = [];
        
        %%%%
        %show current money
        %%%%
        
        money_text = "You currently have " + money + " dollars.";
        %convert to char since DrawFortmattedText doesn't work with string
        money_text = convertStringsToChars(money_text);
        DrawFormattedText(win, money_text, 'center', 'center', [255,255,255]);
        
        %Display the shapes now that they are randomly drawn in each corner
        Screen('Flip',win);
        
        %%%%%%%%%%%%%%%%%%%
        %%%Feedback to user's exploration
        %%%%%%%%%%%%%%%%%%%
        
        %default reponse variables waiting to be changed by user input
        %resetting the values by the time the next 'for' loop runs around
        g502x = 0;
        g502y = 0;
        shape_ID = NaN;
        response = 0;
        
        %constantly check for user input until a click is registered
        while (response == 0)
            
            if g502x == 0
                
                [~,g502x,g502y,~] = GetClicks()
                
                if g502x < (compsizex/2) & g502y < (compsizey/2) & g502x ~= 0 & g502y ~= 0
                    %runs if user clicks top left corner
                    shape_ID = pos1_shape
                    response = 1;
                elseif g502x > (compsizex/2) & g502y < (compsizey/2) & g502x ~= 0 & g502y ~= 0
                    %runs if user clicks top right corner
                    shape_ID = pos2_shape
                    response = 1;
                elseif g502x < (compsizex/2) & g502y > (compsizey/2) & g502x ~= 0 & g502y ~= 0
                    %runs if user clicks bottom left corner
                    shape_ID = pos3_shape
                    response = 1;
                elseif g502x > (compsizex/2) & g502y > (compsizey/2) & g502x ~= 0 & g502y ~= 0
                    %runs if user clicks bottom right corner
                    shape_ID = pos4_shape
                    response = 1;
                end
                
            end
            
        end
        
        %After getting the ID of the shape that was clicked from the code above
        %We asssess the value of the shape and adjust their balance accordingly
        
        switch shape_ID
            case tex_bluex
                shown_value = bluex_value(:,randi(size(bluex_value,2)));
            case tex_greenpenta
                shown_value = greenpenta_value(:,randi(size(greenpenta_value,2)));
            case tex_pinkcircle
                shown_value = pinkcircle_value(:,randi(size(pinkcircle_value,2)));
            case tex_redtri
                shown_value = redtri_value(:,randi(size(redtri_value,2)));
            case tex_whitesqu
                shown_value = whitesqu_value(:,randi(size(whitesqu_value,2)));
            case tex_yellowpill
                shown_value = yellowpill_value(:,randi(size(yellowpill_value,2)));
            otherwise
                disp('error at value report')
        end
        
        money = money + shown_value;
        
        %Show them how much they just gained/lost
        if shown_value < 0
            change_text = "You just lost " + shown_value + " dollars."
            %convert to char since DrawFortmattedText doesn't work with string
            change_text = convertStringsToChars(change_text);
            DrawFormattedText(win, change_text, 'center', 'center', [255,0,0]);
        elseif shown_value > 0
            change_text = "You just gained " + shown_value + " dollars."
            %convert to char since DrawFortmattedText doesn't work with string
            change_text = convertStringsToChars(change_text);
            DrawFormattedText(win, change_text, 'center', 'center', [0,255,0]);
        elseif shown_value == 0
            change_text = "You did not gain/lose any money."
            %convert to char since DrawFortmattedText doesn't work with string
            change_text = convertStringsToChars(change_text);
            DrawFormattedText(win, change_text, 'center', 'center', [255,255,255]);
        end
        
        
        Screen('Flip',win);
        WaitSecs(3);
        
        %If the participant earned the bonus, this will run.
        %Code is very simular to the ones above, so I won't explain here
        if money >= 200 & bonus == 0;
            bonus = 1;
            bonus_text = "You earned the bonus of an additional $20 at the end of the experiment!"
            bonus_text = convertStringsToChars(bonus_text);
            DrawFormattedText(win, bonus_text, 'center', 'center', [255,255,255]);
            Screen('Flip',win);
            WaitSecs(3);
        end
        
    end
    
    %if they earned the bonus during training, set money to be 120 before
    %assessment starts.
    if bonus == 1
        money = 120;
    elseif bonus == 0
        money = 100;
    end
    
    WaitSecs(3);
    Screen('CloseAll');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% BREAK TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Here we will call on the local function "local_phase2instructions()"
    %Which will display the instructions for the assessment phase of the
    %experiment. It also gives the participants a chance to take a break.
    %The experiment will resume when the mouse recieves a user input.
    local_phase2instructions()
    %Once a click has been detected, the codes below will start to run.
    
    %%%%%%%%%%% EXPERIMENT PHASE 2: VALUE ASSESSMENT PARADIGM %%%%%%%%%%%%%
    
    %We will still be using some of the variables already setup from the
    %previous phase. But there are some additions.
    
    %I originally wanted to use 3 shapes on either side of the choice
    %paradigm. However, I didn't want the the change in shape size or the
    %change in image locations to be a confounding factor in the experiment.
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% Load shapes into assessment window and some setup
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %some setup are simular to training phase, so I removed redundent
    %comments

    [win,~] = Screen('OpenWindow', 0, [0 0 0]);
    
    ShowCursor('Arrow');
    
    %load in blux
    shape_bluex = imread('bluex.png');
    tex_bluex = Screen('MakeTexture', win, shape_bluex);
    
    %load in greenpenta
    shape_greenpenta = imread('greenpenta.png');
    tex_greenpenta = Screen('MakeTexture', win, shape_greenpenta);
    
    %load in pinkcircle
    shape_pinkcircle = imread('pinkcircle.png');
    tex_pinkcircle = Screen('MakeTexture', win, shape_pinkcircle);
    
    %load in redtri
    shape_redtri = imread('redtri.png');
    tex_redtri = Screen('MakeTexture', win, shape_redtri);
    
    %load in whitesqu
    shape_whitesqu = imread('whitesqu.png');
    tex_whitesqu = Screen('MakeTexture', win, shape_whitesqu);
    
    %load in yellowpill
    shape_yellowpill = imread('yellowpill.png');
    tex_yellowpill = Screen('MakeTexture', win, shape_yellowpill);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% Assessment trials presentation
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %NOTE! In these trials, we WANT there to be the possiblity that the
    %same shape can be drawn twice on any of the trials. 
    
    %HOWEVER, we won't want the same shape to be drawn
    %on both the left and the right side of the screen.
    %Since that would allow participants to "cancel out" the
    %the value of the shapes and only consider the 2 different shapes
    %instead of the total 4 shapes we want them to think about
    
    %We also won't want two of the same shapes on both sides of the screen,
    %since that would, once again, allow participants to only consider 2
    %different shapes instead of the total 4 shapes we want them to think about
    
    %HOWEVER, we will permit the same shape to be drawn twice on the 
    %left or twice on the right when the other side doesn't do the same.
    %Since this will ask the participant to consider: if one shapes is
    %doubled, how will the sum of the 2 other shapes compare? This would
    %not cause a reduction in difficulty as compare to the two possibilties
    %stated above.
    
    for trials = 1:assess_trials
        
        %%%%%%%%%%%%%%%%%%%
        %%%Drawing the assessment trials
        %%%%%%%%%%%%%%%%%%%
        
        tex_shape_matrix = [tex_bluex;tex_greenpenta;tex_pinkcircle;tex_redtri; tex_whitesqu; tex_yellowpill];
        
        %pick a shape to draw in this position in this trial
        pos1_row = randi(size(tex_shape_matrix,1));
        %The first shape drawn will not need to be checked
        pos1_shape = tex_shape_matrix(pos1_row,:);
        
        %pick a shape to draw in this position in this trial
        pos2_row = randi(size(tex_shape_matrix,1));
        %check if the position of this shape violated the rules above, then
        %change it until it doesn't
        while pos2_row == pos1_row
            pos2_row = randi(size(tex_shape_matrix,1));
        end
        pos2_shape = tex_shape_matrix(pos2_row,:);
        
        %pick a shape to draw in this position in this trial
        pos3_row = randi(size(tex_shape_matrix,1));
        %NOTE! In pos3, we want to give the chance for left side to have
        %double same shapes, so pos4_row is stated early for the 'while'
        %loop in pos3 to check
        pos4_row = randi(size(tex_shape_matrix,1));
        %check if the position of this shape violated the rules above, then
        %change it until it doesn't
        if pos4_row == pos2_row
            while pos3_row == pos2_row || pos3_row == pos1_row
                pos3_row = randi(size(tex_shape_matrix,1));
            end
        elseif pos4_row ~= pos2_row
            while pos3_row == pos2_row
                pos3_row = randi(size(tex_shape_matrix,1));
            end
        end
        pos3_shape = tex_shape_matrix(pos3_row,:);
        
        %pick a shape to draw in this position in this trial
        %check if the position of this shape violated the rules above, then
        %change it until it doesn't
        
        %simular situation to pos3_row randomization, check if the
        %"double value" scenario already happened in pos3 and pos1
        if pos3_row == pos1_row
            while pos4_row == pos1_row || pos4_row == pos2_row || pos4_row == pos3_row
                pos4_row = randi(size(tex_shape_matrix,1));
            end
        elseif pos3_row ~= pos1_row
            while pos4_row == pos1_row || pos4_row == pos3_row
                pos4_row = randi(size(tex_shape_matrix,1));
            end
        end
        pos4_shape = tex_shape_matrix(pos4_row,:);
        
        %DrawTextures only after we ensure that the positions of the shapes
        %didn't violate any of the rules we've stated.
        Screen('DrawTexture', win, pos1_shape, [], [pos1x - 200,pos1y - 200,pos1x + 200,pos1y + 200]);
        Screen('DrawTexture', win, pos2_shape, [], [pos2x - 200,pos2y - 200,pos2x + 200,pos2y + 200]);
        Screen('DrawTexture', win, pos3_shape, [], [pos3x - 200,pos3y - 200,pos3x + 200,pos3y + 200]);
        Screen('DrawTexture', win, pos4_shape, [], [pos4x - 200,pos4y - 200,pos4x + 200,pos4y + 200]);
        %draw a line between the 2 choices so the participants knows
        %clearly which group is which. And if they think the two groups are
        %equal in value, they will know where to click.
        Screen('FillRect',win, [255,255,255], [compsizex/2-10,0,compsizex/2+10,compsizey]);
        
        Screen('Flip',win);
        
        
        %%%%%%%%%%%%%%%%%%%
        %%%Collecting which side they chose
        %%%%%%%%%%%%%%%%%%%
        
        %default reponse variables waiting to be changed by user input
        %resetting the values by the time the next 'for' loop runs around
        g502x = 0;
        g502y = 0;
        shape_ID = NaN;
        response = 0;
        
        %constantly check for user input until a click is registered
        
        %We only need to store one variable for which side they picked. So
        %it's just L_choice, which tells us if they click left or not.
        while response == 0
            
            if g502x == 0
                
                [~,g502x,g502y,~] = GetClicks()
                
                if g502x < (compsizex/2-10) & g502x ~= 0
                    %runs if user clicks left side
                    %stores all all the shape_ID of the shapes in each location
                    shape_ID(1) = pos1_shape
                    shape_ID(2) = pos2_shape
                    shape_ID(3) = pos3_shape
                    shape_ID(4) = pos4_shape
                    L_choice = 1;
                    response = 1;
                elseif g502x > (compsizex/2+10)
                    %runs if user clicks left side
                    %stores all all the shape_ID of the shapes in each location
                    shape_ID(1) = pos1_shape
                    shape_ID(2) = pos2_shape
                    shape_ID(3) = pos3_shape
                    shape_ID(4) = pos4_shape
                    L_choice = 0;
                    response = 1;
                elseif g502x ~= 0
                    shape_ID(1) = pos1_shape
                    shape_ID(2) = pos2_shape
                    shape_ID(3) = pos3_shape
                    shape_ID(4) = pos4_shape
                    L_choice = NaN;
                    response = 1;
                    
                end
                
            end
            
        end
        
        
        %by now we would have their choice and the shape_IDs of all
        %the shapes drawn for this trial
        
        %Since we don't want them to do ANY learning during the assessment
        %phase, we will not provide feedback here.
        
        %%%%%%%%%%%%%%%%%%%
        %%%Computing their inputs
        %%%%%%%%%%%%%%%%%%%
        
        %obtain the objective value for each shape_ID presented
        
        for i = 1:4
            
            switch shape_ID(i)
                case tex_bluex
                    shown_values_vector(i) = mean(bluex_value);
                case tex_greenpenta
                    shown_values_vector(i) = mean(greenpenta_value);
                case tex_pinkcircle
                    shown_values_vector(i) = mean(pinkcircle_value);
                case tex_redtri
                    shown_values_vector(i) = mean(redtri_value);
                case tex_whitesqu
                    shown_values_vector(i) = mean(whitesqu_value);
                case tex_yellowpill
                    shown_values_vector(i) = mean(yellowpill_value);
                otherwise
                    disp('error at value report')
            end
        end
        
        %compute the value for both sides
        sum_valueL = shown_values_vector(1) + shown_values_vector(3)
        sum_valueR = shown_values_vector(2) + shown_values_vector(4)
        
        %check if participants selected the most valuable side
        %or if they waited and believed both side is the same value
        if (sum_valueL > sum_valueR & L_choice == 1) || (sum_valueL < sum_valueR & L_choice == 0)
            correct_choice = 1;
            money = money + 5;
        elseif (sum_valueL > sum_valueR & L_choice == 0) || (sum_valueL < sum_valueR & L_choice == 1)
            correct_choice = 0;
            money = money - 5;
        elseif sum_valueL == sum_valueR & isnan(L_choice)
            correct_choice = 1;
            money = money + 5;
        elseif sum_valueL ~= sum_valueR & isnan(L_choice)
            correct_choice = 0;
            money = money - 5;
        end
        
        %%%%%%%%%%%%%%%%%%%
        %%%Storing data for each trial
        %%%%%%%%%%%%%%%%%%%
        
        %I want to store some redundent variables just in case if we need
        %to examine what happened when a result output looks odd (outlier?)
        L_response_vector(trials) = L_choice;
        correct_choice_vector(trials) = correct_choice
        
        %To ensure their minimum payout in cases where they've "gone under"
        if money < 100
            money = 100;
        end
    end
    
    
    %%%%%%%%%%% EXPERIMENT PHASE 3: ENDING PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Here we will call on local function 'local_phase3instructions()'.
    %Which will bring up the ending screen and show the participants how
    %much money they will be paided. We thank them, pay them, then save
    %their results in a file.
    
    %Also notice that this time I have to put an input argument for phase 3
    %instructions because I want it to display the money at the end.
    local_phase3instructions(money)
    
    %Once a click has registered, the following code will run, which saves
    %their performance data.
    
    %%%%%%%%%%%%%%%%%%%
    %%%Saving participant performances
    %%%%%%%%%%%%%%%%%%%
    
    %Compute how often they choose correctly
    ave_correct_choice = mean(correct_choice_vector);
    
    %Hid the last name of the participant to have some confidentiality
    letterFirst = profile(1);
    letterLast = profile(2);
    letterFirst = char(letterFirst);
    letterLast = char(letterLast);
    letterLast = letterLast(1,1);
    filename = "profile" + letterFirst + letterLast + "group" + indx + ".mat";
    
    %Most important information to save are:
    %indx: tells us which group the participant is in
    %money: how much we need to pay them
    %ave_correct_choice: tells us how often they made the "correct" choice
    
    %Once again, no harm in storing additiona variables in case we want to
    %examine what happened if something odd happens.
    
    save(filename, 'indx','money','L_response_vector','correct_choice_vector','ave_correct_choice','bonus');
    
    
    
    
    
catch

    %unchanged from template, catching erros and closing the test window

    ShowCursor;

    rethrow(lasterror);

    Screen('CloseAll');

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Local functions that will display
%%%instructions before the start of
%%%each phase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Instrucitons for Phase 1: Training phase
function local_phase1instructions()

%text formats and instructions window
inst_horzpos=50;

top_vertpos=100;

inst_vertpos=30;

inst_color=250;

[window, ~] = Screen('OpenWindow', 0, [0 0 0]);

Screen(window,'FillRect', [0,0,0]);

Screen('TextFont',window, 'Arial');

Screen('TextSize',window, 18);

Screen('TextStyle', window, 1);

%unchanged from the template

%show cursor
ShowCursor('Arrow');

%opening message for phase 1 of the experiment (training)

Screen('DrawText', window, '   This is the first phase of the experiment. Where you can click', inst_horzpos, top_vertpos+inst_vertpos, inst_color);

Screen('DrawText', window, 'around to explore the values of random shapes. Your results', inst_horzpos, top_vertpos+inst_vertpos*2, inst_color);

Screen('DrawText', window, 'during this phase WILL NOT affect your final payout at the end of', inst_horzpos, top_vertpos+inst_vertpos*3, inst_color);

Screen('DrawText', window, 'the experiment. So feel free to practice, learn, and memorize the', inst_horzpos, top_vertpos+inst_vertpos*4, inst_color);

Screen('DrawText', window, 'values of the shapes. However, a simulated "wallet" will be ', inst_horzpos, top_vertpos+inst_vertpos*5, inst_color);

Screen('DrawText', window, 'shown in the middle of the screen. Which will reflect the consequences', inst_horzpos, top_vertpos+inst_vertpos*6, inst_color);

Screen('DrawText', window, 'of your choices. This "fake wallet" will possess $100 at the start.' , inst_horzpos, top_vertpos+inst_vertpos*7, inst_color);

Screen('DrawText', window, '   As previously stated, this phase will not change your actual payout of $100', inst_horzpos, top_vertpos+inst_vertpos*9, inst_color);

Screen('DrawText', window, 'as promised when you signed up for the experiment. However, if you', inst_horzpos, top_vertpos+inst_vertpos*10, inst_color);

Screen('DrawText', window, 'managed to possess $200 in this "fake wallet" at ANY TIME during training.' , inst_horzpos, top_vertpos+inst_vertpos*11, inst_color);

Screen('DrawText', window, 'We will provide a bonus of $20 ontop of your ACTUAL payout.', inst_horzpos, top_vertpos+inst_vertpos*12, inst_color);

Screen('DrawText', window, '   When you are ready, please click anywhere on the screen to begin.', inst_horzpos, top_vertpos+inst_vertpos*14, inst_color);

Screen('Flip', window)

%waiting for click input
g502x = 0;
g502y = 0;

while g502x == 0 & g502y == 0

    [~,g502x,g502y,~] = GetClicks()
    WaitSecs(1.5);
end

%%%%
%end of phase 1 instructions
%%%%

%%%% Instrucitons for Phase 2: Break time and instructions for phase 3

function local_phase2instructions()

%text formats and instructions window
inst_horzpos=50;

top_vertpos=100;

inst_vertpos=30;

inst_color=250;

[window, ~] = Screen('OpenWindow', 0, [0 0 0]);

Screen(window,'FillRect', [0,0,0]);

Screen('TextFont',window, 'Arial');

Screen('TextSize',window, 18);

Screen('TextStyle', window, 1);

%unchanged from the template

%show cursor
ShowCursor('Arrow');

%opening message for phase 2: Assessment of learning

Screen('DrawText', window, '   This is the second and final phase of the experiment. Here, you will be', inst_horzpos, top_vertpos+inst_vertpos, inst_color);

Screen('DrawText', window, 'presented with 2 groups of shapes, each group on either side of the screen.', inst_horzpos, top_vertpos+inst_vertpos*2, inst_color);

Screen('DrawText', window, 'You will then be asked to choose which side is the MOST valuable of the two.', inst_horzpos, top_vertpos+inst_vertpos*3, inst_color);

Screen('DrawText', window, 'Your performance here WILL affect your final payout at the end of the experiment.', inst_horzpos, top_vertpos+inst_vertpos*4, inst_color);

Screen('DrawText', window, 'For each "correct" choice, where you correctly identify the group with the most value,', inst_horzpos, top_vertpos+inst_vertpos*5, inst_color);

Screen('DrawText', window, 'we will add an additional $5 on top of your promised payout of $100 when you signed up', inst_horzpos, top_vertpos+inst_vertpos*6, inst_color);

Screen('DrawText', window, 'for this experiment. However, for each "incorrect" choice where you failed to determine which' , inst_horzpos, top_vertpos+inst_vertpos*7, inst_color);

Screen('DrawText', window, 'group is the most valuable, you will be deducted $5.', inst_horzpos, top_vertpos+inst_vertpos*8, inst_color);

Screen('DrawText', window, 'This deduction WILL NOT cause your final payout to go below $100, the deduction will', inst_horzpos, top_vertpos+inst_vertpos*9, inst_color);

Screen('DrawText', window, 'only reduce any bonus earnings from either, the bonus you earned during training, or the bonus' , inst_horzpos, top_vertpos+inst_vertpos*10, inst_color);

Screen('DrawText', window, 'you earned from choosing the correct groups previously. In other words, a payout of $100 minimum is', inst_horzpos, top_vertpos+inst_vertpos*11, inst_color);

Screen('DrawText', window, 'guaranteed. But there is more to be earned!', inst_horzpos, top_vertpos+inst_vertpos*12, inst_color);

Screen('DrawText', window, 'If you believe the choices on both side are roughly equal. Or if you cannot tell the difference in value.', inst_horzpos, top_vertpos+inst_vertpos*14, inst_color);

Screen('DrawText', window, 'You can click on the white line and we will record your choice as "no difference". If the choices really are', inst_horzpos, top_vertpos+inst_vertpos*15, inst_color);

Screen('DrawText', window, 'roughly equal, clicking in the middle would count as the "correct" choice. However, if one choice was really better', inst_horzpos, top_vertpos+inst_vertpos*16, inst_color);

Screen('DrawText', window, 'than the other. clicking in the middle would count as the "incorrect" choice.', inst_horzpos, top_vertpos+inst_vertpos*17, inst_color);

Screen('DrawText', window, '   Feel free to take a break here. When you are ready again, click anywhere on the screen to start.', inst_horzpos, top_vertpos+inst_vertpos*19, inst_color);

Screen('Flip', window)

%waiting for click input
g502x = 0;
g502y = 0;

while g502x == 0 & g502y == 0

    [~,g502x,g502y,~] = GetClicks()
    WaitSecs(1.5);
    Screen('CloseAll');
end

%%%%
%end of phase 2 instructions
%%%%

%%%% Instrucitons for Phase 3: Ending phase

function local_phase3instructions(money)

%text formats and instructions window
inst_horzpos=50;

top_vertpos=100;

inst_vertpos=30;

inst_color=250;

[window, ~] = Screen('OpenWindow', 0, [0 0 0]);

Screen(window,'FillRect', [0,0,0]);

Screen('TextFont',window, 'Arial');

Screen('TextSize',window, 18);

Screen('TextStyle', window, 1);

%unchanged from the template

%show cursor
ShowCursor('Arrow');

%opening message for phase 3: Ending message

%Show final money
money_text = "   You ended the experiment with " + money + " dollars.";
%convert to char since DrawFortmattedText doesn't work with string
money_text = convertStringsToChars(money_text);


Screen('DrawText', window, '   This is the end of the experiment! Thank you so much for participating in this study!', inst_horzpos, top_vertpos+inst_vertpos, inst_color);

Screen('DrawText', window, money_text, inst_horzpos, top_vertpos+inst_vertpos*2, inst_color);

Screen('DrawText', window, '   Please click anywhere on the screen to exit the experiment. Once again, thank you!', inst_horzpos, top_vertpos+inst_vertpos*3, inst_color);

Screen('Flip', window)

%waiting for click input
g502x = 0;
g502y = 0;

while g502x == 0 & g502y == 0

    [~,g502x,g502y,~] = GetClicks()
    WaitSecs(1.5);
    Screen('CloseAll');
end

%%%%
%end of phase 3 instructions
%%%%

