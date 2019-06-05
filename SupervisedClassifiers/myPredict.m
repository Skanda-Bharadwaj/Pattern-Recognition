%% Prediction
%--------------------------------------------------------------------------
%  
% Calculate the class by taking the maximum of projections.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function pred = myPredict(W, X)
    %Append a dummy feature
    X = [ones(size(X, 1), 1), X];
    
    %Calculate the projection
    y = X*W;
    
    %Find the calss (maximum projection)
    [~, pred] = max(y, [], 2);
    
end
%% END