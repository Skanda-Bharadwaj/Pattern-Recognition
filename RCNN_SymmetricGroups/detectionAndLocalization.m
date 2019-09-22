%% RCNN_SymmetricGroups : Detection and Localization of unit lattices
%--------------------------------------------------------------------------
%
% In each image a brute force search is implemented for unit lattice in a
% pre-specified search region and is replicated throughout the image. Since
% creating region proposals are extremely expensive, unit latties are
% searched in a very small region taking the advantage of the nature of the
% dataset. The selected region is then replicated thoughout the image.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
clear; close all; clc;
%==========================================================================

%% Load the required network and parameters for testing R-CNN

%Load CNN
load('RCNN_AlexNet.mat');

inputPath = '../wallpaper_dataset/TestData';
inputDir  = dir(inputPath);

%Search Region Specification
imageSize  = 256*ones(1, 2);
searchArea = [imageSize(1), imageSize(2)];

%% Test on images of all groups
all=cell(size(inputDir, 1)-2, 1);

%Loop through groups
for m = 3:size(inputDir, 1)
    group = inputDir(m).name;
    imageDir = dir(fullfile(inputPath, group));
    
    groupStruct = struct;
    groupStruct = fillGroupValues(groupStruct);
    
    for p = 1:size(groupStruct, 2)
        if(strcmp(group, groupStruct(p).Name))
            bbox_width  = groupStruct(p).width;
            bbox_height = groupStruct(p).height;
        end
    end
    fprintf('Wallpaper Group: %s\n', group);
    fprintf('Search Bbox: (%d, %d)\n', bbox_width, bbox_height);
    
    bboxCell=cell(1, 1);
    classCell=cell(1, 1);
    confidenceCell=cell(1, 1);
    perGroup=cell(size(imageDir, 1)-2, 3);
    
    %Loop through images
    for i = 3:size(imageDir, 1)
        I = imread(fullfile(inputPath, group, imageDir(i).name));
        figure; imshow(I); hold on;
        
        cnt=0; cnt1=0; cnt2=0; bboxConf=[]; bbox=[]; class=[];
        %Search for unit lattice in the defined search-space
        for q = 1:searchArea(1)-bbox_width
            for r = 1:searchArea(2)-bbox_height
                cnt=cnt+1;
                fprintf('Row: %d, Col: %d\n', q, r);
                
                %Select sub-regions and convert to [227, 227, 3]
                Isub = I(q:q+bbox_width, r:r+bbox_height);
                Isub = imresize(Isub, [227, 227]);
                Isub = repmat(Isub, [1, 1, 3]);
                
                %Predict using trained ALexNet
                [Pred, confidence] = classify(net, Isub);
                
                %Allow the region to be considered if the confidence is
                %extremely high since all the sub-regions are quite
                %similar
                if max(confidence) > 0.9999
                    cnt1=cnt1+1;
                    rect              = [q, r, bbox_width, bbox_height];
                    class(cnt, 1)     = Pred;
                    bboxConf(cnt1, 1) = max(confidence);
                    
                    %Check for overlapping boxes for the same unit lattice
                    isBoxExisting     = false;
                    if cnt1 > 1
                        isBoxExisting = checkIfBoxIsExisting(bbox, rect);
                    end
                    
                    %Suppress overlapping boxes for the same unit lattice
                    if ~isBoxExisting
                        cnt2 = cnt2+1;
                        bbox(cnt2, :) = rect;
                        rectangle('Position', rect,...
                            'Edgecolor', 'r', 'Linewidth', 3);
                    end
                end
            end
        end
        if (~isempty(bboxConf))
            bboxCell{1, 1}       = bbox;
            classCell{1, 1}      = class;
            confidenceCell{1, 1} = bboxConf;
        end
        
        %Save required data for analysis
        perGroup{i-2, 1} = confidenceCell;
        perGroup{i-2, 2} = bboxCell;
        perGroup{i-2, 3} = classCell;
        
        %Save figures
        name = strcat(group, '_fig', num2str(i-2), '.fig');
        savefig(fullfile('./figures', name));
    end
    all{m-2, 1} = perGroup;
end

save './figures/all.mat' 'all'

%==========================================================================
%% End
