function subjects = add_raw_fixations(subjects)

% add_raw_fixations gathers the raw data associated with each fixation and
% stores it in a cell array, with each cell index containing all the raw
% data corresponding to that index's fixation. Raw fixations are useful for
% creating smoother heatmap images as well as determining whether or not
% the fixation finding is working well.

numSubjects = length(subjects);
numTrials = length(subjects(1).trials);

for i=1:numSubjects
    for j=1:numTrials       
        numFixations = length(subjects(i).trials(j).fixX);
        % raw fixations is a cell array containing x,y vectors of raw data
        % for fixations
        rawFixations = {};
        for k=1:numFixations
            % find raw data corresponding to fixation
            fixStartTime = subjects(i).trials(j).fixTimes(k);
            fixEndTime = fixStartTime + subjects(i).trials(j).fixDurations(k);
            fixStartInd = min(find(subjects(i).trials(j).times >= fixStartTime));
            fixEndInd = max(find(subjects(i).trials(j).times < fixEndTime));
                       
            curFixX = subjects(i).trials(j).x(fixStartInd:fixEndInd);
            curFixY = subjects(i).trials(j).y(fixStartInd:fixEndInd);            
            rawFixations{k} = [curFixX; curFixY]';
        end
        % augment data structure
        subjects(i).trials(j).rawFixations = rawFixations;
    end
end