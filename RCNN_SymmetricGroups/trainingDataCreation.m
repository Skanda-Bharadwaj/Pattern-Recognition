%% RCNN_SymmetricGroups : Creating Training Data
%--------------------------------------------------------------------------
%
% Creation of the region proposals for training a deep network. Each image
% is fisrt labelled manually. Since all the images of the group has a
% similar pattern, the labelled infomration is used on all the images to
% extract the region proposal (unit lattice).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
clear; close all; clc;
%==========================================================================

%% Information for Manual Labelling
group = struct;
group = fillGroupValues(group);

%% Input Parameters
dataPath = '../wallpaper_dataset/dataset1';

NoOfFiles=20000;
bbox=cell(2, size(group, 2));

unitLattices   = cell(size(group, 2)*NoOfFiles, 1);
imageFileNames = cell(size(group, 2)*NoOfFiles, 1);

%% Loop through all the groups
for i = 1:size(group, 2)
    
    currentGroup = group(i).Name;
    
    %Create an image datastore of input images from the current group
    imagePath    = fullfile(dataPath, currentGroup);
    imageDir     = dir(imagePath);
    imageDS      = imageDatastore(imagePath);
    
    fprintf('Group: %s\n', currentGroup);
    
    %Fetch the first bounding box(x, y, w, h)
    x = group(i).start_x;
    y = group(i).start_y;
    w = group(i).width;
    h = group(i).height;
    s = group(i).stride;
    
    bbox{1, i} = currentGroup;
    M=256; N=256;
    
    %Label the bounding boxes using group info
    cnt=0; noOfBB=((M-y)-mod((M-y), h))*((N-x)-mod((N-x), w))/(w*h);
    rect = zeros(noOfBB, 4);
    for row = x:s:N-w+1
        for col = y:h:M-h+1
            cnt = cnt+1;
            rect(cnt, :) = [row, col, w, h];
        end
    end
    
    %Create Region Proposals
    createRegionProposals(imageDS.Files, currentGroup, rect);
    bbox{2, i} = rect;
    
end
%==========================================================================
%% END