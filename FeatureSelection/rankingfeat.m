%% Feature Ranking
%--------------------------------------------------------------------------
%  
% [in]: TrainMat - a NxM matrix that contains the full list of features
%       of training data. N is the number of training samples and M is the
%       dimension of the feature. So each row of this matrix is the features
%       of a single observation.
%
% [in]: LabelTrain - a Nx1 vector of the class labels of training data
%
% [out]: topfeatures - a Kx2 matrix that contains the information of the
%        top 1% features of the highest variance ratio. K is the number of
%        selected feature (K = ceil(M*0.01)). The first column of this matrix
%        is the index of the selected features in the original feature list. 
%        So the range of topfeatures(:,1) is between 1 and M. The second 
%        column of this matrix is the variance ratio of the selected features.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function topfeatures = rankingfeat(TrainMat, LabelTrain, string)

    [~, M] = size(TrainMat);
    
    % Get the variance ratio scores
    varianceRatioScores = zeros(M, 2);
    for m = 1:M
        [varianceRatioScores(m, 1), varianceRatioScores(m, 2)] = ...
            getVarianceRatios(TrainMat(:, m), LabelTrain);
    end
    
    % Check for VR or AVR and rank the features based on their scores
    if strcmp(string, 'VR')
    [topFeatures(:, 2),  topFeatures(:, 1)]  = ...
        sort(varianceRatioScores(:, 1), 'descend');
    elseif strcmp(string, 'AVR')
    [topFeatures(:, 2),  topFeatures(:, 1)] = ...
        sort(varianceRatioScores(:, 2), 'descend');
    end
    
    % Select the top 1% features
    K = ceil(M*0.01);
    topfeatures = topFeatures(1:K, :);
end
