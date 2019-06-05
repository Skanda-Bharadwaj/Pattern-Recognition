%% Supervised Classifiers
%--------------------------------------------------------------------------
%  
% Load the wine dataset and split it into train/test feature vectors and
% train/test labels
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [train_featureVector, train_labels, test_featureVector, test_labels] =  loadDataset(dataset)

    %load the WINE data
    dataFile = sprintf('%s.data', dataset);
    wine = importdata(dataFile);
    
    % Labels
    winelabel = wine(:, 1);

    % Features
    winefeature = wine(:, 2:end);

   
    train = []; 
    test  = [];  
    for i=1:3
        ind{i} = find(winelabel==i);
        len    = length(ind{i});
        t      = randperm(len);
        half   = round(len/2);
        train  = [train; wine(ind{i}(t(1:half)), :)];
        test   = [test; wine(ind{i}(t(half+1:end)), :)];
    end

    train_featureVector = train(:,2:end);
    train_labels = categorical(train(:,1));

    test_featureVector = test(:,2:end);
    test_labels = categorical(test(:,1));
     

    assert(size(train_featureVector,2)==size(test_featureVector,2)...
        ,'feture vector lengths.  They are not equal between training and testing datasets.')
    assert(size(train_featureVector,1)==length(train_labels)...
        ,'training features and training labels.  They have to have the same number of observations.')
    assert(size(test_featureVector,1)==length(test_labels)...
        ,'testing features and training labels.  They have to have the same number of observations.')
    
    % Print information
    fprintf('Dataset Loaded: %s\n', dataset);
    fprintf('\t# of Classes: %d\n', length(unique(train_labels)));
    fprintf('\t# of Features: %d\n', size(train_featureVector,2));
    fprintf('\t# of Training Observations: %d\n', length(train_labels));
    fprintf('\t# per class in train dataset:\n');
    summary(train_labels)
    fprintf('\t# of Testing Observations: %d\n', length(test_labels));
    fprintf('\t# per class in test dataset:\n');
    summary(test_labels)
    
end
%% END