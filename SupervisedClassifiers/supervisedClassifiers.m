%% Supervised Classifiers
%--------------------------------------------------------------------------
%  
% Supervised classifiers are built to address multi-class problems. 
% Classifiers are built using linear models. The project also explores one 
% of the dimensionality reduction techniques called Fisher’s projection, 
% widely known as the Linear Discriminant Analysis (LDA).
%
%
% supervisedClassifiers.m implements a User Input section that allows the 
% user to choose the classifier and LDA analysis using Macros and the 
% experiment will run accordingly.
%
% 
%             Given below is the User-Input section
%   |------------------------------------------------------|
%   | %% User Inputs                                       |
%   |                                                      |
%   | FISHERS_PROJECTION = 1;                              |
%   |                                                      |
%   | K_CLASS_DISCRIMINANT = 1;                            |
%   | KNN_CLASSIFIER       = 1;                            |
%   | k_nn = 5; % select a value of K for KNN classifier   |
%   |                                                      |
%   | I_WANT_ALL_FEATURES = 1;                             |
%   |------------------------------------------------------|
% 
%
% If LDA is required, uncomment "FISHERS_PROJECTION = 1;"
% By default least squares K-class discriminant classifier is used. If you
% were to choose KNN, comment "K_CLASS_DISCRIMINANT = 1;" and uncomment 
% "KNN_CLASSIFIER = 1;". Also ensure to uncomment "k_nn = 5;" which 
% decides the number of nearest-neighbours.
% 
% Since visualisation requires fewer features, by default a 
% train_featureVector will only contain 2 features. If you were to consider
% all the features, uncomment "I_WANT_ALL_FEATURES = 1;"
%
% Note : Enabling LDA will automatically consider all features into 
% train_featureVector.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================================================================

clear; close all; clc;

%% ========================================================================

dataset = 'wine';
[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(dataset);
numGroups = length(countcats(test_labels));

myTrain_labels = double(train_labels);
myTest_labels  = double(test_labels);

%% Macros
I_WANT_ALL_FEATURES  = 0;
K_CLASS_DISCRIMINANT = 0;
FISHERS_PROJECTION   = 0;
KNN_CLASSIFIER       = 0;

%% =========================== User Inputs ================================

% UnComment the below line for Fisher's projection
FISHERS_PROJECTION = 1;

% Uncomment required classifier
K_CLASS_DISCRIMINANT = 1;
% KNN_CLASSIFIER       = 1;
% k_nn = 5; % select a value of K for KNN classifier

% I_WANT_ALL_FEATURES = 1;

%% ========================================================================

if FISHERS_PROJECTION == 1
    K_CLASS_DISCRIMINANT = 1;
    I_WANT_ALL_FEATURES  = 1;
end

if ~I_WANT_ALL_FEATURES
    f1 = 1;
    f2 = 7;
    features = [f1, f2];
    train_featureVector = train_featureVector(:, features);
    test_featureVector  = test_featureVector(:, features);
end

%% ================= Classify the data and show statistics ================
% Train the model 

%% ================== Fisher projection of training data ==================
if FISHERS_PROJECTION
    fisherProjectionHyperplane = fishersProjection(train_featureVector, ...
                                 myTrain_labels, numGroups);
    fishersProjectedData       = getFishersProjectedData(fisherProjectionHyperplane, ....
                                 train_featureVector);
    train_featureVector        = fishersProjectedData;
end

%% ================== Call k-class discriminant classifier ================
if K_CLASS_DISCRIMINANT

    W = kClassDiscriminant(train_featureVector, myTrain_labels);
 
    %Training for k-class discriminant classifier
    % Find the training accurracy 
    train_pred = myPredict(W, train_featureVector);
    % Create confusion matrix
    train_ConfMat = confusionmat(myTrain_labels, train_pred)
    figure(1)
    plotConfusionMatrix(myTrain_labels, train_pred, strcat(dataset, ' Training'));
    % Create classification matrix (rows should sum to 1)
    [a, ~] = hist(myTrain_labels, unique(myTrain_labels));
    train_ClassMat = train_ConfMat./(meshgrid(a)')
    % mean group accuracy and std
    train_acc = mean(diag(train_ClassMat))
    train_std = std(diag(train_ClassMat))
end

%% =================== Fisher projection of testing data ==================
if FISHERS_PROJECTION
    fishersProjectedData = getFishersProjectedData(fisherProjectionHyperplane, ...
                           test_featureVector);
    test_featureVector   = fishersProjectedData;
end

%% ============== Testing for k-class discreminant classifier =============
if K_CLASS_DISCRIMINANT
    % Find the testing accurracy
    test_pred = myPredict(W, test_featureVector);
end

%% ====================== Call for KNN classifier =========================
if KNN_CLASSIFIER
    test_pred = KNN_Classifier(k_nn, train_featureVector, train_labels, ...
                               test_featureVector);
end

%% ======================== Testing continued =============================
% Create confusion matrix
test_ConfMat = confusionmat(myTest_labels, test_pred)
figure(2)
plotConfusionMatrix(myTest_labels, test_pred, strcat(dataset, ' Testing'))
% Create classification matrix (rows should sum to 1)
[a, ~] = hist(myTest_labels, unique(myTest_labels));
test_ClassMat = test_ConfMat./(meshgrid(a)')
% mean group accuracy and std
test_acc = mean(diag(test_ClassMat))
test_std = std(diag(test_ClassMat)) 

%% ========================================================================
if K_CLASS_DISCRIMINANT
%%  Display the linear discriminants and a set of features in two of the feature dimensions
    figure(3)
    visualizeBoundaries(W, test_featureVector, test_labels, 1, 2)
    title('{\bf Linear Discriminant Classification}')
    hold off; grid on
    
%%  Display the classified regions of two of the feature dimensions  
    figure(4)
    h = visualizeBoundariesFill(W, test_featureVector, test_labels, 1, 2);
    title('{\bf Classification Area}')

end
%% ============================= End ======================================