%% RCNN_SymmetricGroups : Transfer Learning Using AlexNet
%--------------------------------------------------------------------------
%
% The region proposals are trained using pre-trained Alexnet. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Using AlexNet to train the network
net = alexnet;
%load('./modelCheckpoints/convnet_checkpoint__6750__2019_04_22__22_42_24.mat');

dataDir= '../wallpaper_dataset/';
checkpointDir = 'modelCheckpoints';

rng(1) % For reproducibility
Symmetry_Groups = {'P1', 'P2', 'PM' ,'PG', 'CM', 'PMM', 'PMG', 'PGG', 'CMM',...
                   'P4', 'P4M', 'P4G', 'P3', 'P3M1', 'P31M'};

train_folder = 'RP';
test_folder  = 'test';

fprintf('Loading Train Filenames and Label Data...'); t = tic;
train_all = imageDatastore(fullfile(dataDir,train_folder),          ...
                           'IncludeSubfolders',true,'LabelSource',  ...
                           'foldernames');
train_all.Labels = reordercats(train_all.Labels,Symmetry_Groups);

%Split with validation set
[train, val] = splitEachLabel(train_all,.9);
fprintf('Done in %.02f seconds\n', toc(t));

fprintf('Loading Test Filenames and Label Data...'); t = tic;
test = imageDatastore(fullfile(dataDir,test_folder),          ...
                      'IncludeSubfolders',true,'LabelSource', ...
                      'foldernames');
test.Labels = reordercats(test.Labels,Symmetry_Groups);
fprintf('Done in %.02f seconds\n', toc(t));

%%
rng('default');
numEpochs = 10; 
batchSize = 400;
nTraining = length(train.Labels);

%Transferlearning
transferLayers = net.Layers(1:end-3);
layers = [ transferLayers;
           fullyConnectedLayer(15, 'WeightLearnRateFactor', 20, ...
           'BiasLearnRateFactor',20);
           softmaxLayer();
           classificationLayer();];

if ~exist(checkpointDir,'dir'); mkdir(checkpointDir); end

%Set the training options 
options = trainingOptions('sgdm',                          ...
                          'MaxEpochs',20,                  ...
                          'InitialLearnRate',1e-4,         ... 
                          'CheckpointPath', checkpointDir, ...
                          'MiniBatchSize', batchSize,      ...
                          'MaxEpochs',numEpochs);

t = tic;
[net,info] = trainNetwork(train, layers, options);
fprintf('Trained in in %.02f seconds\n', toc(t));


%Test on the training data data
YTrainPred        = classify(net, train);
train_acc         = mean(YTrainPred == train.Labels);
[trainOutputs, ~] = grp2idx(YTrainPred);
[trainTargets, ~] = grp2idx(train.Labels);

figure(3)
plotConfusionMatrix(trainTargets, trainOutputs, 'Training');
savefig('trainingConfusionMatrix_AlexNet.fig')

%Test on the validation data
YValPred        = classify(net, val);
val_acc         = mean(YValPred == val.Labels);
[valOutputs, ~] = grp2idx(YValPred);
[valTargets, ~] = grp2idx(val.Labels);

figure(4)
plotConfusionMatrix(valTargets, valOutputs, 'Validation');
savefig('validationConfusionMatrix_AlexNet.fig')

% Test on the Testing data
YTestPred        = classify(net, test);
test_acc         = mean(YTestPred == test.Labels);
[testOutputs, ~] = grp2idx(YTestPred);
[testTargets, ~] = grp2idx(test.Labels);

figure(5)
plotConfusionMatrix(testTargets, testOutputs, 'Test');
savefig('testConfusionMatrix_AlexNet.fig')

figure(6)
plotTrainingAccuracy_All(info, numEpochs);
savefig('LearningRate.fig')

save('RCNN_AlexNet.mat');
%==========================================================================
%% END
