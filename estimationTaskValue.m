%% ------------------------------------------------------------------------
%---------------------Copyright Statement----------------------------------
%--------------------------------------------------------------------------
%
function estimationTaskValue(number, sessionin)
%% ------------------------------------------------------------------------
%---------------------NOTICE-----------------------------------------------
%--------------------------------------------------------------------------
% $$$$$$ PLEASE RUN EstimationTrialDataGenerator FILE FIRST $$$$$$$$$$$$$$$
% FOR A LIST OF PARAMETERS PLEASE REFER TO EstimationTrialDataGenerator

%% ------------------------------------------------------------------------
% --------------------Estimation task Value--------------------------------
%--------------------------------------------------------------------------
% In this task two gambles are presented: a safe gamble (target), were a
% 10% deviation from the magnitude setted by the experimenter is allawed
% from trial to trial, and a risky gamgle (competitor) were the magnitude
% will vary from 150% of the target gamble's magnitude to 400%. There
% stages are defined in this task: a fixaction cross, an evaluation period
% and a choosing period. The participant will have to chose between the
% safe and the risky gamble in every trial. The responses will be storaged
% in a matrix together with the magnitude of the target and the competitor
% gambles.
%
% RT is measured, feedback incorporated (the chosen gamble in yelow) and
% position of the gamblesrandomized the response is storaged in a text file

%% ------------------------------------------------------------------------
%---------------------Clearing the workspace-------------------------------
%--------------------------------------------------------------------------
% Clear the workspace
clc;
% close all;
% clear all;
sca;


try
    
    %% ------------------------------------------------------------------------
    %----------------------General set-up--------------------------------------
    %--------------------------------------------------------------------------
    PsychDefaultSetup(2);
    Screen('Preference', 'SkipSyncTests', 1);
    
    %% ------------------------------------------------------------------------
    %----------------------Load the parameters---------------------------------
    %--------------------------------------------------------------------------
    % Load values of the variables
    load('./Data/estiData.mat');
    if nargin < 2
        number                          =   input('Participant Number: ','s');
        sessionin                       =   input('Session Number: ');
    end
    nickname                        =   strcat('P',number);
    
    
    
    %% ------------------------------------------------------------------------
    %----------------------Psychtoolbox set-up---------------------------------
    %--------------------------------------------------------------------------
    % Get the screen numbers
    screens                         =   Screen('Screens');
    
    % Draw to the external screen if avaliable
    screenNumber                    =   max(screens);
    
    % Windows Mode or Fullscreen?
    windowedMode            =   0;
    windowSize              =   [1280,720];
    startPoints             =   [1750,1250];
    endPoints               =   [2550,1850];
    startPoints             =   [200, 200];%endPoints - windowSize;
    
    
    % Define blackColor and whiteColor
    whiteColor                      =   [1 1 1];% WhiteIndex(screenNumber);
    blackColor                      =   [0 0 0];% BlackIndex(screenNumber);
    yellowColor                     =   [1 1 0];
    % Open an on screen window
    if ~windowedMode
        [window, windowRect]            =   PsychImaging('OpenWindow', screenNumber, blackColor);
    else
        [window, windowRect]            =   PsychImaging('OpenWindow', screenNumber, blackColor,[startPoints,startPoints+windowSize]);
    end
    
    
    % Get the size of the on screen window
    [screenPixelsX, screenPixelsY]  =   Screen('WindowSize', window);
    
    % Query the frame duration
    frameDuration                   =   Screen('GetFlipInterval', window);
    
    % Get the centre coordinate of the window
    [xCenter, yCenter]              =   RectCenter(windowRect);
    
    %% ------------------------------------------------------------------------
    %----------------------Positions-------------------------------------------
    %--------------------------------------------------------------------------
    % Rectangle positions X:
    rectPos                         =   [screenPixelsX*0.33 screenPixelsX*0.66];
    
    % Gamble probability positions X:
    gambleProbPosX                  =   [screenPixelsX*0.30 screenPixelsX*0.63];
    
    % Gamble magnitude positions X:
    gambleMagPosX                   =   [screenPixelsX*0.31 screenPixelsX*0.64];
    
    % Gamble positions Y:
    % gamblePosY(1)-> probability position
    % gamblePosY(2)-> magnitude position
    gamblePosY                      =   [screenPixelsY*0.46 screenPixelsY*0.57];
    
    %% ------------------------------------------------------------------------
    %------------------------Rectangles settings-------------------------------
    %--------------------------------------------------------------------------
    % Make a base rectPos of 200 by 400 pixels
    baseRect                        =   [0 0 175 250];
    
    % Screen X positions of our two rectangles
    cardXPos                        =   rectPos;
    cardNumber                      =   length(cardXPos);
    
    % Make our rectangle coordinates for evaluation and choice
    rectCoords                      =   nan(4,cardNumber);
    for i = 1:cardNumber
        rectCoords(:, i)            =   CenterRectOnPointd(baseRect, cardXPos(i), yCenter);
    end
    % Pen width for the frames
    penWidthPixels                  =   6;
    
    %% ------------------------------------------------------------------------
    %------------------------Fixation cross------------------------------------
    %--------------------------------------------------------------------------
    % Here we set the size of the arms of our fixation cross
    fixCrossDimPix                  =   40;
    
    % Now we set the coordinates (these are all relative to zero we will let
    % the drawing routine center the cross in the center of our monitor for us)
    xCoords                         =   [-fixCrossDimPix fixCrossDimPix 0 0];
    yCoords                         =   [0 0 -fixCrossDimPix fixCrossDimPix];
    allCoords                       =   [xCoords; yCoords];
    allCrossCoords                  =   [xCoords; yCoords];
    allColors                       =   [whiteColor; whiteColor];
    % Set the line width for our fixation cross
    
    lineWidthPixCross               =   4;
    lineWidthPix                    =   6;
    lineWidthPixBaseLine            =   3;
    %% ------------------------------------------------------------------------
    %------------------------Time----------------------------------------------
    %--------------------------------------------------------------------------
    % Evaluation time in seconds and frames
    % evaTimeSecs = evalTimeSec;
    evaTimeFrames                   =   round(evalTimeSec / frameDuration);
    
    % Choosing time in seconds and frames
    % choTimeSecs = choiceTimeSec;
    choTimeFrames                   =   round(choiceTimeSec / frameDuration);
    
    % Interstimulus interval time in seconds and frames
    % isiTimeSec                    =   1;
    isiTimeFrames                   =   round(isiTimeSec / frameDuration);
    
    % Feedback time
    % feedTimeSecs                  =   feedbackTimeSec;
    feedTimeFrames                  =   round(feedbackTimeSec / frameDuration);
    
    % Number of frames to wait before re-drawing
    waitFrames                      =   1;
    
    
    %%  TRAINING Period VALUE
    trialStackValtrai               =   fGenTrialStack( size(trainingVal,1));
    %%      Wait until a key is pressed
    KbPressWait
    correctVal                     =    0; % In order to pass the training it has to be = 4 at the end
    %% --------------------------------------------------------------------
    %------------------------Asking for a trial----------------------------
    %----------------------------------------------------------------------
    [trialtrai, trialStackValtrai]             =   fPopTrialStack( trialStackValtrai );
    
    while trialtrai
        
        
        %% --------------------------------------------------------------------
        %--------------------One trial-----------------------------------------
        %----------------------------------------------------------------------
        Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
        
        %% --------------------------------------------------------------------
        %--------------------Values for each trial-----------------------------
        %----------------------------------------------------------------------
        %converting the values of the gambles into string
        targetMagString             =   int2str(trainingVal(trialtrai,1));
        competitorMagString         =   int2str(trainingVal(trialtrai,4));
        
        targetProbString            =   strcat(int2str(trainingVal(trialtrai,2)),'%');
        competitorProbString        =   strcat(int2str(trainingVal(trialtrai,5)),'%');
        
        % We are going to represent them in a cell:
        finalStringCell             =   cell(2,2);
        % Target gamble's values, row is determined by targetRandPosVec
        finalStringCell(1,:)        =   {targetProbString,targetMagString};
        % Competitor gambles's values, row is determined by
        finalStringCell(2,:)        =   {competitorProbString,competitorMagString};
        allColors                   =   [whiteColor; whiteColor];
        
        %% --------------------------------------------------------------------
        %--------------------Reset response in each trial----------------------
        %----------------------------------------------------------------------
        response = 0;
        
        %% --------------------------------------------------------------------
        %--------------------Intertrial fixaction cross------------------------
        %----------------------------------------------------------------------
        for frame = 1 : (isiTimeFrames - 1)
            % Setup the text type for the window
            Screen('TextFont', window, 'Arial');
            Screen('TextSize', window, 36);
            % Draw the fixation cross in whiteColor, set it to the center of our screen and
            % set good quality antialiasing
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, whiteColor, [xCenter yCenter], 2);
            Screen('Flip', window);
        end
        
        %% --------------------------------------------------------------------
        %--------------------Evaluation part-----------------------------------
        %----------------------------------------------------------------------
        for frame = 1 : evaTimeFrames
            %% ----------------------------------------------------------------
            %--------------------Draw the rectPos to the screen----------------
            %------------------------------------------------------------------
            Screen('FrameRect', window, allColors(1,:), rectCoords(:,1), penWidthPixels);
            Screen('FrameRect', window, allColors(2,:), rectCoords(:,2), penWidthPixels);
            %% ----------------------------------------------------------------
            %--------------------Draw texts to the screen----------------------
            %------------------------------------------------------------------
            % Draw text in the middle of the screen in Courier in whiteColor 'Evaluate'
            Screen('TextSize', window, 80);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, 'Evaluate', 'center', screenPixelsY * 0.15, whiteColor);
            
            %% ----------------------------------------------------------------
            %--------------------Draw target gamble----------------------------
            %------------------------------------------------------------------
            % Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{1,1}, gambleProbPosX(1), gamblePosY(2) ,[1 0 0]);
            % Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{1,2}, gambleMagPosX(1), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw competitor gamble------------------------
            %------------------------------------------------------------------
            % Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{2,1}, gambleProbPosX(2), gamblePosY(2) ,[1 0 0]);
            % Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{2,2}, gambleMagPosX(2), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Flip the screen-------------------------------
            %------------------------------------------------------------------
            Screen('Flip', window);
            
        end
        
        %% --------------------------------------------------------------------
        %--------------------Choosing part-------------------------------------
        %----------------------------------------------------------------------
        
        
        % Setting start time
        startTime                   =  GetSecs;
        endTime                     =  GetSecs;
        
        %% ----------------------------------------------------------------
        %--------------------Define a response flag (not maked)------------
        %------------------------------------------------------------------
        %The participant has to make a choice now
        respToBeMade            =  true;
        
        for frame= 1 : choTimeFrames
            
            
            %% ----------------------------------------------------------------
            %--------------------Draw the rectPos to the screen----------------
            %------------------------------------------------------------------
            Screen('FrameRect', window, allColors(1,:), rectCoords(:,1), penWidthPixels);
            Screen('FrameRect', window, allColors(2,:), rectCoords(:,2), penWidthPixels);
            
            %% ----------------------------------------------------------------
            %--------------------Draw texts to the screen----------------------
            %------------------------------------------------------------------
            % Draw text in the middle of the screen in Courier in whiteColor 'Choose'
            Screen('TextSize', window, 80);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, 'Choose', 'center', screenPixelsY * 0.15, [1 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw target gamble----------------------------
            %------------------------------------------------------------------
            % Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{1,1}, gambleProbPosX(1), gamblePosY(2) ,[1 0 0]);
            % Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{1,2}, gambleMagPosX(1), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw competitor gamble------------------------
            %------------------------------------------------------------------
            % Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{2,1}, gambleProbPosX(2), gamblePosY(2) ,[1 0 0]);
            % Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{2,2}, gambleMagPosX(2), gamblePosY(1) ,[0 1 0]);
            
            
            %% ----------------------------------------------------------------
            %--------------------Flip the screen-------------------------------
            %------------------------------------------------------------------
            Screen('Flip', window);
            
            %% ----------------------------------------------------------------
            %--------------------Key press check-------------------------------
            %------------------------------------------------------------------
            [keyIsDown,secs, keyCode]   =   KbCheck;
            
            %% ----------------------------------------------------------------
            %--------------------Esc key check---------------------------------
            %------------------------------------------------------------------
            if keyCode(escapeKey)
                %% ------------------------------------------------------------
                %--------------------Exit--------------------------------------
                %--------------------------------------------------------------
                sca;
                return
                
                %% ----------------------------------------------------------------
                %--------------------Left|Right key check--------------------------
                %------------------------------------------------------------------
            elseif xor(keyCode(leftKey), keyCode(rightKey))
                %% ------------------------------------------------------------
                %--------------------Store current time------------------------
                %--------------------------------------------------------------
                endTime                 =   GetSecs;
                
                %% ------------------------------------------------------------
                %--------------------Change the response flag to maked---------
                %--------------------------------------------------------------
                respToBeMade            =   false;
                
                %% ------------------------------------------------------------
                %--------------------Store the response------------------------
                %--------------------------------------------------------------
                response                =   keyCode(leftKey) + (keyCode(rightKey) * 2);
                allColors(response,:)   =   yellowColor;
                allColors(3-response,:) =   whiteColor;
                %% ------------------------------------------------------------
                %--------------------Set feedback rectangles-------------------
                %--------------------------------------------------------------
                % Make our rectangle coordinates for feedback, the choosen one
                feedRects               =   nan(4,cardNumber-1);
                for i = 1 : (cardNumber - 1)
                    feedRects(:, i)     =   CenterRectOnPointd(baseRect, cardXPos(response), yCenter);
                end
                
                % Make our rectangle coordinates for the feedback, the unchosen one
                unchoRects              =   nan(4,cardNumber-1);
                for i = 1 : (cardNumber - 1)
                    unchoRects(:, i)    =   CenterRectOnPointd(baseRect, cardXPos(3-response), yCenter);
                end
                
                
                
            end
            
            
        end
        %% --------------------------------------------------------------------
        %--------------------Feedback part-------------------------------------
        %----------------------------------------------------------------------
        % show the feedback only when the responses are correctly made
        if (response == 1 || response == 2)
            for frame = 1 : choTimeFrames
                %% ------------------------------------------------------------
                %--------------------Draw gamble cards-------------------------
                %--------------------------------------------------------------
                % Draw the choosen gamble on the screen in yellow
                Screen('FrameRect', window,allColors(response,:) , feedRects, penWidthPixels);
                % Draw the unchosen gamble on whiteColor
                Screen('FrameRect', window, allColors(3-response,:) , unchoRects, penWidthPixels);
                
                %% ------------------------------------------------------------
                %--------------------Draw texts--------------------------------
                %--------------------------------------------------------------
                %Draw text in the middle of the screen in Courier in whiteColor 'Choose'
                Screen('TextSize', window, 80);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window, 'Choose', 'center', screenPixelsY * 0.15, [1 1 0]);
                
                %% ------------------------------------------------------------
                %--------------------Draw target gamble------------------------
                %--------------------------------------------------------------
                % Draw probability in red
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{1,1}, gambleProbPosX(1), gamblePosY(2) ,[1 0 0]);
                % Draw magnitude in green
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{1,2}, gambleMagPosX(1), gamblePosY(1) ,[0 1 0]);
                
                %% ------------------------------------------------------------
                %--------------------Draw competitor gamble--------------------
                %--------------------------------------------------------------
                % Draw probability in red
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{2,1}, gambleProbPosX(2), gamblePosY(2) ,[1 0 0]);
                % Draw magnitude in green
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{2,2}, gambleMagPosX(2), gamblePosY(1) ,[0 1 0]);
                
                %% ------------------------------------------------------------
                %--------------------Flip the screen---------------------------
                %--------------------------------------------------------------
                Screen('Flip', window);
            end
            responseVecTrainingValEst(trialtrai,1)                =     response;
            if (response == trainingVal(trialtrai,3))
                correctVal=correctVal+1;
                
            end
        else
            
            %% ----------------------------------------------------------------
            %--------------------If no proper feedback-------------------------
            %------------------------------------------------------------------
            % Put the trial back to stack
            [ trialStackValtrai ]               =   fPutTrialStack( trialtrai, trialStackValtrai );
        end
        %% --------------------------------------------------------------------
        %------------------------Asking for a trial----------------------------
        %----------------------------------------------------------------------
        [trialtrai, trialStackValtrai]             =   fPopTrialStack( trialStackValtrai);
        
        
    end
    responseVecTrainingValEst(:,2)                =     trainingVal(:,1);
    responseVecTrainingValEst(:,3)                =     trainingVal(:,2);
    responseVecTrainingValEst(:,4)                =     trainingVal(:,3);
    responseVecTrainingValEst(:,5)                =     trainingVal(:,4);
    responseVecTrainingValEst(:,6)                =     trainingVal(:,5);
    
    nameRespMatTra            =   strcat('./Data/Storage1/EstTrainingVal',nickname,'_',num2str(sessionin),'.mat');
    
    save(nameRespMatTra,'responseVecTrainingValEst');
    KbPressWait
    Screen('Flip', window);
        if (correctVal<7)
            rethrow(struct('message','You are not doing well!!! :('))
        end
    %%  VALUE Trials
    %% ------------------------------------------------------------------------
    %------------------------Asking for a trial--------------------------------
    %--------------------------------------------------------------------------
    [trial, trialStackVal]             =   fPopTrialStack( trialStackVal );
    
    
    
    %%      Wait until a key is pressed
    KbPressWait
    
    %% ------------------------------------------------------------------------
    %------------------------Experimental round--------------------------------
    %--------------------------------------------------------------------------
    
    
    while trial
        
        %% --------------------------------------------------------------------
        %--------------------One trial-----------------------------------------
        %----------------------------------------------------------------------
        Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
        
        %% --------------------------------------------------------------------
        %--------------------Values for each trial-----------------------------
        %----------------------------------------------------------------------
        %converting the values of the gambles into string
        targetMagString             =   int2str(targetMagVec(trial));
        competitorMagString         =   int2str(competitorMagVec(trial));
        
        targetProbString            =   strcat(int2str(targetProbability),'%');
        competitorProbString        =   strcat(int2str(competitorProbability),'%');
        
        % We are going to represent them in a cell:
        finalStringCell             =   cell(2,2);
        % Target gamble's values, row is determined by targetRandPosVec
        finalStringCell(targetRandPosVecVal(trial),:)      =   {targetProbString,targetMagString};
        % Competitor gambles's values, row is determined by
        finalStringCell(competitorRandPosVecVal(trial),:)  =   {competitorProbString,competitorMagString};
        allColors                       =   [whiteColor; whiteColor];
        
        %% --------------------------------------------------------------------
        %--------------------Reset response in each trial----------------------
        %----------------------------------------------------------------------
        response = 0;
        
        %% --------------------------------------------------------------------
        %--------------------Intertrial fixaction cross------------------------
        %----------------------------------------------------------------------
        for frame = 1 : (isiTimeFrames - 1)
            % Setup the text type for the window
            Screen('TextFont', window, 'Arial');
            Screen('TextSize', window, 36);
            % Draw the fixation cross in whiteColor, set it to the center of our screen and
            % set good quality antialiasing
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, whiteColor, [xCenter yCenter], 2);
            Screen('Flip', window);
        end
        
        %% --------------------------------------------------------------------
        %--------------------Evaluation part-----------------------------------
        %----------------------------------------------------------------------
        for frame = 1 : evaTimeFrames
            %% ----------------------------------------------------------------
            %--------------------Draw the rectPos to the screen----------------
            %------------------------------------------------------------------
            Screen('FrameRect', window, allColors(1,:), rectCoords(:,1), penWidthPixels);
            Screen('FrameRect', window, allColors(2,:), rectCoords(:,2), penWidthPixels);
            %% ----------------------------------------------------------------
            %--------------------Draw texts to the screen----------------------
            %------------------------------------------------------------------
            % Draw text in the middle of the screen in Courier in whiteColor 'Evaluate'
            Screen('TextSize', window, 80);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, 'Evaluate', 'center', screenPixelsY * 0.15, whiteColor);
            
            %% ----------------------------------------------------------------
            %--------------------Draw target gamble----------------------------
            %------------------------------------------------------------------
            % Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{targetRandPosVecVal(trial),1}, gambleProbPosX(targetRandPosVecVal(trial)), gamblePosY(2) ,[1 0 0]);
            % Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{targetRandPosVecVal(trial),2}, gambleMagPosX(targetRandPosVecVal(trial)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw competitor gamble------------------------
            %------------------------------------------------------------------
            % Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{competitorRandPosVecVal(trial),1}, gambleProbPosX(competitorRandPosVecVal(trial)), gamblePosY(2) ,[1 0 0]);
            % Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{competitorRandPosVecVal(trial),2}, gambleMagPosX(competitorRandPosVecVal(trial)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Flip the screen-------------------------------
            %------------------------------------------------------------------
            Screen('Flip', window);
            
        end
        
        %% --------------------------------------------------------------------
        %--------------------Choosing part-------------------------------------
        %----------------------------------------------------------------------
        
        
        % Setting start time
        startTime                   =  GetSecs;
        endTime                     =  GetSecs;
        
        %% ----------------------------------------------------------------
        %--------------------Define a response flag (not maked)------------
        %------------------------------------------------------------------
        %The participant has to make a choice now
        respToBeMade            =  true;
        
        for frame= 1 : choTimeFrames
            
            
            %% ----------------------------------------------------------------
            %--------------------Draw the rectPos to the screen----------------
            %------------------------------------------------------------------
            Screen('FrameRect', window, allColors(1,:), rectCoords(:,1), penWidthPixels);
            Screen('FrameRect', window, allColors(2,:), rectCoords(:,2), penWidthPixels);
            
            %% ----------------------------------------------------------------
            %--------------------Draw texts to the screen----------------------
            %------------------------------------------------------------------
            % Draw text in the middle of the screen in Courier in whiteColor 'Choose'
            Screen('TextSize', window, 80);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, 'Choose', 'center', screenPixelsY * 0.15, [1 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw target gamble----------------------------
            %------------------------------------------------------------------
            % Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{targetRandPosVecVal(trial),1}, gambleProbPosX(targetRandPosVecVal(trial)), gamblePosY(2) ,[1 0 0]);
            % Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{targetRandPosVecVal(trial),2}, gambleMagPosX(targetRandPosVecVal(trial)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw competitor gamble------------------------
            %------------------------------------------------------------------
            % Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{competitorRandPosVecVal(trial),1}, gambleProbPosX(competitorRandPosVecVal(trial)), gamblePosY(2) ,[1 0 0]);
            % Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{competitorRandPosVecVal(trial),2}, gambleMagPosX(competitorRandPosVecVal(trial)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Flip the screen-------------------------------
            %------------------------------------------------------------------
            Screen('Flip', window);
            
            %% ----------------------------------------------------------------
            %--------------------Key press check-------------------------------
            %------------------------------------------------------------------
            [keyIsDown,secs, keyCode]   =   KbCheck;
            
            %% ----------------------------------------------------------------
            %--------------------Esc key check---------------------------------
            %------------------------------------------------------------------
            if keyCode(escapeKey)
                %% ------------------------------------------------------------
                %--------------------Exit--------------------------------------
                %--------------------------------------------------------------
                sca;
                return
                
                %% ----------------------------------------------------------------
                %--------------------Left|Right key check--------------------------
                %------------------------------------------------------------------
            elseif xor(keyCode(leftKey), keyCode(rightKey))
                %% ------------------------------------------------------------
                %--------------------Store current time------------------------
                %--------------------------------------------------------------
                endTime                 =   GetSecs;
                
                %% ------------------------------------------------------------
                %--------------------Change the response flag to maked---------
                %--------------------------------------------------------------
                respToBeMade            =   false;
                
                %% ------------------------------------------------------------
                %--------------------Store the response------------------------
                %--------------------------------------------------------------
                response                =   keyCode(leftKey) + (keyCode(rightKey) * 2);
                allColors(response,:)   =   yellowColor;
                allColors(3-response,:) =   whiteColor;
                %% ------------------------------------------------------------
                %--------------------Set feedback rectangles-------------------
                %--------------------------------------------------------------
                % Make our rectangle coordinates for feedback, the choosen one
                feedRects               =   nan(4,cardNumber-1);
                for i = 1 : (cardNumber - 1)
                    feedRects(:, i)     =   CenterRectOnPointd(baseRect, cardXPos(response), yCenter);
                end
                
                % Make our rectangle coordinates for the feedback, the unchosen one
                unchoRects              =   nan(4,cardNumber-1);
                for i = 1 : (cardNumber - 1)
                    unchoRects(:, i)    =   CenterRectOnPointd(baseRect, cardXPos(3-response), yCenter);
                end
                
                
                
            end
            
        end
        
        
        %% --------------------------------------------------------------------
        %--------------------Snapshop Storage--- -------------------------------
        %----------------------------------------------------------------------
        snapshotStoragVal(snapshotCntVal,:) = [targetMagVec(trial), competitorMagVec(trial),...
            ( response==targetRandPosVecVal(trial)) * 1 + (response==competitorRandPosVecVal(trial)) * 2,...
            endTime-startTime];
        snapshotCntVal = snapshotCntVal + 1;
        
        %% --------------------------------------------------------------------
        %--------------------Feedback part-------------------------------------
        %----------------------------------------------------------------------
        % show the feedback only when the responses are correctly made
        if (response == 1 || response == 2)
            for frame = 1 : choTimeFrames
                %% ------------------------------------------------------------
                %--------------------Draw gamble cards-------------------------
                %--------------------------------------------------------------
                % Draw the choosen gamble on the screen in yellow
                Screen('FrameRect', window,allColors(response,:) , feedRects, penWidthPixels);
                % Draw the unchosen gamble on whiteColor
                Screen('FrameRect', window, allColors(3-response,:) , unchoRects, penWidthPixels);
                
                %% ------------------------------------------------------------
                %--------------------Draw texts--------------------------------
                %--------------------------------------------------------------
                %Draw text in the middle of the screen in Courier in whiteColor 'Choose'
                Screen('TextSize', window, 80);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window, 'Choose', 'center', screenPixelsY * 0.15, [1 1 0]);
                
                %% ------------------------------------------------------------
                %--------------------Draw target gamble------------------------
                %--------------------------------------------------------------
                % Draw probability in red
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{targetRandPosVecVal(trial),1}, gambleProbPosX(targetRandPosVecVal(trial)), gamblePosY(2) ,[1 0 0]);
                % Draw magnitude in green
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{targetRandPosVecVal(trial),2}, gambleMagPosX(targetRandPosVecVal(trial)), gamblePosY(1) ,[0 1 0]);
                
                %% ------------------------------------------------------------
                %--------------------Draw competitor gamble--------------------
                %--------------------------------------------------------------
                % Draw probability in red
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{competitorRandPosVecVal(trial),1}, gambleProbPosX(competitorRandPosVecVal(trial)), gamblePosY(2) ,[1 0 0]);
                % Draw magnitude in green
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{competitorRandPosVecVal(trial),2}, gambleMagPosX(competitorRandPosVecVal(trial)), gamblePosY(1) ,[0 1 0]);
                
                %% ------------------------------------------------------------
                %--------------------Flip the screen---------------------------
                %--------------------------------------------------------------
                Screen('Flip', window);
            end
            
            
            %% --------------------------------------------------------------------
            %--------------------Storage the answer for each trial-----------------
            %----------------------------------------------------------------------
            % [Trial Number, Response, Response Time]
            responseVecVal(trial,:)            =   [trial, (response==targetRandPosVecVal(trial)) * 1 + (response==competitorRandPosVecVal(trial)) * 2, endTime-startTime, 0, 0, 0, 0];
            
        else
            
            %% ----------------------------------------------------------------
            %--------------------If no proper feedback-------------------------
            %------------------------------------------------------------------
            % Put the trial back to stack
            [ trialStackVal ]               =   fPutTrialStack( trial, trialStackVal );
        end
        
        %% --------------------------------------------------------------------
        %------------------------Asking for a trial----------------------------
        %----------------------------------------------------------------------
        [trial, trialStackVal]             =   fPopTrialStack( trialStackVal );
        
    end
    %% ------------------------------------------------------------------------
    %--------------------Storage the answer------------------------------------
    %--------------------------------------------------------------------------
    % Fill the response vector = [Trial Number, Response, Response Time,
    %   randomized positions of the target, randomized positions of the competitor,
    %   magnitude of the target, magnitude of competitor]
    responseVecVal(:,4)                =   targetRandPosVecVal';
    responseVecVal(:,5)                =   competitorRandPosVecVal';
    responseVecVal(:,6)                =   targetMagVec';
    responseVecVal(:,7)                =   competitorMagVec';
    
    %%      Save the answers
    nameRespText            =   strcat('./Data/Storage1/responsesEstVal',nickname,'_',num2str(sessionin),'.txt');
    nameSnapText            =   strcat('./Data/Storage1/snapshotStoragEstVal',nickname,'_',num2str(sessionin),'.txt');
    % save the response vector
    csvwrite(nameRespText,responseVecVal);
    csvwrite(nameSnapText,snapshotStoragVal);
    
    nameRespMat            =   strcat('./Data/Storage1/responsesEstVal',nickname,'_',num2str(sessionin),'.mat');
    nameSnapMat            =   strcat('./Data/Storage1/snapshotStoragEstVal',nickname,'_',num2str(sessionin),'.mat');
    
    save(nameRespMat,'responseVecVal');
    save(nameSnapMat,'snapshotStoragVal');
    
    
    Screen('CloseAll');
    
catch ex
    Screen('CloseAll');
    
    ListenChar(1);
    ShowCursor;
    
    save('error.mat');                                                       % save the whole workspace to work on error
    disp('): something went wrong :(');
    disp(' ');
    rethrow(ex);
end