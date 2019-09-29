%% RCNN_SymmetricGroups :Visualization
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

%==========================================================================
clear; close all; clc;
%==========================================================================
load('RCNN_AlexNet.mat')
    
%% First layer filters feature visualization

%Select all the convolutional layers for visulaization
layers = [2, 6, 10, 12, 14];
for i = 1:size(layers, 2)
    
    %Filter Visulaization
    I = deepDreamImage(net, layers(i), 1:56);
    
    %Plot the figure
    figure
    montage(I); title('Features');
    
    %Save figure
    name = sprintf('layer_%d_visualization.fig', layers(i));
    save(name);
end

%==========================================================================

%% t-SNE calculation

%Select the last fully connected layer from the pre-trained network
layer = 23;

%Calculate activations
d = activations(net, train, layer);
y = tsne(d);

%Plot tsne
figure
gscatter(y(:,1),y(:,2), train.Labels)
savefig('tsne.fig');

%==========================================================================
%% END