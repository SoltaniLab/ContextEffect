%% ------------------------------------------------------------------------
%---------------------Copyright Statement----------------------------------
%--------------------------------------------------------------------------
function decoyDataGenValue(number, sessionin)
%% ------------------------------------------------------------------------
%---------------------Parameters: defined by the experimenter--------------
%--------------------------------------------------------------------------
% targetReward                  =   Reward of the target gamble*
% targetProbability             =   Probability of the target gamble*
% competitorReward              =   Reward of the competitor gamble*+
% competitorProbability         =   Probability of the competitor gamble*
% trialNumber                   =   Number of trials
% evalTimeSec                   =   Evaluation time (Sec)
% choiceTimeSec                 =   Choice time (Sec)
% feedbackTimeSec               =   Feedback time (Sec)
% isiTimeSec                    =   Interstimulus interval time
%
% cardNumber                    =   Number of cards = 2 (Fixed)
%
% posCombBlock                  =   Possible combination of card positions
% 
% randPosVec                    =   Vector of the randomized positions of all target and competitor gambles
% 
% targetRandMagVec              =   Vector of the randomized positions of the target gamble
% competitorRandMagVec          =   Vector of the randomized positions of the competitor gamble
%
% parameterNumber               =   Number of stored parameters = 7 (Fixed)
% responseVec                   =   Responses vector
%
% targetMagVec                  =   Magnitude vector of the target
% competitorMagVec              =   Magnitude vector of the competitor
%
% * From the estimation task
% + Calculated from the estimation task after doing the loggit regression

%% ------------------------------------------------------------------------
%---------------------Hints: defined by the developer :)------------------
%--------------------------------------------------------------------------
%
% 1                             ->  Left position in the screen
% 2                             ->  Middle position in the screen
% 3                             ->  Right position in the screen

%
% 1                             ->  Target gamble
% 2                             ->  Competitor gamble
% 3                             ->  Decoy gamble

%% ------------------------------------------------------------------------
%----------------------------Decoy task------------------------------------
%
% Here the necessary parameters to run the decoy trial are computed,
% together with the necessary parameters to use psychtoolbox
%
%
% The fuction decovalues is needed

%% ------------------------------------------------------------------------
%---------------------Clearing the workspace-------------------------------
%--------------------------------------------------------------------------
clc;
% close all;
% clear all;
sca;
%load('partdata2.mat');
if nargin < 2
    number                  =   input('Participant Number: ','s');
    sessionin               =   input('Session Number: ');
end

nickname = strcat('P',number);
nameResp             =  strcat('./Data/Storage1/EstiValAna',nickname,'_',num2str(sessionin),'.mat');
load(nameResp)

%% ------------------------------------------------------------------------
%---------------------Setting the seed for random generator----------------
%--------------------------------------------------------------------------
% To set the seed for random number generator based on clock
rng('shuffle')

%% ------------------------------------------------------------------------
%---------------------Key Names Unification--------------------------------
%--------------------------------------------------------------------------
% Unifying Key Names - Maybe dows not work on Windows!!
KbName('UnifyKeyNames');

%% ------------------------------------------------------------------------
%------------------ Values of the parameters-------------------------------
%--------------------------------------------------------------------------
targetMag                       =   20;
targetProbability               =   70;
competitorProbability           =   30;
competitorMag                   =   round(YinterceptVal);
%competitorMag                   =  90;


evalTimeSec                     =   6;
choiceTimeSec                   =   1;
feedbackTimeSec                 =   1;
isiTimeSec                      =   1;

trialNumberDec                  =   120; % Number of trial without the context gamble 

trialNumber                     =   trialNumberDec;
trialStack                      =   fGenTrialStackCon(trialNumber);


cardNumber                      =   3;

contextRat                      =   2;


%% ------------------------------------------------------------------------
%------------------------Responses vector----------------------------------
%--------------------------------------------------------------------------
responseVector                      =   zeros(trialNumber,15);
%%      All the possible conbinations of positions: 
posCombBlock                    =   [1 2 3; 1 3 2; 2 1 3; 2 3 1; 3 1 2; 3 2 1];


%% ------------------------------------------------------------------------
%------------------ trialNumber / cardNumber divisibility------------------
%--------------------------------------------------------------------------
% Checking divisibility trialNumber by cardNumber
if rem(trialNumber, 5*cardNumber) ~= 0
    warning('number of trials must be divisible by the number of gambles in the choosing phase');
    return;
end

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
% trainingVal  = [left M, left P, mid M, mid P, right M, right P, choice, dissapear]
trainingVal                     =   [50,10,60,20,40,90,2,3;...
                                     30,20,25,40,20,60,2,1;...
                                     40,80,20,85,5,90,1,2;...
                                     55,10,65,20,45,90,2,3;...
                                     30,25,25,45,20,65,2,1;...
                                     50,80,30,85,15,90,1,2;...
                                     45,10,65,20,35,90,2,3;...
                                     30,15,25,35,20,55,2,1;...
                                     40,75,20,80,5,85,1,2];
                                 
responseVecTrainingValDec       =   zeros(length(trainingVal),9);   




%% ------------------------------------------------------------------------
%-----------------Creating Decoy values------------------------------------
%--------------------------------------------------------------------------
% Every decoy type will apear in a pseudorandom order, moreover 1/3 of the
% times T or C will disapear and 2/3 of the times the decoy.
% Every decoy type should be present douring the same number of times.
% when trialNumber is bigger than 18 this should be made in a for loop
%
% The first column is the magnitude of gambles
% The second column is the probability of gambles
% The third column shows which gamble will be disapear


% Decoy information matrix (type,which element dissapears,decoy distance
% (1-> close, 2-> medium, 3-> far)), possitions of the gambles given by
% posCombBlock vector

%Number of trials necesary so each of the decoys has the same number of
%trials at each distance it will be a number varing from 4-8
restofTrials                    =   trialNumberDec*2/3-floor(trialNumberDec/18)*12;

decoyTypeRandVal                =   Shuffle1([(repmat([1:4],1,trialNumberDec/4))',...
                                            [3 * ones(1,trialNumberDec*2/3+restofTrials), randsample(2,trialNumberDec/3-restofTrials,1)']',...
                                            (repmat([1:3],1,trialNumberDec/3))',...
                                            repmat(repelem(posCombBlock,4,1),trialNumberDec/24,1)],2);

decoyTypeRandCon                 =    Shuffle1([(5*ones(1,trialNumberDec/4))',...
                                             (repmat([1:3],1,trialNumberDec/12))',...
                                             Shuffle1((repmat([1:3],1,trialNumberDec/12)))',...
                                             repmat(posCombBlock,trialNumberDec/(6*4),1)], 2);



decoyTypeRandValCon             =   decoyTypeRandVal; %zeros(trialNumber,6);

                                         
%decoyRandDist                   =   Shuffle1([1:trialNumber]);
% decoyRandPos                    =   reshape(decoyRandPos',trialNumber,1)
% The context effect increased decoy, the target and the competitor are
% going to disapear randomnly therefore (repmat([1:3],1,trialNumber/5)) is
% added to the matrix this time

%% ------------------------------------------------------------------------
%-------------------Randomization of the gambles position------------------
%--------------------------------------------------------------------------
% The magnitude of the target will vary randomly 10% from targetReward in each trial
%targetRandMagVec                =   randi([round(targetMag*0.9),round(targetMag*1.1)],1,trialNumber);
% The magnitude of the competitor gamble will vary randomly 5% from competitorReward in each trial
%competitorRandMagVec            =   randi([round(competitorMag*0.95),round(competitorMag*1.05)],1,trialNumber);

%   Vector with all the magnitudes and probability convinations
%   (Target Probability, Target Magnitude, Competitor Probability, Competitor Magnitude)
magProbAll                      = [targetMag-2 targetProbability-5 competitorMag-2 competitorProbability-5;...
                                   targetMag-2 targetProbability-5 competitorMag-1 competitorProbability-5;...
                                   targetMag-1 targetProbability-5 competitorMag-2 competitorProbability-5;...
                                   targetMag-1 targetProbability-5 competitorMag-1 competitorProbability-5;...
                                   targetMag-1 targetProbability-5 competitorMag-2 competitorProbability;...
                                   targetMag targetProbability-5 competitorMag-2 competitorProbability;...
                                   targetMag targetProbability-5 competitorMag competitorProbability-5;...
                                   targetMag targetProbability-5 competitorMag-1 competitorProbability;...
                                   targetMag+1 targetProbability-5 competitorMag competitorProbability;...
                                   targetMag+1 targetProbability-5 competitorMag-2 competitorProbability+5;...
                                   targetMag+1 targetProbability-5 competitorMag+1 competitorProbability-5;...
                                   targetMag+2 targetProbability-5 competitorMag+1 competitorProbability;...
                                   targetMag+2 targetProbability-5 competitorMag-1 competitorProbability+5;...
                                   targetMag+2 targetProbability-5 competitorMag+2 competitorProbability-5;...
                                   targetMag-2 targetProbability competitorMag-1 competitorProbability-5;...
                                   targetMag-2 targetProbability competitorMag-2 competitorProbability;...
                                   targetMag-2 targetProbability competitorMag competitorProbability-5;...
                                   targetMag-1 targetProbability competitorMag competitorProbability-5;...
                                   targetMag-1 targetProbability competitorMag-1 competitorProbability;...
                                   targetMag-1 targetProbability competitorMag-2 competitorProbability+5;...
                                   targetMag targetProbability competitorMag+1 competitorProbability-5;...
                                   targetMag targetProbability competitorMag competitorProbability;...
                                   targetMag targetProbability competitorMag-1 competitorProbability+5;...
                                   targetMag+1 targetProbability competitorMag+2 competitorProbability-5;...
                                   targetMag+1 targetProbability competitorMag+1 competitorProbability;...
                                   targetMag+1 targetProbability competitorMag competitorProbability+5;...
                                   targetMag+2 targetProbability competitorMag competitorProbability+5;...
                                   targetMag+2 targetProbability competitorMag+2 competitorProbability;...
                                   targetMag+2 targetProbability competitorMag+1 competitorProbability+5;...
                                   targetMag-2 targetProbability+5 competitorMag-1 competitorProbability;...
                                   targetMag-2 targetProbability+5 competitorMag-2 competitorProbability+5;...
                                   targetMag-2 targetProbability+5 competitorMag+1 competitorProbability-5;...
                                   targetMag-1 targetProbability+5 competitorMag competitorProbability;...
                                   targetMag-1 targetProbability+5 competitorMag-1 competitorProbability+5;...
                                   targetMag-1 targetProbability+5 competitorMag+2 competitorProbability-5;...
                                   targetMag targetProbability+5 competitorMag+1 competitorProbability;...
                                   targetMag targetProbability+5 competitorMag competitorProbability+5;...
                                   targetMag targetProbability+5 competitorMag+2 competitorProbability;...
                                   targetMag+1 targetProbability+5 competitorMag+2 competitorProbability;...
                                   targetMag+1 targetProbability+5 competitorMag+1 competitorProbability+5;...
                                   targetMag+1 targetProbability+5 competitorMag+2 competitorProbability+5;...
                                   targetMag+2 targetProbability+5 competitorMag+1 competitorProbability+5;...
                                   targetMag+2 targetProbability+5 competitorMag+2 competitorProbability+5];
numRepetitions                  =  floor(trialNumber/length(magProbAll));
remainders                      =  trialNumber-numRepetitions*length(magProbAll);
if(numRepetitions==0)
    magProbVector               =  [magProbAll(randsample(length(magProbAll),remainders),:)];
else
%   Vector with all the data for the target and competitor
magProbVector                   =   [Shuffle1(repmat( Shuffle1(magProbAll,2),numRepetitions,1),2);...
                                    magProbAll(randsample(length(magProbAll),remainders),:)];
end  
decoyMat                        =   decoyValuesFunValueCon(decoyTypeRandValCon,magProbVector,trialNumber);  
%%
magProbValUse                   =   abs(-1*ones(trialNumber,4)+repmat(decoyTypeRandValCon(:,1)==5,1,4)).*magProbVector; 
magProbDecoy5Val                =   repmat(decoyTypeRandValCon(:,1)==5,1,4).*[Shuffle1([9*ones(trialNumber/3,1)',10*ones(trialNumber/3,1)',11*ones(trialNumber/3,1)']',2),...
                                                                         Shuffle1([85*ones(trialNumber/3,1)',90*ones(trialNumber/3,1)',95*ones(trialNumber/3,1)']',2),...
                                                                         Shuffle1([18*ones(trialNumber/3,1)',20*ones(trialNumber/3,1)',22*ones(trialNumber/3,1)']',2),...
                                                                         Shuffle1([45*ones(trialNumber/3,1)',50*ones(trialNumber/3,1)',55*ones(trialNumber/3,1)']',2)];
magProbVector                   =   magProbValUse+magProbDecoy5Val;
% Decoy random positions
% decoyRandDist                   =   Shuffle1(1:trialNumber);
% decoyRandPos                    =   reshape(decoyRandPos',trialNumber,1)
%% ------------------------------------------------------------------------
%-------------------Generating RandPosVec----------------------------------
%--------------------------------------------------------------------------
randPosVec                      =   decoyTypeRandValCon(:,[4:6]);

%% ------------------------------------------------------------------------
%------------------------Saving Parameters---------------------------------
%--------------------------------------------------------------------------
% to be used in decoytrial
save('./Data/decoyVarsVal.mat','competitorMag','magProbAll','magProbVector',...
    'competitorProbability','decoyMat',...
    'escapeKey', 'leftKey','trialStack','trialNumber','responseVector',...
    'rightKey','choiceTimeSec','evalTimeSec','feedbackTimeSec',...
    'targetMag','targetProbability',...
    'randPosVec','isiTimeSec','decoyTypeRandValCon','nickname','sessionin',...
    'trainingVal','responseVecTrainingValDec');
%,'name','nickname','sessionin'
sca;