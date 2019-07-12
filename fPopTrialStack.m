function [trial, trialStack] = fPopTrialStack( trialStack )
%% ------------------------------------------------------------------------
%------------------Pop out from trialStack---------------------------------
%--------------------------------------------------------------------------
% If there is an item in stack
if size(trialStack,2)
    % Poping out
    trial                               =   trialStack(size(trialStack,2));
    % Removing the poped item
    trialStack(size(trialStack,2))      =   [];
else
    trial                               =   0;
end

