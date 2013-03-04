clear all;
close all;

% useful script for cleaning data if you want to exclude certain trials
% overlays each trial's data for each subject on the image and asks the user
% whether or not the trial should be marked as clean
% 1 = clean
% 0 = not clean
% augments the subjects data structure with a field for each trial
% subjects(i).trials(j).clean indicating whether or not it is clean as well 
% as a field subjects(i).numClean indicating how many trials were clean

try
    load subjects
catch
    import_data;
end

numSubs = length(subjects);
numTrials = length(subjects(1).trials);

for i=1:numSubs
    numClean = 0;
    for j=1:numTrials
        imagesc(images{j});
        colormap gray;
        hold on;
        plot(subjects(i).trials(j).x, subjects(i).trials(j).y);
        fprintf('Cleaning trial %d/%d\n', ((i-1)*numTrials)+j, numSubs*numTrials);
        response = input('Is the data clean? Yes=1, No=0\nAnswer: ');
        subjects(i).trials(j).clean = response;
        if response
            numClean = numClean + 1;
        end
        close;
    end
    subjects(i).numClean = numClean;
end

fprintf('Saving clean data...\n');
save subjects;