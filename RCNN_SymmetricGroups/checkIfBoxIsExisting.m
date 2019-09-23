%% RCNN_SymmetricGroups : Supress overlapping bounding boxes
%--------------------------------------------------------------------------
%
% Function: Checks if the current bouding box is going to overlap with the
% already existing bounding boxes that are selected for representing the 
% unit lattices. Since the images are full of objects, conventional
% non-maximum supression is not possible to be done. This is a work around
% to create the same effect.
%
% [In] : All selected bounding boxes representing unit lattice
% [In] : current bounding box that is selected for representing unit
% lattice
%
% [out]: Boolean flag for existance of overlapping box
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function isBoxExisting = checkIfBoxIsExisting(bbox, rect)
    isBoxExisting = false;
    for i = 1:size(bbox, 1)
        existingBox = bbox(i, :);
        
        %Check if the top left corner of the box is within the within the 
        % existing box.
        if (rect(1) <= (existingBox(1)+existingBox(3))/2) && ...
           (rect(2) <= (existingBox(2)+existingBox(4))/2)
            isBoxExisting = true;
        end
    end
end

%==========================================================================
%% END