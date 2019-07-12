clear all
% close all
load('iVisiValiValCon.mat')
sessionin = 1;

DecoySusceptibilityDistance  = [];
decoyConsistencyCollapsed    = [];
decoySusceptibilityCollapsed = [];
noiseCollapsed               = [];

%% Value HR
for iNoNorm=1:length(iValCon)
    nameResp                =   strcat('../Data/Storage1/responsesDecoyValConP',num2str(iValCon(iNoNorm)),'_',num2str(sessionin),'.mat');
    load(nameResp);
    trialNumber     =   length(responseVec);
    %responseVec
    
    
    %% Storage the answers of decoys 1 2 3 4
    
    decoyCon                        =   repmat(responseVec(:,13)~=5,1,15).*responseVec;
    % trials where the decoy stays = 0
    spacedTrials                    =   0;
    for q = 1:trialNumber
        
        if decoyCon(q,13)==0
            spacedTrials             =   0;
        else
            spacedTrials            =   spacedTrials+1;
        end
        decoyCon(q,16)              =   spacedTrials;
    end
    decoyCon( all(~decoyCon,2), : ) =   [];
    MaxDistance                     =   max(decoyCon(:,16));
%       storage the responses where the decoy DISAPEARS
    decoyDis                         =   repmat(decoyCon(:,14)==3,1,16).*decoyCon;
    
    
    %--------------------------------------------------------------------------
    
    %           For now on decoyDis is going to be used
    
    %--------------------------------------------------------------------------
    
    %%
    %   storage the responses of each of the DECOY separatelly
    
    decoy1                            =  repmat(decoyDis(:,13)==1,1,16).*decoyDis;
    decoy1(  all(~decoy1,2), : )      =  [];
    
    decoy2                            =  repmat(decoyDis(:,13)==2,1,16).*decoyDis;
    decoy2(  all(~decoy2,2), : )      =  [];
    
    decoy3                            =  repmat(decoyDis(:,13)==3,1,16).*decoyDis;
    decoy3(  all(~decoy3,2), : )      =  [];
    
    decoy4                            =  repmat(decoyDis(:,13)==4,1,16).*decoyDis;
    decoy4(  all(~decoy4,2), : )      =  [];
    
    %%
    %   storage the responses according to the RESPONSE
    
    respTarget                                =  repmat(decoyDis(:,2)==1,1,16).*decoyDis;
    respTarget(  all(~respTarget,2), : )      =  [];
    
    respComp                                  =  repmat(decoyDis(:,2)==2,1,16).*decoyDis;
    respComp(  all(~respComp,2), : )          =  [];
    
    respDecoy                                 =  repmat(decoyDis(:,2)==3,1,16).*decoyDis;
    respDecoy(  all(~respDecoy,2), : )        =  [];
    %%
    %   storage the response according to the decoy TYPE and RESPONSE
    
    decoy1Target                                  =    repmat(decoy1(:,2)==1,1,16).*decoy1;
    decoy1Target(  all(~decoy1Target,2), : )      =  [];
    
    decoy1Comp                                    =    repmat(decoy1(:,2)==2,1,16).*decoy1;
    decoy1Comp(  all(~decoy1Comp,2), : )          =  [];
    
    
    decoy2Target                                  =    repmat(decoy2(:,2)==1,1,16).*decoy2;
    decoy2Target(  all(~decoy2Target,2), : )      =  [];
    
    decoy2Comp                                    =    repmat(decoy2(:,2)==2,1,16).*decoy2;
    decoy2Comp(  all(~decoy2Comp,2), : )          =  [];
    
    
    decoy3Target                                  =    repmat(decoy3(:,2)==1,1,16).*decoy3;
    decoy3Target(  all(~decoy3Target,2), : )      =  [];
    
    decoy3Comp                                    =    repmat(decoy3(:,2)==2,1,16).*decoy3;
    decoy3Comp(  all(~decoy3Comp,2), : )          =  [];
    
    
    decoy4Target                                  =    repmat(decoy4(:,2)==1,1,16).*decoy4;
    decoy4Target(  all(~decoy4Target,2), : )      =  [];
    
    decoy4Comp                                    =    repmat(decoy4(:,2)==2,1,16).*decoy4;
    decoy4Comp(  all(~decoy4Comp,2), : )          =  [];
                  
    
    DecoyEffect(1) = size(decoy1Target,1)/size(decoy1,1);
    DecoyEffect(2) = size(decoy2Target,1)/size(decoy2,1);
    DecoyEffect(3) = size(decoy3Target,1)/size(decoy3,1);
    DecoyEffect(4) = size(decoy4Target,1)/size(decoy4,1);
    
    DecoyEffectTot(iNoNorm,:) = DecoyEffect;
end

clc

