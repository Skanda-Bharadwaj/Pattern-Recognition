%--------------------------------------------------------------------------
%% Deep Learning Basics : adjustInputImageSize
%--------------------------------------------------------------------------
%
% This function adjusts the size of the image as required by the input
% layer of the CNN
% 
% [in] : imgPath (image path)
%
% [out] : img (resized image)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function img = adjustInputImageSize(imgPath)
    img = imread(imgPath);
    img= imresize(img(:, :, [1 1 1]), [227 227]);
end

% =========================================================================
%% END