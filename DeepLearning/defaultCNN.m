%--------------------------------------------------------------------------
%% Deep Learning Basics : A simple convolutional neural net
%--------------------------------------------------------------------------
%
% In this script we are going to build a simple single layer convolutional
% neural net to try and understand the importance of varying learning rate
%
% Dataset for this project is not provided.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================================================================

clear; close all; clc;

%% ========================================================================

dataDir= './data/wallpapers/';
checkpointDir = 'modelCheckpoints';

rng(1) % For reproducibility
Symmetry_Groups = {'P1', 'P2', 'PM' ,'PG', 'CM', 'PMM', 'PMG', 'PGG', 'CMM',...
    'P4', 'P4M', 'P4G', 'P3', 'P3M1', 'P31M', 'P6', 'P6M'};

train_folder = 'train_aug';
test_folder  = 'test_aug';

% Create training data and labels
fprintf('Loading Train Filenames and Label Data...'); t = tic;
train_all = imageDatastore(fullfile(dataDir,train_folder), ...
                   'IncludeSubfolders',true,'LabelSource', ...
                   'foldernames');
train_all.Labels = reordercats(train_all.Labels,Symmetry_Groups);

% Split with validation set
[train, val] = splitEachLabel(train_all,.9);
fprintf('Done in %.02f seconds\n', toc(t));

% Create testing data and labels
fprintf('Loading Test Filenames and Label Data...'); t = tic;
test = imageDatastore(fullfile(dataDir,test_folder), ...
             'IncludeSubfolders',true,'LabelSource', ...
             'foldernames');
test.Labels = reordercats(test.Labels,Symmetry_Groups);
fprintf('Done in %.02f seconds\n', toc(t));

%%
rng('default');
numEpochs = 20; 
batchSize = 400;
nTraining = length(train.Labels);

% Build a simple CNN
layers = [
    imageInputLayer([128 128 1]);                                         % Input to the network is a 256x256x1 sized image 
    
    convolution2dLayer(5,20,'Padding',[2 2],'Stride', [2,2]);             % convolution layer with 20, 5x5 filters
    reluLayer();                                                          % ReLU layer
    maxPooling2dLayer(2,'Stride',2);                                      % Max pooling layer
    
    fullyConnectedLayer(25);                                              % Fullly connected layer with 50 activations
    dropoutLayer(.25);                                                    % Dropout layer
    fullyConnectedLayer(17);                                              % Fully connected with 17 layers
    softmaxLayer();                                                       % Softmax normalization layer
    classificationLayer();                                                % Classification layer
    ];

if ~exist(checkpointDir,'dir'); mkdir(checkpointDir); end

% Set the training options
options = trainingOptions('sgdm',      ...
    'MaxEpochs',        20,            ... 
    'InitialLearnRate', 5e-4,          ...                                
    'CheckpointPath',   checkpointDir, ...
    'MiniBatchSize',    batchSize,     ...
    'MaxEpochs',        numEpochs);
    % uncommand and add the line below to the options above if you have 
    % version 17a or above to see the learning in realtime
    %'OutputFcn',@plotTrainingAccuracy,... 

% Train the network, info contains information about the training accuracy
% and loss
 t = tic;
[net1,info1] = trainNetwork(train,layers,options);
fprintf('Trained in in %.02f seconds\n', toc(t));

% Test on the validation data
YTrainPred1        = classify(net1, train);
train_acc1         = mean(YTrainPred1 == train.Labels);
[trainOutputs1, ~] = grp2idx(YTrainPred1);
[trainTargets1, ~] = grp2idx(train.Labels);

figure(1)
plotConfusionMatrix(trainTargets1, trainOutputs1, 'Training');
savefig('TrainingConfusionMatrix_defaultNet1.fig')

YValPred1        = classify(net1, val);
val_acc1         = mean(YValPred1 == val.Labels);
[valOutputs1, ~] = grp2idx(YValPred1);
[valTargets1, ~] = grp2idx(val.Labels);

figure(2)
plotConfusionMatrix(valTargets1, valOutputs1, 'Validation');
savefig('validationConfusionMatrix_defaultNet1.fig')

% It seems like it isn't converging after looking at the graph but lets
%   try dropping the learning rate to show you how.  

options = trainingOptions('sgdm',      ...
    'MaxEpochs',        20,            ...
    'InitialLearnRate', 1e-4,          ...                              
    'CheckpointPath',   checkpointDir, ...
    'MiniBatchSize',    batchSize,     ...
    'MaxEpochs',        numEpochs);
    % uncommand and add the line below to the options above if you have 
    % version 17a or above to see the learning in realtime
    % 'OutputFcn',@plotTrainingAccuracy,...

t = tic;
[net2,info2] = trainNetwork(train,net1.Layers,options);
fprintf('Trained in in %.02f seconds\n', toc(t));

% Test on the validation data
YTrainPred2        = classify(net2, train);
train_acc2         = mean(YTrainPred2 == train.Labels);
[trainOutputs2, ~] = grp2idx(YTrainPred2);
[trainTargets2, ~] = grp2idx(train.Labels);

figure(3)
plotConfusionMatrix(trainTargets2, trainOutputs2, 'Training');
savefig('TrainingConfusionMatrix_defaultNet2.fig')

YValPred2        = classify(net2, val);
val_acc2         = mean(YValPred2 == val.Labels);
[valOutputs2, ~] = grp2idx(YValPred2);
[valTargets2, ~] = grp2idx(val.Labels);

figure(4)
plotConfusionMatrix(valTargets2, valOutputs2, 'Validation');
savefig('validationConfusionMatrix_defaultNet2.fig')


% Test on the Testing data
YTestPred        = classify(net2, test);
test_acc         = mean(YTestPred == test.Labels);
[testOutputs, ~] = grp2idx(YTestPred);
[testTargets, ~] = grp2idx(test.Labels);

figure(5)
plotConfusionMatrix(testTargets, testOutputs, 'Test');
savefig('testConfusionMatrix_defaultNet.fig')

figure(6)
plotTrainingAccuracy_All(info1,numEpochs);
savefig('higherLearningRate.fig')

figure(7)
plotTrainingAccuracy_All(info2,numEpochs);
savefig('lesserLearningRate.fig')

save('default.mat');
% =========================================================================
%% END