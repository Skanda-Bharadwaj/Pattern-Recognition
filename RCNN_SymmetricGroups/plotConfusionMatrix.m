%% RCNN_SymmetricGroups : Plotting Confusion Matrix
%--------------------------------------------------------------------------
%
% Plotting Confusion Matrix.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function plotConfusionMatrix(groundTruthLabels, predictedLabels, text)
    numClasses = length(unique(groundTruthLabels));
    targets = zeros(numClasses, size(predictedLabels, 1));
    outputs = zeros(numClasses, size(predictedLabels, 1));
    
    %fprintf('Creating 1-of-k targets...\n');
    for ii = 1:numClasses
        for jj = 1:size(groundTruthLabels, 1)
            if groundTruthLabels(jj, 1) == 6
                groundTruthLabels(jj, 1) = 2;
            elseif groundTruthLabels(jj, 1) == 10
                    groundTruthLabels(jj, 1) = 3;
            end
            if (groundTruthLabels(jj, 1) == ii)
                targets(ii, jj) = 1;
            else
                targets(ii, jj) = 0;
            end
        end
        
    end
    
    %fprintf('Creating 1-of-k outputs...\n');
    for pp = 1:numClasses
        for qq = 1:size(predictedLabels, 1)
            if predictedLabels(qq, 1) == 6
                predictedLabels(qq, 1) = 2;
            elseif predictedLabels(qq, 1) == 10
                predictedLabels(qq, 1) = 3;
            end
            if (predictedLabels(qq, 1) == pp)
                outputs(pp, qq) = 1;
            else
                outputs(pp, qq) = 0;
            end
        end
    end
  
    %fprintf('Plotting Confusion Matrix...\n');
    plotconfusion(targets, outputs, text);
    
    %Fonts and Format
    set(findall(0,'FontName','Helvetica','FontSize',10),...
    'FontName','Times New Roman','FontSize',16);
end

%==========================================================================
%% END