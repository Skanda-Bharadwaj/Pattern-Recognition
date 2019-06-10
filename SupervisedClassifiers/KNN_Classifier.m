%% KNN Classifier
%--------------------------------------------------------------------------
%  
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [pred] = KNN_Classifier(k, train_featureVector, train_labels, test_featureVector)

    euclideanDistance = zeros(size(test_featureVector, 1), size(train_featureVector, 1));
    index             = zeros(size(test_featureVector, 1), size(train_featureVector, 1));
    for i = 1:size(test_featureVector, 1)
        for j = 1:size(train_featureVector, 1)
            euclideanDistance(i, j) = sqrt(sum((test_featureVector(i, :)-train_featureVector(j, :)).^2));
        end
        [euclideanDistance(i, :), index(i, :)] = sort(euclideanDistance(i, :));
    end
    
    %%
    kNearestNeighbours = index(:, 1:k);
    labelsCorrespondingToKNN = zeros(size(kNearestNeighbours));
    pred = zeros(size(test_featureVector, 1), 1);
    for p = 1:size(kNearestNeighbours, 1)
        for q = 1:size(kNearestNeighbours, 2)
        labelsCorrespondingToKNN(p, q) = train_labels(kNearestNeighbours(p, q), 1);
        end
        [occurrences, labels] = hist(labelsCorrespondingToKNN(p, :), ...
                                                 unique(labelsCorrespondingToKNN(p, :)));
        [~, ind] = max(occurrences);
        pred(p, 1) = labels(ind);
    end
end
%% END