function heatmap(fixations)

% heatmap takes a cell array of fixations - should be raw fixations - and
% produces a heatmap by sampling a gaussian over each fixation point. the
% size of the filter can be controlled by GSIZE and the parameters passed
% to fspecial

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
imagesc(histogram);