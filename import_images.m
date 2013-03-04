function images = import_images(eventFile)

% import_images reads in the images specified by the events structure and
% saves them in a cell array where images{j} is the image for trial j.

% in the event that the image did not take up the entire monitor (X_RES x
% Y_RES), the image is centered on a solid background of color BG_COLOR
% (defined globally in import_data)

% to show the image:
% imagesc(images{j})
% colormap gray

global Y_RES X_RES BG_COLOR IMG_ROOT

% construct background
background = ones(Y_RES,X_RES)*BG_COLOR;

events = parse_event_data_tobii(eventFile);
numTrials = length(events.images);

for i=1:numTrials
    img = imread(strcat(IMG_ROOT, events.images{i}));
    [height, width] = size(img);
    for j=1:height
        background((floor((Y_RES-height)/2))+j,:) = img(j,:);
    end
    images{i} = background;
end