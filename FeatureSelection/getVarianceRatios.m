%% Variance Ratio and Augmented Variance Ration
%--------------------------------------------------------------------------
%  
% [in] : featureVector
% [in] : trainLabel
%
% [out] : VR (Variance ratio)
% [out] : AVR (Augmented Variance Ratio)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [VR, AVR] = getVarianceRatios(featureVector, trainLabel)
   
    % Calculate the total variance (inter-class) of the feature vector
    interClassVariance = var(featureVector);
    
    %% Separate the classes and find class-wise mean and variances
    classes = unique(trainLabel); 
    for i = 1:length(classes)
        cnt = 0;
        for j = 1:length(trainLabel)
            if(classes(i) == trainLabel(j))
                cnt = cnt+1;
                classWise{i, 1}(cnt, 1) = featureVector(j);
            end
        end
        classWiseMean     = mean(classWise{i, 1}(:, 1));
        classWiseVariance = var(classWise{i, 1}(:, 1));
        classWise{i, 2}   = [classWiseMean, classWiseVariance];
    end
    
    %% Claculate Variance ratios 
    sumOfVariances = 0; sumOfVarianceToMinMeanRatio = 0;
    meanDifference = zeros(i, i);
    for i=1:length(classes)
        for j = 1:length(classes)
            if j~=i
                meanDifference(i, j) = abs(classWise{i, 2}(1, 1) - classWise{j, 2}(1, 1));
            end
        end
        sumOfVariances  = sumOfVariances+classWise{i, 2}(1, 2);
        classWise{i, 3} = min(nonzeros(meanDifference(i, :)));
        
        sumOfVarianceToMinMeanRatio = sumOfVarianceToMinMeanRatio + ...
                                      (classWise{i, 2}(1, 2)/classWise{i, 3});
    end
    
    avgClassWiseVariance          = (1/length(classes))*sumOfVariances;
    avgClassWiseVarianceMeanRatio = (1/length(classes))*sumOfVarianceToMinMeanRatio;
    
    %% Calculate VR and AVR
    if(size(nonzeros(featureVector), 1) ~= 0) %Null check
        VR  = interClassVariance/avgClassWiseVariance;
        AVR = interClassVariance/avgClassWiseVarianceMeanRatio;
    else
        VR = 0;
        AVR = 0;
    end
end
%% END   