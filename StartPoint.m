clc;
clear all;

parttype                    =   '1000';


while str2num(parttype)

prompt                      =   ['\nPlease choose a task: \n',...
                                    '\n',...
                                    '1) Add/Edit Participant Info: \n',...
                                    '2) Run an Estimation Task (Value): \n',...
                                    '3) Run an Task (Value): \n',...
                                    '7) Subject Check: \n',...
                                    '0) Exit!! \n\n>> '];
parttype                    =   input(prompt,'s');

switch str2num(parttype)
    
    case 1
        clc;
        
        participants
        
        disp('###################################');
        disp('Are you going to do something else?!')
    case 2
        clc;
        
        estimationDataGen
        
        number                          =   input('Participant Number: ','s');
        sessionin                       =   input('Session Number: ');
        
        estimationTaskValue(number, sessionin)
        estimationTaskAnaValue(number, sessionin)
        
        
        disp('Estimation Task (Value) is done!')
        
        disp('###################################');
        disp('Are you going to do something else?!')
    case 3
        clc;
        
        number                          =   input('Participant Number: ','s');
        sessionin                       =   input('Session Number: ');
        
        decoyDataGenValue(number, sessionin)
        decoyTaskValue(number, sessionin)
        
        disp('Task (Value) is done!')
        
        disp('###################################');
        disp('Are you going to do something else?!')
    case 7
        clc;
        
        number                          =   input('Participant Number: ','s');
        sessionin                       =   input('Session Number: ');
        
        checkPoint(number, sessionin)
                
        disp('###################################');
        disp('Are you going to do something else?!')
    case 0
        clc;
        disp('Bye! :)')
    otherwise
        clc;
        disp('Please Choose a Correct Number!!!!')
end

% disp(str2num(parttype))

end

% clc;