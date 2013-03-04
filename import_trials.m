function trials = import_trials(gazeFile, eventFile, fixationFile);

% parse tobii data
data = parse_gaze_data_tobii(gazeFile);
events = parse_event_data_tobii(eventFile);
fixations = parse_fix_data_tobii(fixationFile);

% set up trials
numTrials = length(events.images);
trials(1:numTrials) = struct();

% get numTrials - 1 trials
for i=1:numTrials-1
    % find on/off times for images
    on_time = events.showslide_times(i);
    off_time = events.showslide_times(i+1);
    % find gaze data corresponding to this image
    img_start = min(find(data.timestamp >= on_time));
    img_end = max(find(data.timestamp < off_time));
    % find fixations corresponding to this image
    fix_start = min(find(fixations.timestamp >= on_time));
    fix_end = max(find(fixations.timestamp < off_time));

    % fill in fields
    trials(i).x = data.x(img_start:img_end);
    trials(i).y = data.y(img_start:img_end);
    trials(i).times = data.timestamp(img_start:img_end);    
    trials(i).fixX = fixations.x(fix_start:fix_end);
    trials(i).fixY = fixations.y(fix_start:fix_end);
    trials(i).fixTimes = fixations.timestamp(fix_start:fix_end);
    trials(i).fixDurations = fixations.duration(fix_start:fix_end);
end

% get last trial
on_time = events.showslide_times(numTrials);
img_start = min(find(data.timestamp >= on_time));
img_end = length(data.timestamp);

% fill in fields
trials(numTrials).x = data.x(img_start:img_end);
trials(numTrials).y = data.y(img_start:img_end);
trials(numTrials).times = data.timestamp(img_start:img_end);
% fixations
fix_start = min(find(fixations.timestamp >= on_time));
fix_end = length(fixations.timestamp);
trials(numTrials).fixX = fixations.x(fix_start:fix_end);
trials(numTrials).fixY = fixations.y(fix_start:fix_end);
trials(numTrials).fixTimes = fixations.timestamp(fix_start:fix_end);
trials(numTrials).fixDurations = fixations.duration(fix_start:fix_end);