%% Fisher's Projection
%--------------------------------------------------------------------------
%  
% Fisher’s linear discriminant, also known as linear discriminant analysis 
% (LDA) is a di- mensionality reduction technique to create a linear 
% classification model. LDA primarily aims to maximise a function that will
% give a large separation between the projected class means while also
% giving a small variance within each class, thereby minimising the class
% overlap.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function W = fishersProjection(train_featureVector, train_labels, numClass)
    %% Create a data structure to hold classwise observation and compute means
    [N, f] = size(train_featureVector);

    %Create data structure for class-wise information
    Ck = cell(numClass, 3);
    for k = 1:numClass
        cnt = 0; sum_Xn = zeros(f, 1); sum_X = zeros(f, 1);
        for j = 1:N
            sum_X = sum_X + train_featureVector(j, :)';
            %Bifurgate training data into respective classes
            if double(train_labels(j)) == k
                cnt = cnt + 1;
                Ck{k, 1}(cnt, :) = train_featureVector(j, :);
                Ck{k, 2}         = k;
                sum_Xn           = sum_Xn + train_featureVector(j, :)';
            end
        end
        %Compute class-wise mean
        Mn       = (1/cnt)*sum_Xn;
        %store the mean in the cell corresponding to class
        Ck{k, 3} = Mn;
    end
    %Compute over-all mean
    M = (1/N)*sum_X;
    
    %% Calculate Within-Class and Between-Class Variance (Sw and Sb) 
    Sw = zeros(f, f); Sb = zeros(f, f);
    for k = 1:numClass
        %% Between-Calss variance
        Nk   = size(Ck{k, 1}, 1);
        Mk_M = Ck{k, 3} - M;
        Sb   = Sb + (Nk * (Mk_M * Mk_M'));
        
        %% Within-Class
        X_M = Ck{k, 1}' - Ck{k, 3};
        sum_Sk = (X_M * X_M');
        Sw = Sw + sum_Sk;
    end
    
    %% Find the eigen vectors and sort find K-1 largest eigen vectors
    [eigVec, eigVal] = eig(pinv(Sw)*Sb);
    [~, ind] = sort(diag(eigVal), 'descend');
    sorted_eigVec = eigVec(:, ind);
    W = sorted_eigVec(:, 1:numClass-1);
end
%% END