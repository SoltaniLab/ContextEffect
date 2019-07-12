function decoyMatrix = decoyValuesFunValueCon(decoyTypeRand,magProbVector,trialNumber)
% -------------------------------------------------------------------------




%% ------------------------------------------------------------------------
%---------------- creation of the decoy values:----------------------------
%--------------------------------------------------------------------------
decoyMatrix                 =   nan(trialNumber,2);



for i = 1 : trialNumber 

    %   What decoy type they are dominant 1, dominated 2, 3 more context effect
  
    decoyType                =   (1*(decoyTypeRand(i,1)==1)+2*(decoyTypeRand(i,1)==2)+1*(decoyTypeRand(i,1)==3)+2*(decoyTypeRand(i,1)==4)+3*(decoyTypeRand(i,1)==5));
    decoyDistance            =   (1*(decoyTypeRand(i,3)==1)+3*(decoyTypeRand(i,3)==2)+5*(decoyTypeRand(i,3)==3));
    %   To which gamble will the decoy be affecting to (1 = Target 3=competitor)
    decoyOf                  =   (1*(decoyTypeRand(i,1)==3)+1*(decoyTypeRand(i,1)==4)+1*(decoyTypeRand(i,1)==5)+3*(decoyTypeRand(i,1)==1)+3*(decoyTypeRand(i,1)==2));
    
    %   The magnitude and the probability the decoy will be based on 
    magnitude               =   magProbVector(i,decoyOf);
    probability             =   magProbVector(i,decoyOf+1);
    
    
    % Matrix with all the possible values for the decoy rows (1:4) decoy
    % type (1&3 asymmetrically dominant (1 Comp 3 Target)(+), 
    % 2&4 asymmetrically dominated(2 Comp 4 Target(-))) ,
    % colums odd numbers magnitude even numbers probability 
    % 1&2 close (+/- 5%), 3&4 medium(+/- 10%) and 5&6 far (+/-15%)
    
    decoyValuesAll          =  [magnitude*1.05,probability*1.05,...
                                magnitude*1.15,probability*1.15,...
                                magnitude*1.3,probability*1.3;
                                magnitude*0.95,probability*0.95,...
                                magnitude*0.85,probability*0.85,...
                                magnitude*0.7,probability*0.7;
                                100,10,...
                                105,11,...
                                95,9];
                            
     decoyMatrix(i,:)        =  [decoyValuesAll(decoyType,decoyDistance),...
                                 decoyValuesAll(decoyType,decoyDistance+1)];
        
    
 end 

