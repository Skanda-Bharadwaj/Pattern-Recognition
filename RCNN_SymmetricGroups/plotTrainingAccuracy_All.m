%% RCNN_SymmetricGroups : Plotting Confusion Matrix
%--------------------------------------------------------------------------
%
% To plot accuracy and error vs number of epoch.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function plotTrainingAccuracy_All(info,numEpochs)
    clf; hold on;
    
    x = linspace(1,numEpochs,length(info.TrainingAccuracy));
    xlabel('Epoch');
    
    yyaxis left;
    plot(x, info.TrainingAccuracy, 'LineWidth', 3, 'DisplayName', ...
        'Training Accuracy');
    
    ax = gca;
    ax.YAxis(1).TickLabelFormat = '%g%%';
    ylim([0,100]); ylabel('Training Accuracy'); 
    
    yyaxis right;
    plot(x,info.TrainingLoss,'LineWidth',3,'DisplayName', 'Training Error/Loss')
    ylabel('Training Error/Loss');
    set(gca, 'FontWeight', 'bold', 'LineWidth', 2); 
    
    grid on; hold off;
    drawnow;
end
%==========================================================================
%% End