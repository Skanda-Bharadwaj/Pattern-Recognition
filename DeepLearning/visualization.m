%--------------------------------------------------------------------------
%% Deep Learning Basics : adjustInputImageSize
%--------------------------------------------------------------------------
%
% This function implements visualization of the intermediate layers of the
% CNN and the t-SNE(t- Stochastic Neighbor Embedding)
% 
% [in] : matFile (this .mat file should contain the "net" ofyour CNN)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function visualization(matFile)
    load(matFile)
    
    %% First layer filters feature visualization
    I = deepDreamImage(net2, 2, 1:20);
    figure
    montage(I);
    title('Features');
    save('FilterVisualization.fig');
    
    %% t-SNE calculation
    d = activations(net2, train, 10);
    y = tsne(d);

    figure
    gscatter(y(:,1),y(:,2), train.Labels)
    savefig('tsne.fig');
end

% =========================================================================
%% END
