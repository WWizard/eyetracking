function subjects = find_fixations(subjects)

% find_fixations examines each subject's data for fixations and updates the
% data structure with the x,y center of each fixation, its onset, and its
% duration. it invokes a fixation finding algorithm, which is expected to
% return - at minimum - the x,y center, onset, and duration of each
% fixation for storage. Currently a velocity threshold-based algorithm is
% implemented.
%
% args - the subjects structure
% return - the modified subjects structure

numSubjects = length(subjects);
numTrials = length(subjects(1).trials);

for i=1:numSubjects
    for j=1:numTrials
        % grab data for this trial        
        data = [subjects(i).trials(j).x; subjects(i).trials(j).y]';
        times = subjects(i).trials(j).times;

        % run them through a fixation finding algorithm
        [fixX, fixY, fixTimes, fixDurations] = velocity_thresh(data, times);
        % now augment the subjects structure with the found fixations
        subjects(i).trials(j).fixX = fixX;
        subjects(i).trials(j).fixY = fixY;
        subjects(i).trials(j).fixTimes = fixTimes;
        subjects(i).trials(j).fixDurations = fixDurations;
    end
end