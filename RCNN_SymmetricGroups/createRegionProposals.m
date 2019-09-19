%% RCNN_SymmetricGroups : Creating Region Proposals
%--------------------------------------------------------------------------
%
% Function: Creates region proposal. Since all the bounding boxes represent
% same pattern, one region is picked per image and is converted into [227,
% 227, 3] image to train pretrained alexnet. 
%
% [In] : imageFiles from imageDatastore
% [In] : group
% [In] : Manually labelled bounding boxes
%
% [out]: Region proposal(unit lattice) of size [227, 227, 3] 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function createRegionProposals(imageFiles, group, bboxes)
    
    %% Parameters
    outputPath = '../wallpaper_dataset/test';
    
    if(~exist(fullfile(outputPath, group), 'dir'))
        mkdir(fullfile(outputPath, group));
    end
    
    %% Loop through the images
    noOFFiles = size(imageFiles, 1);
    for i = 1:noOFFiles 
        % Read Image
        I = imread(imageFiles{i, 1});
        
        % DefineRegion Proposal
        x = bboxes(1, 1);
        y = bboxes(1, 2);
        w = bboxes(1, 3);
        h = bboxes(1, 4);

        % Create region proposal of size [227, 227, 1]
        Isub = I(x:x+h, y:y+w);
        Isub = imresize(Isub, [227, 227]);
        Isub = repmat(Isub, [1, 1, 3]);
        imageName = strsplit(imageFiles{i, 1}, group);

        % Write image
        fprintf('\tWritingimage: %d of %d\n', i, noOFFiles);
        imwrite(Isub, fullfile(outputPath, group, ...
        strcat(group, imageName{1, 3})), 'png');
    end
    
end

%==========================================================================
%% End