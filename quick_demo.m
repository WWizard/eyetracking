% quick script, useful for generating figures. cycles through all subjects
% and all trials, plotting the image, the scanpath, the raw fixations, and
% the actual fixation centers. hit a key to advance to the next trial

clear all;
close all;

load subjects;

numSubs = length(subjects);
numTrials = length(subjects(1).trials);

for i=1:numSubs
    numClean = 0;
    for j=1:numTrials
        % draw image
        imagesc(images{j});
        colormap gray;
        hold on;
        
        % plot scanpath
        plot(subjects(i).trials(j).x, subjects(i).trials(j).y, 'b-');

        % plot raw fixations
        for k=1:length(subjects(i).trials(j).rawFixations)
           plot(subjects(i).trials(j).rawFixations{k}(:,1), subjects(i).trials(j).rawFixations{k}(:,2), 'g.');
        end

        % plot fixations
        plot(subjects(i).trials(j).fixX, subjects(i).trials(j).fixY, 'r+');        
        hold off;
        
        pause;
    end
end