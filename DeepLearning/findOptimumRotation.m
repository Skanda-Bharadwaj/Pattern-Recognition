%--------------------------------------------------------------------------
%% Deep Learning Basics : findOptimumRotation
%--------------------------------------------------------------------------
%
% This function removes paddings from the rotated image and chooses the
% best coordinates to create the proper image
% 
% [in] : rotatedImage (rotated image)
%
% [out] : optimumImage 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function optimumImage = findOptimumRotation(rotatedImage)
    [M, N] = size(rotatedImage);

    % Consider non-zeros vectors in rows and colums
    na = cell(M, 1); nb = cell(N, 1);
    for i = 1:M
        na{i, 1}(1, :) = double(nonzeros(rotatedImage(i, :))');
    end
    for i = 1:N
        nb{i, 1}(1, :) = double(nonzeros(rotatedImage(:, i))');
    end

    % Maximize vector length and the row-column difference
    cnt = 0;
    for i = 1:size(na, 1)
        for j = 1:size(nb, 1)
            if(size(na{i, 1}, 2)==size(nb{j, 1}, 2) && size(na{i, 1}, 2)>128)
                cnt = cnt+1;
                myVal(cnt, 1:4) = [i, j, i-j, size(na{i, 1}, 2)];
                myVal(cnt, 5) = abs(abs(myVal(cnt, 3)) - abs(myVal(cnt, 4)));
            end
        end
    end

    [~, ind] = min(myVal(:, 5));
    optimumImage = rotatedImage(myVal(ind, 1):myVal(ind, 2), ...
                                myVal(ind, 1):myVal(ind, 2));
end

% =========================================================================
%% END