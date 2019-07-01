%--------------------------------------------------------------------------
%% Deep Learning Basics : Data Augmentation
%--------------------------------------------------------------------------
%
% In this script we augment the image dataset using different kinds of
% transformation. This basically increases the size of the dataset to train
% and test the networks
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================================================================

clear; close all; clc;

%% ========================================================================
%% Creation of augmented data using utilities class

% Input folder paths
inputTrainFolderPath = './data/wallpapers/train';
inputTestFolderPath  = './data/wallpapers/test';
outputTrainPath      = './data/wallpapers/train_aug';
outputTestPath       = './data/wallpapers/test_aug';

% Input directories
inputTrainFolder  = dir(inputTrainFolderPath);
inputTestFolder   = dir(inputTestFolderPath);
outputTrainFolder = dir(outputTrainPath);
outputTestFolder  = dir(outputTestPath);

% Create augmentated dataset for training and testing images
for i = 3:size(inputTrainFolder, 1)
    
    className = inputTrainFolder(i).name;
    [SUCCESS,MESSAGE,MESSAGEID] = mkdir(outputTrainPath, className);
    
    classFolder = dir(fullfile(inputTrainFolderPath, className));
    for j = 3:size(classFolder, 1)
        fprintf('Tain -> Class %s, #%d; Image #%d\n', className, i, j);
        I = imread(fullfile(inputTrainFolderPath, className, classFolder(j).name));
        image = utilities;
        image.originalImage = I;
        
        image.rotatedImage    = rotateImage(image);
        image.scaledImage     = scaleImage(image);
        image.translatedImage = translateImage(image);
        image.reflectedImage  = reflectImage(image);
        
        I = imresize(I, [128, 128]);
        
        splitName = strsplit(classFolder(j).name, '.');
        
        imwrite(I,                     fullfile(outputTrainPath, className, strcat(splitName{1, 1}, 'Original',   '.png')), 'png');
        imwrite(image.rotatedImage,    fullfile(outputTrainPath, className, strcat(splitName{1, 1}, 'Rotated',    '.png')), 'png');
        imwrite(image.scaledImage ,    fullfile(outputTrainPath, className, strcat(splitName{1, 1}, 'Scaled',     '.png')), 'png');
        imwrite(image.translatedImage, fullfile(outputTrainPath, className, strcat(splitName{1, 1}, 'Translated', '.png')), 'png');
        imwrite(image.reflectedImage,  fullfile(outputTrainPath, className, strcat(splitName{1, 1}, 'reflected',  '.png')), 'png');
        
    end
    
end

for i = 3:size(inputTestFolder, 1)
    
    className = inputTestFolder(i).name;
    [SUCCESS,MESSAGE,MESSAGEID] = mkdir(outputTestPath, className);
    
    classFolder = dir(fullfile(inputTestFolderPath, className));
    for j = 3:size(classFolder, 1)
        fprintf('Test -> Class %s, #%d; Image #%d\n', className, i, j);
        I = imread(fullfile(inputTestFolderPath, className, classFolder(j).name));
        image = utilities;
        image.originalImage = I;
        
        image.rotatedImage    = rotateImage(image);
        image.scaledImage     = scaleImage(image);
        image.translatedImage = translateImage(image);
        image.reflectedImage  = reflectImage(image);
        
        I = imresize(I, [128, 128]);
        
        splitName = strsplit(classFolder(j).name, '.');
        
        imwrite(I,                     fullfile(outputTestPath, className, strcat(splitName{1, 1}, 'Original',   '.png')), 'png');
        imwrite(image.rotatedImage,    fullfile(outputTestPath, className, strcat(splitName{1, 1}, 'Rotated',    '.png')), 'png');
        imwrite(image.scaledImage ,    fullfile(outputTestPath, className, strcat(splitName{1, 1}, 'Scaled',     '.png')), 'png');
        imwrite(image.translatedImage, fullfile(outputTestPath, className, strcat(splitName{1, 1}, 'Translated', '.png')), 'png');
        imwrite(image.reflectedImage,  fullfile(outputTestPath, className, strcat(splitName{1, 1}, 'reflected',  '.png')), 'png');
        
    end
    
end