%% Check for increase in accuracy
%--------------------------------------------------------------------------
%  
% If accuracy doesn't increase for more than 10 iterations 
% isAccuracyIncreasing is set to false 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [isAccuracyIncreasing] = checkAccuracyForIncrease(accuracy)

    N = length(accuracy); cnt = 0;
    for p = 1:N
        if accuracy(N) <= accuracy(p)
            cnt = cnt + 1;
        else
            cnt = 0;
        end
    end
    
    if cnt > 10 
        isAccuracyIncreasing = false;
    else
        isAccuracyIncreasing = true;
    end
end
%% END