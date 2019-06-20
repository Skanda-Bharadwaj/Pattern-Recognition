%% Forward Selection
%--------------------------------------------------------------------------
%  
% [in]: TrainMat - a NxM matrix that contains the full list of features
%       of training data. N is the number of training samples and M is the
%       dimension of the feature. So each row of this matrix is the features 
%       of a single observation.
%
% [in]: LabelTrain  - a Nx1 vector of the class labels of training data
%
% [in]: topfeatures - a Kx2 matrix that contains the information of the top 
%       1% features of the highest variance ratio. K is the number of selected 
%       feature (K = ceil(M*0.01)). The first column of this matrix is the 
%       index of the selected features in the original feature list. So the 
%       range of topfeatures(:,1) is between 1 and M. The second column of 
%       this matrix is the variance ratio of the selected features.
%
% [out]: forwardselected - a Px1 vector that contains the index of the 
%        selected features in the original feature list, where P is the 
%        number of selected features. The range of forwardselected is 
%        between 1 and M. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function forwardselected = forwardselection(TrainMat, LabelTrain, topfeatures)

    N = size(topfeatures, 1);
    
    % Split data into training and cross validation sets 
    [trainMat,    ...
     trainLabels, ...
     crossValMat, ...
     crossValLabels] = datasplit(TrainMat, LabelTrain, 70);

    % Create an empty matrix of forward selected features
    forwardselected = [];
    for i = 1:N
        accuracy=[]; 
        for j = 1:N
            if (~ismember(topfeatures(j, 1), forwardselected))
                % append the feature subset with new features
                if isempty(forwardselected)
                    appendedFeatureList = topfeatures(j, 1);
                else
                    appendedFeatureList = [forwardselected(:, 1); ...
                                           topfeatures(j, 1)];
                end
                % Classify and obtain the accuracy of the current feature 
                % subset
                selectedTrainingFeatures = trainMat(:, appendedFeatureList);
                selectedCrossValidation  = crossValMat(:, appendedFeatureList);
                lda = fitcdiscr(selectedTrainingFeatures, trainLabels);
                accuracy(j) = 100*mean(crossValLabels==predict(lda, selectedCrossValidation));
            else
                fprintf(['Redundancy averted @ j=%d : %d already a ', ...
                         'member of forwardselected\n'], j, topfeatures(j, 1));
            end
        end
        fprintf('\nTraining Matrix size = (%d, %d)\n', size(selectedTrainingFeatures));
        
        % select the best feature subset
        [value, rank] = max(accuracy);
        
        % append the best feature to the existing subset
        featureToBeAdded = topfeatures(rank, 1);
        if(~ismember(featureToBeAdded, forwardselected))
            forwardselected = [forwardselected; topfeatures(rank, 1)];
        end
        subsetAccuracy(i) = value;
        
        % Check if the accuracy is increasing
        isAccuracyIncreasing = checkAccuracyForIncrease(subsetAccuracy);
        
        % Terminate the algorithm if the accuracies are not increasing
        if(~isAccuracyIncreasing)
            fprintf('\nAccuracy is not increasing after %d iterations!!\n', i);
            break;
        end
    end
end