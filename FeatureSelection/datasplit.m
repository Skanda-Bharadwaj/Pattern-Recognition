%% Data Split
%--------------------------------------------------------------------------
%  
% The function splits the feature matrix in to training and testing data
% based on the required percentage.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function  [X_train, y_train, X_test, y_test] = datasplit(X, y, Training_data_percentage)
    
    % size of the feature matrix
    dataset_size = size(X);
    % create a random sequence
    rand_num     = randperm(dataset_size(1))';

    % Split the feature matrix into train and test based on the input
    % percentage
    X_train = zeros(ceil((Training_data_percentage/100)*dataset_size(1)),... 
                   dataset_size(2));
    X_test  = zeros(dataset_size(1) - ceil((Training_data_percentage/100)*dataset_size(1)),... 
                   dataset_size(2));

    X_train_length = size(X_train, 1);

    y_train = zeros(size(X_train, 1), 1);
    y_test  = zeros(size(X_test, 1), 1);

    % Fill the data
    for i = 1:X_train_length

        X_train(i, :) = X(rand_num(i), :);
        y_train(i, 1) = y(rand_num(i), 1);

    end

    k = 0;
    for j = i+1:dataset_size(1)

        k = k+1;
        X_test(k, :) = X(rand_num(j), :);
        y_test(k, 1) = y(rand_num(j), 1);

    end
end
%% END