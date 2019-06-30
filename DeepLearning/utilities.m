%--------------------------------------------------------------------------
%% Deep Learning Basics : Utilities
%--------------------------------------------------------------------------
%
% This script implements a class called "utilities" that provides all the
% required utilities to perform transformations on the images.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% =========================================================================

%% Utilities class for the image transformations

%  Class contains functions to perform image transformations.
classdef utilities
    properties
        % Output images
        originalImage;
        rotatedImage;
        scaledImage;
        translatedImage;
        reflectedImage;
        
        % Image properties
        outputImageSize = [128, 128];
    end
    
    %%
    methods
        %% Function to rotate the image by a random angle in the range 0-360
        function rotatedImage = rotateImage(obj)
            rotationAngle = randi([1, 360], 1);
            imgR          = imrotate(obj.originalImage, rotationAngle);
            
            maxI = findOptimumRotation(imgR);
            rotatedImage = imresize(maxI, obj.outputImageSize); 
        end
        
        %% Function to scale the image in the range 50%-100% of the
        %  original image
        function scaledImage = scaleImage(obj)
            scaleFactor = randi([50, 100], 1)/100;
            imgS        = imresize(obj.originalImage, scaleFactor*size(obj.originalImage));
            scaledImage = imresize(imgS, obj.outputImageSize);
        end
        
        %% Function to translate the image in both the directions
        function translatedImage = translateImage(obj)
            % Consider random number of pixels to be translated in x and y
            % direction
            translationFactor   = [randi([1, 20], 1), randi([1, 20], 1)];
            imgT  = imtranslate(obj.originalImage, translationFactor);
            
            % Crop the image to remove zero-padding
            imgTC = imcrop(imgT, [translationFactor(1), ...
                                  translationFactor(2), ...
                                  size(imgT, 2)-translationFactor(1), ...
                                  size(imgT, 1)-translationFactor(2)]);
            translatedImage = imresize(imgTC, obj.outputImageSize);
        end
        
        %% Function to reflect the image along x or y axis
        function reflectedImage = reflectImage(obj)
            [x, y]  = size(obj.originalImage);
            % Choose a randomly the axis to be refelected on
            randNum = randi([1, 2], 1);
            
            reflectedImage = zeros(x, y); 
            switch randNum
                case 1
                    L = obj.outputImageSize(2);
                    reflectedImage(:, L+1:y) = obj.originalImage(:, 1:y-L);
                    reflectedImage(:, 1:L)   = obj.originalImage(:, L:-1:1);
                    reflectedImage = imresize(uint8(reflectedImage), obj.outputImageSize);
            
                case 2
                    L = obj.outputImageSize(1);
                    reflectedImage(L+1:x, :) = obj.originalImage(1:x-L, :);
                    reflectedImage(1:L, :)   = obj.originalImage(L:-1:1, :);
                    reflectedImage = imresize(uint8(reflectedImage), obj.outputImageSize);
                    
                otherwise
                    %None
            end
        end
    end
end