function heatmap_image(fixations, img)

% heatmap_image is identical to heatmap, except that it also accepts an
% image which is composited with the heatmap.

close all;

global X_RES Y_RES;
histogram = zeros(X_RES, Y_RES);

% gaussian for filter
% GSIZE should be odd
GSIZE = 41;
gfilt = fspecial('gaussian', GSIZE, 12.5);
halfSample = (GSIZE-1)/2;

numErrors = 0;
numFixations = length(fixations);
% sample gaussian over histogram to smooth non-foveated areas of fixation
for i=1:numFixations
    curFixation = fixations{i};
    for j=1:length(curFixation)
        try
            % grab GSIZE x GSIZE area from histogram and sample gfilt
            lowerXBound = round(fixations{i}(j,1))-halfSample;
            upperXBound = round(fixations{i}(j,1))+halfSample;
            lowerYBound = round(fixations{i}(j,2))-halfSample;
            upperYBound = round(fixations{i}(j,2))+halfSample;

            histogram(lowerXBound:upperXBound, lowerYBound:upperYBound) = ...
                histogram(lowerXBound:upperXBound, lowerYBound:upperYBound) + gfilt;
        catch
            % don't sample area of gaussian that falls off edge
            numErrors = numErrors + 1;
        end
    end
end

fprintf('%d out of bounds\n', numErrors);
% hack matlab's backwards image display :(
histogram = flipud(rot90(histogram));

% End heatmap generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Begin image overlay

% convert grayscale scene image to RGB so they can be overlaid
RGBimg = zeros(Y_RES, X_RES, 3);
for i=1:Y_RES
    for j=1:X_RES
        RGBimg(i,j,:) = img(i,j);
    end
end

% normalize
RGBimg = RGBimg ./ 255;
histogram = histogram ./ max(max(histogram));

% plot histogram pixels over scene image
% get handles to plots and set transparency (AlphaData)
image(RGBimg);
hold on;
h = imagesc(histogram);
axis off;
set(h, 'AlphaData', .4);