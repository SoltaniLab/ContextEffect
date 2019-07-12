%--------------------- Participant data------------------------------------
%--------------------------------------------------------------------------
% Storages the data of the participant, name (checks if there is an already
% existing participant with that name and if there is a number is added),
% pnumber (number of participant) task type (1 estimation task 2 decoy
% task) session number and the results.
%
% Here only the name and the task type are introduced, the results should
% be taken from 'strucpartresp.mat' in order to be storaged.

function participants()

clc;
% clear;

%the first time is running only:
participant                 =   struct('name',{},'pnumber',{},'order',{});


%After the first time the next one should be executed:
if exist('./Data/strucpartname.mat','file')
    load('./Data/strucpartname.mat')
end



parttype                    =   '1000';


while str2num(parttype)
    
    prompt                      =   ['\nPlease choose a task: \n',...
        '\n',...
        '1) Add Participant Info: \n',...
        '2) Search/Edit Participant Info: \n',...
        '3) Remove Participant Info: \n',...
        '4) Search (by Name) Participant Info: \n',...
        '0) Save & Exit!! \n\n>> '];
    parttype                    =   input(prompt,'s');
    
    
    switch str2num(parttype)
        
        case 1
            clc;
            %% New Participant            
            
            prompt                  =   ['Please enter the Name, Last Name and Initials of the participant (E.g: Mike Thomson, MT): \n',...
                '>> '];
            
            %check for name repetitions:
            name                    =   input(prompt,'s');
            allnames                =   {participant.name};
            repeated                =   find(strcmp(allnames, name));
            
            %it is not repeated 0
            if (isempty(repeated)==1)
                participant(end+1).name             =   name;
                
                numofpart                           =   length({participant.name});
                
                pnumber                             =   numofpart;
                participant(numofpart).pnumber      =   pnumber;
                
                sessionin                           =   1;
                
                participant(numofpart).session      =   sessionin;
                
                
                disp(['Participants data had been stored:']);
                disp(['Name: ', name]);
                disp(['P-Number: ', num2str(pnumber)]);
                disp(['P-Session: ', num2str(sessionin)]);
                
                
                % The name is repeated 1
            elseif(isempty(repeated)==0)
                
                
                disp(strcat('There are participants with the provided name:'));
                
                contain                             =   strfind(allnames,name);
                %how many time is it repeated
                indxes                              =   nonzeros([1:length(contain)].*(~cellfun('isempty',contain)));
                
                for ii      =   indxes'
                    disp(['Name: ', participant(ii).name]);
                    disp(['P-Number: ', num2str(participant(ii).pnumber)]);
                    disp(['P-Session: ', num2str(participant(ii).session)]);
                    disp('');
                end
            end
            
            disp(' ');
            disp('###################################');
            disp('Are you going to do something else?!');
        case 2
            %% Edit Participant
            clc;
            prompt                                  =   ['Please enter the participant number (E.g: 6): \n',...
                '>> '];
            pnumber                                 =   str2num(input(prompt,'s'));
            allnumbers                              =   cell2mat({participant.pnumber});
            indxes                                  =   nonzeros([1:length(allnumbers)].*(allnumbers==pnumber));
            
            % the participant is new
            if(isempty(indxes) == 1)
                warning('There is no participant with that number')
            else
                
                
                disp(strcat('There are participants with the provided number:'))
                
                for ii          =   indxes'
                    
                    disp(['Name: ', participant(ii).name]);
                    disp(['P-Number: ', num2str(participant(ii).pnumber)]);
                    disp(['P-Session: ', num2str(participant(ii).session)]);
                    disp('');
                end
                
                
                prompt          =   ['Please enter the participant session (E.g: 2): \n',...
                    'Leave it blank if you do not want to edit anything! \n',...
                    '>> '];
                sessionNumber            =   str2num(input(prompt,'s'));
                
                if sessionNumber
                    participant(ii).session = sessionNumber;
                    disp('Changes done!');
                    for ii          =   indxes'
                        
                        disp(['Name: ', participant(ii).name]);
                        disp(['P-Number: ', num2str(participant(ii).pnumber)]);
                        disp(['P-Session: ', num2str(participant(ii).session)]);
                        disp('');
                    end
                end
            end
            
            disp(' ');
            disp('###################################');
            disp('Are you going to do something else?!')
        case 3
            %% Remove Participant
            clc;
            prompt                                  =   ['Please enter the participant number (E.g: 6): \n',...
                '>> '];
            pnumber                                 =   str2num(input(prompt,'s'));
            allnumbers                              =   cell2mat({participant.pnumber});
            indxes                                  =   nonzeros([1:length(allnumbers)].*(allnumbers==pnumber));                        
            
            % the participant is new
            if(isempty(indxes) == 1)
                warning('There is no participant with that number')
            else
                disp(strcat('There are participants with the provided number:'))
                
                for ii          =   indxes'
                    
                    disp(['Name: ', participant(ii).name]);
                    disp(['P-Number: ', num2str(participant(ii).pnumber)]);
                    disp(['P-Session: ', num2str(participant(ii).session)]);
                    disp('');
                end
                
                
                prompt              =   ['Are you sure to remove this participant? (y/n): '];
                ansYN               =   input(prompt,'s');
                
                if ansYN == 'y'
                    
                    participant(ii) = [];
                    disp('Changes done!');
                end
            end
            
            
            disp(' ');
            disp('###################################');
            disp('Are you going to do something else?!')
        case 4
            %% Serach By Name
            clc;
            prompt                                  =   ['Please enter the participant Name (E.g: Sam): \n',...
                '>> '];
            
            name                                    =   input(prompt,'s');
            allnames                                =   {participant.name};                       
            contain                                 =   strfind(allnames,name);                
            indxes                                  =   nonzeros([1:length(contain)].*(~cellfun('isempty',contain)));                               
            
            % the participant is new
            if(isempty(indxes) == 1)
                warning('There is no participant with that Name')
            else
                disp(strcat('There are participants with the provided Name:'))                
                
                for ii          =   indxes'
                    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
                    
                    disp(['Name: ', participant(ii).name]);
                    disp(['P-Number: ', num2str(participant(ii).pnumber)]);
                    disp(['P-Session: ', num2str(participant(ii).session)]);
                    disp('');
                end                                                
            end
            
            
            disp(' ');
            disp('###################################');
            disp('Are you going to do something else?!')
        case 0
            clc;
            disp('Bye! :)')
        otherwise
            clc;
            disp('Please Choose a Correct Number!!!!')
    end
    
    
end

% it will be saved to be used in the decoytrial and estimation trial
% save('strucpartname.mat','participant','name','nickname','sessionin','order');
save('./Data/strucpartname.mat','participant');
% save('partdata.mat','name','nickname','sessionin');