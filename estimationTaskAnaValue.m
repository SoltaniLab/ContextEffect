function estimationTaskAnaValue(number, sessionin)

if nargin < 2
    number                  =   input('Participant Number: ','s');
    sessionin               =   input('Session Number: ');
end

nickname                =   strcat('P',number);
nameRespMat             =   strcat('./Data/Storage1/responsesEstVal',nickname,'_',num2str(sessionin),'.mat');
load(nameRespMat)

respTarget                                =  repmat(responseVecVal(:,2)==1,1,7).*responseVecVal;
respTarget(  all(~respTarget,2), : )      =  [];
[respTargetSortVec,I]                     =  sort(respTarget(:,7));
respTargetSorted                          =  respTarget(I,:);


respComp                                 =  repmat(responseVecVal(:,2)==2,1,7).*responseVecVal;
respComp(  all(~respComp,2), : )         =  [];
[respCompSortVec,I]                      =  sort(respComp(:,7));
respCompSorted                           =  respComp(I,:);

%%
% Calculate the probabilities of the chosen target values:

respAll                                = [respTargetSortVec',respCompSortVec'];
uniqueValAll                           = unique(respAll) ;
uniquetValAllLen                       = length(uniqueValAll);
uniqueVallProb                         = nan(uniquetValAllLen,1);

for i=1:uniquetValAllLen
    uniqueVallProb(i)                      = 100*length(find(respCompSortVec==uniqueValAll(i)))/...
        length(find(respAll==uniqueValAll(i)));
end

%%
% fitting choice probability as a funciton of the value of the target gamble with a sigmoid function
xdata                                  = uniqueValAll ;
ydata                                  = uniqueVallProb';

options                                = optimset('MaxIter',1000000,'TolFun',1e-16,'Display','on');

x0                                     = [100*rand(1),.1*rand(1)];
lb                                     = [-100,-0];
ub                                     = [100, 100];
[Xfit, resnorm]                        = lsqcurvefit(@Ffitsig, x0,xdata,ydata,lb,ub,options);

Yfit                                   = 100./(1 +exp( -(xdata -Xfit(1)).*Xfit(2) ) );

%% Plot the data
times                                  = linspace(xdata(1),xdata(end));
Ysigmoid                               = Ffitsig(Xfit,times);
plot(xdata,ydata,'ko',times,Ysigmoid,'b-');

YinterceptVal                             = Xfit(1);




%% Save the data analysis
nameResp             =  strcat('./Data/Storage1/EstiValAna',nickname,'_',num2str(sessionin),'.mat');
save(nameResp);