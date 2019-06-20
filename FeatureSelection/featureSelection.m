%% Feature Selection
%--------------------------------------------------------------------------
%
% Feature selection is the process of selecting a subset of relevant features 
% for use in model construction. This script addressess two major feature 
% selection methods − Filter and Wrapper. While the filter method ranks the 
% features based on some discriminative power, wrappers use a search algorithm 
% to search through the space of possible features and evaluate each subset 
% by running a model on the subset.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================================================================

clear; close all; clc;

%% ========================================================================

%load the data
load 'data/data.mat';

Dim = size(FeatureMat,2)-1; %dimension of the feature
countfeat(Dim,2) = 0;

%--------------------------------------------------------------------------
% countfeat is a Mx2 matrix that keeps track of how many times a feature has 
% been selected, where M is the dimension of the original feature space.
% The first column of this matrix records how many times a feature has ranked 
% within top 1% during 100 times of feature ranking. The second column of 
% this matrix records how many times a feature was selected by forward feature 
% selection during 100 times.
%--------------------------------------------------------------------------

%%
numOfEpochs = 1;
accuracy = zeros(numOfEpochs, 1);
for epoch=1:numOfEpochs
    fprintf('\nEpoch # = %d\n', epoch);
    % randomly divide into equal test and traing sets
    [TrainMat, LabelTrain, TestMat, LabelTest]= datasplit(FeatureMat(:, 2:end), FeatureMat(:, 1), 70);
    
    % start feature ranking
    topfeatures = rankingfeat(TrainMat, LabelTrain, 'AVR'); 
    countfeat(topfeatures(:, 1), 1) =  countfeat(topfeatures(:, 1), 1) +1;
    
    % visualize the variance ratio of the top 1% features
    if epoch==1
        %colorbar indicates the correspondance between the variance ratio of the selected feature
       plotFeat(topfeatures);
    end

    % start forward feature selection
    forwardselected = forwardselection(TrainMat, LabelTrain, topfeatures);
    countfeat(forwardselected,2) =  countfeat(forwardselected,2) +1;    
    
    % start classification
    lda = fitcdiscr(TrainMat(:, forwardselected), LabelTrain);
    accuracy(epoch, 1) = 100*mean(LabelTest==predict(lda, TestMat(:, forwardselected)));
    
    if accuracy(epoch, 1) >= 50
        x = 1;
    end
end
mean(accuracy)


%% visualize the features that have ranked within top 1% most during 100 times of feature ranking
data(:,1)=(1:Dim)';
data(:,2) = countfeat(:,1);

% colorbar indicates the number of times a feature at that location was ranked within top 1%
plotFeat(data);

%% visualize the features that have been selected most during 100 times of forward selection
data(:,2) = countfeat(:,2);
plotFeat(data);

%% End
