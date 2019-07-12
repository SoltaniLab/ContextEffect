%% ------------------------------------------------------------------------
%---------------------Clearing the workspace-------------------------------
%--------------------------------------------------------------------------
function decoyTaskValue(number, sessionin)
clc;
% clear all;

%% ------------------------------------------------------------------------
%----------------------General set-up--------------------------------------
%--------------------------------------------------------------------------
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);

%% ------------------------------------------------------------------------
%----------------------Load the parameters---------------------------------
%--------------------------------------------------------------------------
% decotrialgen1
load('./Data/decoyVarsVal.mat');
%load('partdata2.mat');

if nargin < 2
    number                  =   input('Participant Number: ','s');
    sessionin               =   input('Session Number: ');
end

nickname = strcat('P',number);
%% ------------------------------------------------------------------------
%----------------------Psychtoolbox set-up---------------------------------
%--------------------------------------------------------------------------
try
    % Get the screen numbers
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
    [screenXpixels, screenYpixels]  =   Screen('WindowSize', window);
    
    % Query the frame duration
    frameDuration                   =   Screen('GetFlipInterval', window);
    
    % Get the centre coordinate of the window
    [xCenter, yCenter]              =   RectCenter(windowRect);
    
    %% ------------------------------------------------------------------------
    %----------------------Positions-------------------------------------------
    %--------------------------------------------------------------------------
    %rectangle positions X:
    rectPos                         =   [screenXpixels*0.25 screenXpixels*0.5 screenXpixels*0.75];
    
    %gamble  probability positions X:
    gambleProbPosX                  =   [screenXpixels*0.22 screenXpixels*0.47 screenXpixels*0.72];
    
    %gamble magnitude positions X:
    gambleMagPosX                   =   [screenXpixels*0.22 screenXpixels*0.48 screenXpixels*0.72];
    
    %gamble positions Y:
    %gamblePosY(1)-> probability position
    %gamblePosY(2)-> magnitude position
    gamblePosY                      =   [screenYpixels*0.46 screenYpixels*0.57];
    
    %% ------------------------------------------------------------------------
    %------------------------Rectangles settings-------------------------------
    %--------------------------------------------------------------------------
    % Make a base Rect of 200 by 400 pixels
    baseRect                        =   [0 0 200 250];
    
    % Screen X positions of our two rectangles
    cardXPos                        =   rectPos;
    cardNumber                      =   length(cardXPos);
    
    % Make our rectangle coordinates for evaluation and choice
    rectCoords                      =   nan(4,cardNumber);
    
    for i = 1 : cardNumber
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
    
    % Set the line width for our fixation cross
    lineWidthPix                    =   4;
    
    %% ------------------------------------------------------------------------
    %------------------------Time----------------------------------------------
    %-------------------------------------------------------------------------
    % evaluation time in seconds and frames
    % evaTimeSecs = evalTimeSec;
    evaTimeFrames                   =   round(evalTimeSec / frameDuration);
    
    %choosing time in seconds and frames
    % choTimeSecs = choiceTimeSec;
    choTimeFrames                   =   round(choiceTimeSec / frameDuration);
    
    % Interstimulus interval time in seconds and frames
    % isiTimeSec = 1;
    isiTimeFrames                   =   round(isiTimeSec / frameDuration);
    
    % feedback time
    % feedTimeSecs = feedbackTimeSec;
    feedTimeFrames                  =   round(feedbackTimeSec / frameDuration);
    
    %Number of frames to wait before re-drawing
    waitFrames                      =   1;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    %% TRAINING VALUE
    trialStacktrai                      =   fGenTrialStack( size(trainingVal,1) );
    %% ------------------------------------------------------------------------
    %------------------------Asking for a trial--------------------------------
    %-----------------------------------------------------------------------
    [trialtrai, trialStacktrai]             =   fPopTrialStack( trialStacktrai );
    %%      Wait until a key is pressed
    KbPressWait
    
    
    %% ------------------------------------------------------------------------
    %------------------------Experimental round--------------------------------
    %--------------------------------------------------------------------------
    correctVal                      =  0;
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
        competitorMagString         =   int2str(trainingVal(trialtrai,3));
        DecoyMagString              =   int2str(trainingVal(trialtrai,5));
        
        targetProbString            =   strcat(int2str(trainingVal(trialtrai,2)),'%');
        competitorProbString        =   strcat(int2str(trainingVal(trialtrai,4)),'%');
        DecoyProbString             =   strcat(int2str(trainingVal(trialtrai,6)),'%');
        
        %we are going to represent them in a cell:
        finalStringCell             =   cell(3,2);
        % target gamble's values, row 1
        finalStringCell(1,:)        =   {targetProbString,targetMagString};
        % competitor gambles's values, row 2
        finalStringCell(2,:)        =   {competitorProbString,competitorMagString};
        % decoy's values, row 3
        finalStringCell(3,:)        =   {DecoyProbString,DecoyMagString};
        allColors                   =   [whiteColor; whiteColor;whiteColor];
        
        %we will create a vector contains the current positions to use it when we
        %have to select which one dissapears (in the choosing part)
        %     stay=[Trandpos(trial) Crandpos(trial) Drandpos(trial)];
        %we will create a vector with the order (1 left 2 right) of the gambles
        %staying for the feedback section
        %     unorder=[stay(decoyRandDist(trial,2)) stay(decoyRandDist(trial,3))];
        %     order=sort(unorder);
        
        %% --------------------------------------------------------------------
        %--------------------Reset response in each trial----------------------
        %----------------------------------------------------------------------
        response                    =   0;
        
        
        %% --------------------------------------------------------------------
        %--------------------Intertrial fixaction cross------------------------
        %----------------------------------------------------------------------
        for frame = 1 : isiTimeFrames - 1
            % Setup the text type for the window
            Screen('TextFont', window, 'Arial');
            Screen('TextSize', window, 36);
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, whiteColor, [xCenter yCenter], 2);
            Screen('Flip', window);
        end
        
        %% --------------------------------------------------------------------
        %--------------------Evaluation part-----------------------------------
        %----------------------------------------------------------------------
        for frame= 1 : evaTimeFrames
            %% ----------------------------------------------------------------
            %--------------------Draw the rectPos to the screen----------------
            %------------------------------------------------------------------
            Screen('FrameRect', window, allColors(1,:), rectCoords(:,1), penWidthPixels);
            Screen('FrameRect', window, allColors(2,:), rectCoords(:,2), penWidthPixels);
            Screen('FrameRect', window, allColors(3,:), rectCoords(:,3), penWidthPixels);
            
            %% ----------------------------------------------------------------
            %--------------------Draw texts to the screen----------------------
            %------------------------------------------------------------------
            % Draw text in the middle of the screen in Courier in white 'Evaluate'
            Screen('TextSize', window, 80);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, 'Evaluate', 'center', screenYpixels * 0.15, whiteColor);
            
            %% ----------------------------------------------------------------
            %--------------------Draw target gamble----------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{1,1}, gambleProbPosX(1), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{1,2}, gambleMagPosX(1), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw competitor gamble------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{2,1}, gambleProbPosX(2), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{2,2}, gambleMagPosX(2), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw Decoy gamble-----------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{3,1}, gambleProbPosX(3), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{3,2}, gambleMagPosX(3), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Flip the screen-------------------------------
            %------------------------------------------------------------------
            Screen('Flip', window);
            
        end
        
        %% --------------------------------------------------------------------
        %--------------------Choosing part-------------------------------------
        %----------------------------------------------------------------------
        % Setting start time
        startTime                       =   GetSecs;
        endTime                         =   GetSecs;
        
        %% ----------------------------------------------------------------
        %--------------------Define a response flag (not maked)------------
        %The participant has to make a choice now
        respToBeMade                =  true;
        
        for frame= 1:choTimeFrames
            
            
            %% ----------------------------------------------------------------
            %--------------------Computing the apearing element and position---
            %------------------------------------------------------------------
            % apearing Elements (1-> target, 2-> competitor, 3-> decoy)
            apearElms                       =   setdiff([1 2 3],trainingVal(trialtrai,8));
            % apearing Elements Position (1-> left, 2-> middle, 3-> right)
            apearElmsPos                    =   apearElms;
            
            %% ----------------------------------------------------------------
            %--------------------Make a sorted version-------------------------
            %------------------------------------------------------------------
            % Sort the apearing elements to make it usable for response
            % First Row is the elements itself
            % Second row is the position of the element
            apear                           =   [apearElms;apearElmsPos];
            [B,I]                           =   sort(apear(2,:));
            apearSorted                     =   [apear(1,I);B];
            
            if (response == 0)
                %% ----------------------------------------------------------------
                %--------------------Draw the rectPos to the screen----------------
                %------------------------------------------------------------------
                % Draw the rect to the screen (only the ones that don't disapear)
                Screen('FrameRect', window, allColors(apearElmsPos(1),:), rectCoords(:,apearElmsPos(1)), penWidthPixels);
                Screen('FrameRect', window, allColors(apearElmsPos(2),:), rectCoords(:,apearElmsPos(2)), penWidthPixels);
            else
                % Draw the choosen gamble on the screen in yellow
                Screen('FrameRect', window, [1 1 0], feedRects, penWidthPixels);
                % Draw the unchosen gamble on white
                Screen('FrameRect', window, whiteColor, unchoRects, penWidthPixels);
            end
            %% ----------------------------------------------------------------
            %--------------------Draw texts to the screen----------------------
            %------------------------------------------------------------------
            % Draw text in the middle of the screen in Courier in white 'Choose'
            Screen('TextSize', window, 80);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, 'Choose', 'center', screenYpixels * 0.15, whiteColor);
            
            %% ----------------------------------------------------------------
            %--------------------Draw first gamble-----------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{apearElms(1),1}, gambleProbPosX(apearElmsPos(1)), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{apearElms(1),2}, gambleMagPosX(apearElmsPos(1)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw second gamble----------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{apearElms(2),1}, gambleProbPosX(apearElmsPos(2)), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{apearElms(2),2}, gambleMagPosX(apearElmsPos(2)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Flip the screen-------------------------------
            %------------------------------------------------------------------
            Screen('Flip', window);
            
            %% ----------------------------------------------------------------
            %--------------------Key press check-------------------------------
            %------------------------------------------------------------------
            [keyIsDown,secs, keyCode]       =   KbCheck;
            
            %% ----------------------------------------------------------------
            %--------------------Esc key check---------------------------------
            %------------------------------------------------------------------
            if keyCode(escapeKey)
                %% ------------------------------------------------------------
                %--------------------Exit--------------------------------------
                %--------------------------------------------------------------
                sca;
                response                    =   0 ;
                return
                
            elseif xor(keyCode(leftKey), keyCode(rightKey))
                %% ------------------------------------------------------------
                %--------------------Store current time------------------------
                %--------------------------------------------------------------
                endTime                     =   GetSecs;
                
                %% ------------------------------/home/spitmaan/Matlab/code------------------------------
                %--------------------Change the response flag to maked---------
                %--------------------------------------------------------------
                respToBeMade                =   false;
                
                %% ------------------------------------------------------------
                %--------------------Store the response------------------------
                %--------------------------------------------------------------
                response                    =   keyCode(leftKey) + (keyCode(rightKey) * 2);
                if (response < 3)
                    
                    %             allColors(apearSorted(2,response),:)                      =   yellowColor;
                    %             choiceOptions                                             =   [1:3];
                    %             nonChosen                                                 =   setdiff(choiceOptions,response);
                    %             allColors(apearSorted(2,nonChosen(1)),:)                  =   whiteColor;
                    %             allColors(apearSorted(2,nonChosen(1)),:)                  =   whiteColor;
                    
                    
                    %--------------------Set feedback rectangles-------------------
                    %--------------------------------------------------------------
                    % Make our rectangle coordinates for feedback, the choosen one
                    %order gives the gambles, so the choosen one will be feedRects
                    %and the unchochen one unchoRects
                    feedRects                   =   nan(4,cardNumber-1);
                    for i = 1 : cardNumber - 1
                        feedRects(:, i)         =   CenterRectOnPointd(baseRect, cardXPos(apearSorted(2,response)), yCenter);
                    end
                    
                    % Make our rectangle coordinates for the feedback, the unchosen one
                    unchoRects                  =   nan(4,cardNumber-1);
                    for i = 1 : cardNumber - 1
                        unchoRects(:, i)        =   CenterRectOnPointd(baseRect, cardXPos(apearSorted(2,3-response)), yCenter);
                    end
                else
                    response = 0;
                end
            end
        end
        
        
        %% --------------------------------------------------------------------
        %--------------------Feedback part-------------------------------------
        %----------------------------------------------------------------------
        %show the feedback only when the responses are correctly made
        
        if (response == 1 || response == 2)
            for frame=1 : feedTimeFrames
                %% ------------------------------------------------------------
                %--------------------Draw gamble cards-------------------------
                %--------------------------------------------------------------
                %             % Draw the choosen gamble on the screen in yellow
                %                 Screen('FrameRect', window,allColors(response,:) , feedRects, penWidthPixels);
                %             % Draw the unchosen gamble on whiteColor
                %                 Screen('FrameRect', window, allColors(nonChosen(1),:) , unchoRects, penWidthPixels);
                
                % Draw the choosen gamble on the screen in yellow
                Screen('FrameRect', window, [1 1 0], feedRects, penWidthPixels);
                % Draw the unchosen gamble on white
                Screen('FrameRect', window, whiteColor, unchoRects, penWidthPixels);
                %% ------------------------------------------------------------
                %--------------------Draw texts--------------------------------
                %--------------------------------------------------------------
                %Draw text in the middle of the screen in Courier in white 'Choose'
                Screen('TextSize', window, 80);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window, 'Choose', 'center', screenYpixels * 0.15, whiteColor);
                
                %% ----------------------------------------------------------------
                %--------------------Draw first gamble-----------------------------
                %------------------------------------------------------------------
                %       Draw probability in red
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{apearElms(1),1}, gambleProbPosX(apearElmsPos(1)), gamblePosY(2) ,[1 0 0]);
                %       Draw magnitude in green
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{apearElms(1),2}, gambleMagPosX(apearElmsPos(1)), gamblePosY(1) ,[0 1 0]);
                
                %% ----------------------------------------------------------------
                %--------------------Draw second gamble----------------------------
                %------------------------------------------------------------------
                %       Draw probability in red
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{apearElms(2),1}, gambleProbPosX(apearElmsPos(2)), gamblePosY(2) ,[1 0 0]);
                %       Draw magnitude in green
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{apearElms(2),2}, gambleMagPosX(apearElmsPos(2)), gamblePosY(1) ,[0 1 0]);
                %% ------------------------------------------------------------
                %--------------------Flip the screen---------------------------
                %--------------------------------------------------------------
                Screen('Flip', window);
                
                storedResponse              =   apearSorted(1,response);
            end
            
            
            
            %% --------------------------------------------------------------------
            %--------------------Storage the answer for each trial-----------------
            %----------------------------------------------------------------------
            % [Trial Number, Response, Response Time]
            responseVecTrainingValDec(trialtrai,1)            =   response;
            
            if (response == trainingVal(trialtrai,7))
                correctVal=correctVal+1;
                
            end
            responseVecTrainingValDec(trialtrai,9)            =   correctVal;
            
        else
            %% ----------------------------------------------------------------
            %--------------------If no proper feedback-------------------------
            %------------------------------------------------------------------
            % Put the trial back to stack
            [ trialStacktrai ]               =   fPutTrialStack( trialtrai, trialStacktrai );
        end
        
        %% --------------------------------------------------------------------
        %------------------------Asking for a trial----------------------------
        %----------------------------------------------------------------------
        [trialtrai, trialStacktrai]             =   fPopTrialStack( trialStacktrai );
        
        
    end
    responseVecTrainingValDec(:,2)                =     trainingVal(:,1);
    responseVecTrainingValDec(:,3)                =     trainingVal(:,2);
    responseVecTrainingValDec(:,4)                =     trainingVal(:,3);
    responseVecTrainingValDec(:,5)                =     trainingVal(:,4);
    responseVecTrainingValDec(:,6)                =     trainingVal(:,5);
    responseVecTrainingValDec(:,7)                =     trainingVal(:,6);
    responseVecTrainingValDec(:,8)                =     trainingVal(:,7);
    
    nameRespMatTra            =   strcat('./Data/Storage1/DecTrainingVal',nickname,'_',num2str(sessionin),'.mat');
    
    save(nameRespMatTra,'responseVecTrainingValDec');
    KbPressWait
    Screen('Flip', window);
    if (correctVal<7)
        rethrow(struct('message','You are not doing well!!! :('))
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    %% ------------------------------------------------------------------------
    %------------------------Asking for a trial--------------------------------
    %--------------------------------------------------------------------------
    [trial, trialStack]             =   fPopTrialStack( trialStack );
    
    snapshotCnt                     =   1;
    
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
        targetMagString             =   int2str(magProbVector(trial,1));
        competitorMagString         =   int2str(magProbVector(trial,3));
        DecoyMagString              =   int2str(decoyMat(trial,1));
        
        targetProbString            =   strcat(int2str(magProbVector(trial,2)),'%');
        competitorProbString        =   strcat(int2str(magProbVector(trial,4)),'%');
        DecoyProbString             =   strcat(int2str(decoyMat(trial,2)),'%');
        
        %we are going to represent them in a cell:
        finalStringCell             =   cell(3,2);
        % target gamble's values, row 1
        finalStringCell(1,:)        =   {targetProbString,targetMagString};
        % competitor gambles's values, row 2
        finalStringCell(2,:)        =   {competitorProbString,competitorMagString};
        % decoy's values, row 3
        finalStringCell(3,:)        =   {DecoyProbString,DecoyMagString};
        allColors                   =   [whiteColor; whiteColor;whiteColor];
        
        %we will create a vector contains the current positions to use it when we
        %have to select which one dissapears (in the choosing part)
        %     stay=[Trandpos(trial) Crandpos(trial) Drandpos(trial)];
        %we will create a vector with the order (1 left 2 right) of the gambles
        %staying for the feedback section
        %     unorder=[stay(decoyRandDist(trial,2)) stay(decoyRandDist(trial,3))];
        %     order=sort(unorder);
        
        
        tempRandPosVec = randperm(3);
        storedRandPosVec = randPosVec(trial,:);
        
        %% --------------------------------------------------------------------
        %--------------------Reset response in each trial----------------------
        %----------------------------------------------------------------------
        response                    =   0;
        
        
        %% --------------------------------------------------------------------
        %--------------------Intertrial fixaction cross------------------------
        %----------------------------------------------------------------------
        for frame = 1 : isiTimeFrames - 1
            % Setup the text type for the window
            Screen('TextFont', window, 'Arial');
            Screen('TextSize', window, 36);
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, whiteColor, [xCenter yCenter], 2);
            Screen('Flip', window);
        end
        
        %% --------------------------------------------------------------------
        %--------------------Evaluation part-----------------------------------
        %----------------------------------------------------------------------
        for frame= 1 : evaTimeFrames
            %% ----------------------------------------------------------------
            %--------------------Draw the rectPos to the screen----------------
            %------------------------------------------------------------------
            Screen('FrameRect', window, allColors(1,:), rectCoords(:,1), penWidthPixels);
            Screen('FrameRect', window, allColors(2,:), rectCoords(:,2), penWidthPixels);
            Screen('FrameRect', window, allColors(3,:), rectCoords(:,3), penWidthPixels);
            
            %% ----------------------------------------------------------------
            %--------------------Draw texts to the screen----------------------
            %------------------------------------------------------------------
            % Draw text in the middle of the screen in Courier in white 'Evaluate'
            Screen('TextSize', window, 80);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, 'Evaluate', 'center', screenYpixels * 0.15, whiteColor);
            
            %% ----------------------------------------------------------------
            %--------------------Draw target gamble----------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{1,1}, gambleProbPosX(tempRandPosVec(1)), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{1,2}, gambleMagPosX(tempRandPosVec(1)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw competitor gamble------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{2,1}, gambleProbPosX(tempRandPosVec(2)), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{2,2}, gambleMagPosX(tempRandPosVec(2)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw Decoy gamble-----------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{3,1}, gambleProbPosX(tempRandPosVec(3)), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{3,2}, gambleMagPosX(tempRandPosVec(3)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Flip the screen-------------------------------
            %------------------------------------------------------------------
            Screen('Flip', window);
            
        end
        
        %% --------------------------------------------------------------------
        %--------------------Choosing part-------------------------------------
        %----------------------------------------------------------------------
        % Setting start time
        startTime                       =   GetSecs;
        endTime                         =   GetSecs;
        
        %% ----------------------------------------------------------------
        %--------------------Define a response flag (not maked)------------
        %The participant has to make a choice now
        respToBeMade                =  true;
        
        for frame= 1:choTimeFrames
            
            
            %% ----------------------------------------------------------------
            %--------------------Computing the apearing element and position---
            %------------------------------------------------------------------
            % apearing Elements (1-> target, 2-> competitor, 3-> decoy)
            apearElms                       =   setdiff([1 2 3],decoyTypeRandValCon(trial,2));
            % apearing Elements Position (1-> left, 2-> middle, 3-> right)
            apearElmsPos                    =   tempRandPosVec(apearElms);
            
            %% ----------------------------------------------------------------
            %--------------------Make a sorted version-------------------------
            %------------------------------------------------------------------
            % Sort the apearing elements to make it usable for response
            % First Row is the elements itself
            % Second row is the position of the element
            apear                           =   [apearElms;apearElmsPos];
            [B,I]                           =   sort(apear(2,:));
            apearSorted                     =   [apear(1,I);B];
            
            if (response == 0)
                %% ----------------------------------------------------------------
                %--------------------Draw the rectPos to the screen----------------
                %------------------------------------------------------------------
                % Draw the rect to the screen (only the ones that don't disapear)
                Screen('FrameRect', window, allColors(apearElmsPos(1),:), rectCoords(:,apearElmsPos(1)), penWidthPixels);
                Screen('FrameRect', window, allColors(apearElmsPos(2),:), rectCoords(:,apearElmsPos(2)), penWidthPixels);
            else
                % Draw the choosen gamble on the screen in yellow
                Screen('FrameRect', window, [1 1 0], feedRects, penWidthPixels);
                % Draw the unchosen gamble on white
                Screen('FrameRect', window, whiteColor, unchoRects, penWidthPixels);
            end
            %% ----------------------------------------------------------------
            %--------------------Draw texts to the screen----------------------
            %------------------------------------------------------------------
            % Draw text in the middle of the screen in Courier in white 'Choose'
            Screen('TextSize', window, 80);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, 'Choose', 'center', screenYpixels * 0.15, whiteColor);
            
            %% ----------------------------------------------------------------
            %--------------------Draw first gamble-----------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{apearElms(1),1}, gambleProbPosX(apearElmsPos(1)), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{apearElms(1),2}, gambleMagPosX(apearElmsPos(1)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Draw second gamble----------------------------
            %------------------------------------------------------------------
            %       Draw probability in red
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{apearElms(2),1}, gambleProbPosX(apearElmsPos(2)), gamblePosY(2) ,[1 0 0]);
            %       Draw magnitude in green
            Screen('TextSize', window, 50);
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window,finalStringCell{apearElms(2),2}, gambleMagPosX(apearElmsPos(2)), gamblePosY(1) ,[0 1 0]);
            
            %% ----------------------------------------------------------------
            %--------------------Flip the screen-------------------------------
            %------------------------------------------------------------------
            Screen('Flip', window);
            
            %% ----------------------------------------------------------------
            %--------------------Key press check-------------------------------
            %------------------------------------------------------------------
            [keyIsDown,secs, keyCode]       =   KbCheck;
            
            %% ----------------------------------------------------------------
            %--------------------Esc key check---------------------------------
            %------------------------------------------------------------------
            if keyCode(escapeKey)
                %% ------------------------------------------------------------
                %--------------------Exit--------------------------------------
                %--------------------------------------------------------------
                sca;
                response                    =   0 ;
                return
                
            elseif xor(keyCode(leftKey), keyCode(rightKey))
                %% ------------------------------------------------------------
                %--------------------Store current time------------------------
                %--------------------------------------------------------------
                endTime                     =   GetSecs;
                
                %% ------------------------------/home/spitmaan/Matlab/code------------------------------
                %--------------------Change the response flag to maked---------
                %--------------------------------------------------------------
                respToBeMade                =   false;
                
                %% ------------------------------------------------------------
                %--------------------Store the response------------------------
                %--------------------------------------------------------------
                response                    =   keyCode(leftKey) + (keyCode(rightKey) * 2);
                if (response < 3)                     
                
                %             allColors(apearSorted(2,response),:)                      =   yellowColor;
                %             choiceOptions                                             =   [1:3];
                %             nonChosen                                                 =   setdiff(choiceOptions,response);
                %             allColors(apearSorted(2,nonChosen(1)),:)                  =   whiteColor;
                %             allColors(apearSorted(2,nonChosen(1)),:)                  =   whiteColor;
                
                 
                %--------------------Set feedback rectangles-------------------
                %--------------------------------------------------------------
                % Make our rectangle coordinates for feedback, the choosen one
                %order gives the gambles, so the choosen one will be feedRects
                %and the unchochen one unchoRects
                feedRects                   =   nan(4,cardNumber-1);
                for i = 1 : cardNumber - 1 
                    feedRects(:, i)         =   CenterRectOnPointd(baseRect, cardXPos(apearSorted(2,response)), yCenter);
                end
                
                % Make our rectangle coordinates for the feedback, the unchosen one
                unchoRects                  =   nan(4,cardNumber-1);
                for i = 1 : cardNumber - 1
                    unchoRects(:, i)        =   CenterRectOnPointd(baseRect, cardXPos(apearSorted(2,3-response)), yCenter);
                end
                else 
                    response = 0;
                end
            end
        end
        %% --------------------------------------------------------------------
        %--------------------Snapshop Storage--- -------------------------------
        %----------------------------------------------------------------------
        %   snapshotStorag          = target Magnitude
        %                             target Probability
        %                             competitor Magnitude
        %                             competitor Probability
        %                             decoy Magnitude
        %                             decoy Probability
        %                             response (1 target, 2 competitor, 3 decoy)
        %                             time
        if (response==0)
            snapshotStorag(snapshotCnt,:) = [magProbVector(trial,1), magProbVector(trial,2),...
                magProbVector(trial,3),magProbVector(trial,4),...
                decoyMat(trial,2),decoyMat(trial,1),...
                0,endTime-startTime, trial];
            snapshotCnt = snapshotCnt + 1;
        else
            snapshotStorag(snapshotCnt,:) = [magProbVector(trial,1), magProbVector(trial,2),...
                magProbVector(trial,3),magProbVector(trial,4),...
                decoyMat(trial,2),decoyMat(trial,1),...
                apearSorted(1,response),endTime-startTime, trial];
            snapshotCnt = snapshotCnt + 1;
        end
        
        
        %% --------------------------------------------------------------------
        %--------------------Feedback part-------------------------------------
        %----------------------------------------------------------------------
        %show the feedback only when the responses are correctly made
        
        if (response == 1 || response == 2)
            for frame=1 : feedTimeFrames
                %% ------------------------------------------------------------
                %--------------------Draw gamble cards-------------------------
                %--------------------------------------------------------------
                %             % Draw the choosen gamble on the screen in yellow
                %                 Screen('FrameRect', window,allColors(response,:) , feedRects, penWidthPixels);
                %             % Draw the unchosen gamble on whiteColor
                %                 Screen('FrameRect', window, allColors(nonChosen(1),:) , unchoRects, penWidthPixels);
                
                % Draw the choosen gamble on the screen in yellow
                Screen('FrameRect', window, [1 1 0], feedRects, penWidthPixels);
                % Draw the unchosen gamble on white
                Screen('FrameRect', window, whiteColor, unchoRects, penWidthPixels);
                %% ------------------------------------------------------------
                %--------------------Draw texts--------------------------------
                %--------------------------------------------------------------
                %Draw text in the middle of the screen in Courier in white 'Choose'
                Screen('TextSize', window, 80);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window, 'Choose', 'center', screenYpixels * 0.15, whiteColor);
                
                %% ----------------------------------------------------------------
                %--------------------Draw first gamble-----------------------------
                %------------------------------------------------------------------
                %       Draw probability in red
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{apearElms(1),1}, gambleProbPosX(apearElmsPos(1)), gamblePosY(2) ,[1 0 0]);
                %       Draw magnitude in green
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{apearElms(1),2}, gambleMagPosX(apearElmsPos(1)), gamblePosY(1) ,[0 1 0]);
                
                %% ----------------------------------------------------------------
                %--------------------Draw second gamble----------------------------
                %------------------------------------------------------------------
                %       Draw probability in red
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{apearElms(2),1}, gambleProbPosX(apearElmsPos(2)), gamblePosY(2) ,[1 0 0]);
                %       Draw magnitude in green
                Screen('TextSize', window, 50);
                Screen('TextFont', window, 'Arial');
                DrawFormattedText(window,finalStringCell{apearElms(2),2}, gambleMagPosX(apearElmsPos(2)), gamblePosY(1) ,[0 1 0]);
                %% ------------------------------------------------------------
                %--------------------Flip the screen---------------------------
                %--------------------------------------------------------------
                Screen('Flip', window);
                
                storedResponse              =   apearSorted(1,response);
            end
            
            
            %% --------------------------------------------------------------------
            %--------------------Storage the answer for each trial-----------------
            %----------------------------------------------------------------------
            % [Trial Number, Response, Response Time]
            responseVec(trial,:)            =   [trial, storedResponse, endTime-startTime, 0, 0, 0, 0];
            
        else
            %% ----------------------------------------------------------------
            %--------------------If no proper feedback-------------------------
            %------------------------------------------------------------------
            % Put the trial back to stack
            [ trialStack ]               =   fPutTrialStackCon( trial, trialStack );
        end
        
        %% --------------------------------------------------------------------
        %------------------------Asking for a trial----------------------------
        %----------------------------------------------------------------------
        [trial, trialStack]             =   fPopTrialStack( trialStack );
    end
    
    
    %% ------------------------------------------------------------------------
    %--------------------Storage the answer------------------------------------
    %--------------------------------------------------------------------------
    % Fill the response vector = [Trial Number, Response, Response Time,
    %   randomized positions of the target, randomized positions of the competitor,
    %   randomized position of the decoy, magnitude of the target,
    %   probability of the target, magnitude of competitor, probability of the decoy,
    %   magnitude of the decoy, probabilities of the decoy,
    %   decoy type, disapearing type, decoy distance]
    
    
    % Response (in the second column) is : 1-> Target, 2-> Competitor, 3-> Decoy
    
    responseVec(:,4)                =   randPosVec(:,1)';
    responseVec(:,5)                =   randPosVec(:,2)';
    responseVec(:,6)                =   randPosVec(:,3)';
    responseVec(:,7)                =   magProbVector(:,1)';
    responseVec(:,8)                =   magProbVector(:,2)';
    responseVec(:,9)                =   magProbVector(:,3)';
    responseVec(:,10)               =   magProbVector(:,4)';
    responseVec(:,11)               =   decoyMat(:,1);
    responseVec(:,12)               =   decoyMat(:,2);
    responseVec(:,13)               =   decoyTypeRandValCon(:,1);
    responseVec(:,14)               =   decoyTypeRandValCon(:,2);
    responseVec(:,15)               =   decoyTypeRandValCon(:,3);   
    
    
    
    %%      Save the asnwers
   % nameResp            =   strcat('responsesDecoyValCon',nickname,'_',sessionin,'.txt');
   % nameSnap            =   strcat('snapshotStoragDecoyValCon',nickname,'_',sessionin,'.txt');
    nameResp            =   strcat('./Data/Storage1/responsesDecoyValCon',nickname,'_',num2str(sessionin),'.txt');
    nameSnap            =   strcat('./Data/Storage1/snapshotStoragDecoyValCon',nickname,'_',num2str(sessionin),'.txt');
    % save the response vector
    csvwrite(nameResp,responseVec);
    csvwrite(nameSnap,snapshotStorag);
    
    nameRespMat            =   strcat('./Data/Storage1/responsesDecoyValCon',nickname,'_',num2str(sessionin),'.mat');
    nameSnapMat            =   strcat('./Data/Storage1/snapshotStoragDecoyValCon',nickname,'_',num2str(sessionin),'.mat');
   
    save(nameRespMat,'responseVec');
    save(nameSnapMat,'snapshotStorag');

    
    
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