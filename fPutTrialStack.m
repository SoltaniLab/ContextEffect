function [ trialStack ] = fPutTrialStack( item, trialStack )
%% ------------------------------------------------------------------------
%------------------Putting an item into trialStack-------------------------
%--------------------------------------------------------------------------
% Putting the item
trialStack(size(trialStack,2)+1)                =   item;
% Shuffling the stack
% trialStack                                      =   Shufrfle(trialStack);
end


