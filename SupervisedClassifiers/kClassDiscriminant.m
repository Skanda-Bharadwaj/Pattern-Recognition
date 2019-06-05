%% K-Class Discriminant
%--------------------------------------------------------------------------
%  
% A single K− class discriminant comprising of K linear equations 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function W = kClassDiscriminant(train_featureVector, train_labels)

    %Append a dummy feature
    train_featureVector = [ones(size(train_featureVector, 1), 1), train_featureVector];
    
    %% 1-of-k encoding
    numClasses = length(unique(train_labels));
    labels = zeros(size(train_featureVector, 1), numClasses);
    for i = 1:size(train_featureVector, 1)
        labels(i, double(train_labels(i))) = 1;
    end
    
    %% compute W
    W = (pinv(train_featureVector))*labels;
end
%% END