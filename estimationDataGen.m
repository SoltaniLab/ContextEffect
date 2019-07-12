%% ------------------------------------------------------------------------
%---------------------Copyright Statement----------------------------------
%--------------------------------------------------------------------------
function estimationDataGen
%% ------------------------------------------------------------------------
%---------------------Parameters: defined by the experimenter--------------
%--------------------------------------------------------------------------
% targetReward                  =   Reward of the target gamble
% targetProbability             =   Probability of the target gamble
% competitorReward              =   Reward of the competitor gamble*
% competitorProbability         =   Probability of the competitor gamble
% targetLenght                  =   Lenght of the target
% targetAngle                   =   Angle of the target
% competitorReward              =   Reward of the competitor*
% competitorAngle               =   Angle of the competitor
% trialNumber                   =   Number of trials
% trialNumber                   =   Number of trials
% evalTimeSec                   =   Evaluation time (Sec)
% choiceTimeSec                 =   Choice time (Sec)
% feedbackTimeSec               =   Feedback time (Sec)
% isiTimeSec                    =   Interstimulus interval time
% snapshotStorag                =   Snapshot Storage
% snapshotCnt                   =   Snapshot Storage Counter
%
% cardNumber                    =   Number of cards = 2 (Fixed)
%
% targetRandPosVecVal           =   Vector of the randomized positions of the target gamble
% competitorRandPosVecVal       =   Vector of the randomized positions of the competitor gamble
%
% targetRandPosVecVis           =   Vector of the randomized positions of the target gamble
% competitorRandPosVecVis       =   Vector of the randomized positions of the competitor gamble
%
%
% parameterNumber               =   Number of stored parameters = 7 (Fixed)
% responseVecVal                =   Responses vector
% responseVecVis                =   Responses vector
%
% targetLenVecVal               =   Lenght vector of the target
% competitorLenVecVal           =   Lenght vector of the competitor
%
% targetMagVecVis               =   Magnitude vector of the target
% competitorMagVecVis           =   Magnitude vector of the competitor
%
% * This parameter is dependent on targetReward, not pre-defined.

%% ------------------------------------------------------------------------
%---------------------Hints: defined by the developer :)------------------
%--------------------------------------------------------------------------
%
% 1                             ->  Left position in the screen
% 2                             ->  Right position in the screen
%% ------------------------------------------------------------------------
%---------------------Clearing the workspace-------------------------------
%--------------------------------------------------------------------------
clc;
%% ------------------------------------------------------------------------
%---------------------Setting the seed for random generator----------------
%--------------------------------------------------------------------------
% To set the seed for random number generator based on clock
rng('Shuffle')

%% ------------------------------------------------------------------------
%---------------------Key Names Unification--------------------------------
%--------------------------------------------------------------------------
% Unifying Key Names - Maybe dows not work on Windows!!
KbName('UnifyKeyNames');

%% ------------------------------------------------------------------------
%------------------ Values of the parameters-------------------------------
%--------------------------------------------------------------------------
trialNumber                     =   70;
trialStackVal                   =   fGenTrialStack( trialNumber );
trialStackVis                   =   fGenTrialStack( trialNumber );

targetMag                       =   20;
targetProbability               =   70;
competitorProbability           =   30;

competitorLength                =   250;
competitorAngle                 =   65;
targetAngle                     =   25;

evalTimeSec                     =   4;
choiceTimeSec                   =   1;
feedbackTimeSec                 =   1;
isiTimeSec                      =   1;

cardNumber                      =   2;
barNumber                       =   2;

parameterNumber                 =   7;

baseLineDistance                =   10;

guideLineDistance               =   150;
guidLineLenght                  =   4/3*competitorLength*cosd(competitorAngle);

snapshotCntVal                  =   1;
snapshotCntVis                  =   1;


%% ------------------------------------------------------------------------
%------------------ trialNumber / cardNumber divisibility------------------
%--------------------------------------------------------------------------
% Checking divisibility trialNumber by cardNumber
if rem(trialNumber, cardNumber) ~= 0
    warning('number of trials must be divisible by the number of gambles in the choosing phase');
    return;
end

%% ------------------------------------------------------------------------
%------------------ Randomization of the gambles position------------------
%--------------------------------------------------------------------------
% Vector of the randomized position of the target gamble
targetRandPosVecVal                =   Shuffle1([ones(1,trialNumber/cardNumber),2*ones(1,trialNumber/cardNumber)]);
% Vector of the randomized position of the competitor gamble (Complementry of target vector)
competitorRandPosVecVal            =   3*ones(1,trialNumber)-targetRandPosVecVal;

%% ------------------------------------------------------------------------
%------------------ Randomization of the gambles position------------------
%--------------------------------------------------------------------------
% Vector of the randomized position of the target gamble
targetRandPosVecVis                =   Shuffle1([ones(1,trialNumber/barNumber),2*ones(1,trialNumber/barNumber)]);
% Vector of the randomized position of the competitor gamble (Complementry of target vector)
competitorRandPosVecVis            =   3*ones(1,trialNumber)-targetRandPosVecVis;
% Vector of randomized variation variables
competitorVariationVarVecVis       =   Shuffle1([-1:2/trialNumber:1]);

%% ------------------------------------------------------------------------
%------------------------Responses vector----------------------------------
%--------------------------------------------------------------------------
responseVecVal                     =   zeros(trialNumber,parameterNumber);

responseVecVis                     =   zeros(trialNumber,parameterNumber);

%% ------------------------------------------------------------------------
%------------------------Keyboard Settings---------------------------------
%--------------------------------------------------------------------------
% The choice will be made using the arrows of the keyboard

% Esc key
escapeKey                       =   KbName('ESCAPE');
% Left gamble
leftKey                         =   KbName('f');
% Right gamble
rightKey                        =   KbName('j');

%% Training Vectors: 

% Value: 
% TrainingVal             = [Magnitude left, probability left, correct response (1 left 2 right), magnitude right, probability right,]
trainingVal               =   Shuffle1([70,50,1,50,30;...
                                       20,39,2,30,40;...
                                       11,10,2,10,20;...
                                       40,90,1,50,10;...
                                       75,45,1,45,25;...
                                       25,28,2,35,30;...
                                       60,50,2,61,60;...
                                       45,85,1,55,5],2);
responseVecTrainingVal    = zeros(size(trainingVal));
                                   
% Visual
% TrainingVal             = [length left, angle left, correct response (1 left 2 right), length right, angley right]
trainingVis               =   Shuffle1([200,10,1,70,70;...
                                       80,40,2,220,40;...
                                       200,70,2,200,20;...
                                       170,20,1,220,80;...
                                       200,10,1,70,70;...
                                       80,40,2,220,40;...
                                       200,70,2,200,20;...
                                       170,20,1,220,80],2);
responseVecTrainingVis    = zeros(size(trainingVis));                                  
                                   
                                   
                                   





%% ------------------------------------------------------------------------
%------------------------Magnitude Vectors Assignment----------------------
%--------------------------------------------------------------------------
% The magnitude of the target will vary randomly %10 from targetReward in each trial
targetMagMin                    = round(targetMag*0.9);
targetMagMax                    = round(targetMag*1.1);
targetMagPoints                 = round(targetMagMax-targetMagMin)+1;
targetMagValues                 = linspace(targetMagMin,targetMagMax,targetMagPoints);

repetitionsTargetVal            = floor(trialNumber/targetMagPoints);
extraVal                        = trialNumber-repetitionsTargetVal*targetMagPoints;

targetMagAll                    = horzcat(repmat(targetMagValues',repetitionsTargetVal,1)',...
                                  randsample(targetMagValues,extraVal));

targetMagVec                    = Shuffle1(targetMagAll);

% The lenght of the target will vary randomly %10 from targetLenght in each trial
competitorLenMin                    = round(competitorLength*0.9);
competitorLenMax                    = round(competitorLength*1.1);
competitorLenPoints                 = round(competitorLenMax-competitorLenMin)+1;
competitorLenValues                 = linspace(competitorLenMin,competitorLenMax,competitorLenPoints);

repetitionsCompetitorVis            = floor(trialNumber/competitorLenPoints);
extraVis                            = trialNumber-repetitionsCompetitorVis*competitorLenPoints;

competitorLenAll                    = horzcat(repmat(competitorLenValues',repetitionsCompetitorVis,1)',...
                                             randsample(competitorLenValues,extraVis));

competitorLenVec                    = Shuffle1(competitorLenAll);

% The magnitude of the competitor gamble will vary randomly from 150% of targetMagVec to 400% in each trial

competitorMagMin                   = round(targetMag*1.5);
competitorMagMax                   = round(targetMag*4);
competitorMagPoints                = round((competitorMagMax-competitorMagMin)/3);
CompetitorMagValues                = linspace(competitorMagMin,competitorMagMax,competitorMagPoints);

repetitionsCompetitor              = floor(trialNumber/competitorMagPoints);
extraVal                           = trialNumber-repetitionsCompetitor*competitorMagPoints;

competitorMagAll                   = horzcat(repmat(CompetitorMagValues',repetitionsCompetitor,1)', randsample(CompetitorMagValues,extraVal));

competitorMagVec                   = Shuffle1(competitorMagAll);


% The lenght of the competitor will vary randomly from 80% of the competitor shadow to 120% of the competitor shadow
                                   % 0.9 - 1.7
targetLenMin                   = round(competitorLength*cosd(competitorAngle)/cosd(targetAngle)*0.8);
targetLenMax                   = round(competitorLength*cosd(competitorAngle)/cosd(targetAngle)*1.6);
targetLenPoints                = round((targetLenMax-targetLenMin)/5);
targetLenValues                = linspace(targetLenMin,targetLenMax,targetLenPoints);

repetitionsTarget              = floor(trialNumber/targetLenPoints);
extraVis                       = trialNumber-repetitionsTarget*targetLenPoints;

targetLenAll                   = horzcat(repmat(targetLenValues',repetitionsTarget,1)', randsample(targetLenValues,extraVis));

targetLenVec                   = Shuffle1(targetLenAll);

%% ------------------------------------------------------------------------
%------------------------Saving Parameters---------------------------------
%--------------------------------------------------------------------------
save('./Data/estiData.mat',...
    'competitorMagVec','competitorProbability',...
    'competitorRandPosVecVal','escapeKey','leftKey',...
    'trialNumber','trialStackVal','trialStackVis','cardNumber','responseVecVal','rightKey',...
    'choiceTimeSec','evalTimeSec','feedbackTimeSec','targetMagVec',...
    'targetProbability','targetRandPosVecVal', 'isiTimeSec','competitorLenVec','competitorAngle',...
    'competitorRandPosVecVis','responseVecVis','targetLenVec',...
    'targetAngle','targetRandPosVecVis',...
    'competitorVariationVarVecVis', 'baseLineDistance',...
    'guideLineDistance', 'guidLineLenght',...
    'snapshotCntVal','snapshotCntVis','trainingVal','trainingVis',...
    'responseVecTrainingVal','responseVecTrainingVis');



