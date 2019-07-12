function checkPoint(number, sessionin)

clc;
if nargin < 2
    number                  =   input('Participant Number: ','s');
    sessionin               =   input('Session Number: ');
end

trialLimit = 180;

flag = false;

nameResp                =   strcat('./Data/Storage1/snapshotStoragDecoyValConP',num2str(number),'_',num2str(sessionin),'.mat');
if exist(nameResp,'file')
    load(nameResp);
    snaptrialNumber     =   length(snapshotStorag);
    if snaptrialNumber > trialLimit
        flag = true;
    end
end

nameResp                =   strcat('./Data/Storage1/snapshotStoragDecoyVisP',num2str(number),'_',num2str(sessionin),'.mat');
if exist(nameResp,'file')
    load(nameResp);
    snaptrialNumber     =   length(snapshotStorag);
    if snaptrialNumber > trialLimit
        flag = true;
    end
end

if flag
    disp('Subject is Rejected!! :(')
else
    disp('Subject is Accepted!! :)')
end

% 
% for number=1:40
% nameResp                =   strcat('./Data/Storage1/snapshotStoragDecoyVisP',num2str(number),'_',num2str(sessionin),'.mat');
% if exist(nameResp,'file')
%     load(nameResp);
%     snaptrialNumber     =   length(snapshotStorag)
%     if snaptrialNumber > trialLimit
%         flag = true
%     end
% end
% end