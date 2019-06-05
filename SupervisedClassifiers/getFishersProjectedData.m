%% Fisher Projected Data
%--------------------------------------------------------------------------
%  
%  Find the projection of the feature vector on the Fisher's Hyperplane.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function yw = getFishersProjectedData(W, featureVector)
    yw = featureVector*W;
end
%% END