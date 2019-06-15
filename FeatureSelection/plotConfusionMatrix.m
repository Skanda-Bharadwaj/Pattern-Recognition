%% Plot Confusion Matrix
%--------------------------------------------------------------------------
%  
% Plot the confusion matrix for predictions.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function plotConfusionMatrix(groundTruthLabels, predictedLabels, text)

    numClasses = length(unique(groundTruthLabels));
    targets = zeros(numClasses, size(predictedLabels, 1));
    outputs = zeros(numClasses, size(predictedLabels, 1));

    for ii = 1:numClasses
        for jj = 1:size(groundTruthLabels, 1)
            if groundTruthLabels(jj, 1) == 0
                groundTruthLabels(jj, 1) = 2;
            end
            if (groundTruthLabels(jj, 1) == ii)
                targets(ii, jj) = 1;
            else
                targets(ii, jj) = 0;
            end
        end
    end

    for pp = 1:numClasses
        for qq = 1:size(predictedLabels, 1)
            if predictedLabels(qq, 1) == 0
                predictedLabels(qq, 1) = 2;
            end
            if (predictedLabels(qq, 1) == pp)
                outputs(pp, qq) = 1;
            else
                outputs(pp, qq) = 0;
            end
        end
    end
  
    plotconfusion(targets, outputs, text);
    set(findall(0,'FontName','Helvetica','FontSize',10),...
    'FontName','Times New Roman','FontSize',16);
end
%% END