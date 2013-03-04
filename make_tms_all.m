close all;

numSubjects = length(subjects);
numTrials = length(subjects(1).trials);

gridX = 4;
gridY = 4;

numStates = 50;
% for lengths. gather all lengths to get range over all subs
% for durations. gather all fixation durations to get range over all subs
fixations = [];
fixDurations = [];
for i=1:numSubjects
    for j=1:numTrials
        fixations = [fixations; [subjects(i).trials(j).fixX; subjects(i).trials(j).fixY]'];
        fixDurations = [fixDurations; [subjects(i).trials(j).fixDurations]'];
    end
end
lengths = calc_saccade_lengths(fixations);
lengthStateBounds = linspace(min(lengths), max(lengths), numStates);
fixDurationStateBounds = linspace(min(fixDurations), max(fixDurations), numStates);

tms = [];
figure;
for i=1:numSubjects
    fixations = [];
    fixDurations = [];
    for j=1:numTrials
        fixations = [fixations; [subjects(i).trials(j).fixX; subjects(i).trials(j).fixY]'];
        fixDurations = [fixDurations; [subjects(i).trials(j).fixDurations]'];
    end
    
    % pick one of the following
    [tm states] = make_tm(fixations, images{1}, gridX, gridY);
%     tm = make_tm_directional(fixations);
%     tm = make_tm_length(fixations, lengthStateBounds);
%     tm = make_tm_fixDurations(fixDurations, fixDurationStateBounds);
    
    subplot(3,4,i);
    imagesc(tm);
    imagesc(thisTM);
    t = sprintf('%s, Raw TM');    
    title(t);
    tms{i} = tm;
end

%% convert tms to probabilities
figure;
for i=1:size(tms,2)
    thisTM = tms{i};
    
    for r=1:size(thisTM,1)
        thisTM(r,:) = thisTM(r,:)/sum(thisTM(r,:));
    end
    
    % replace NaNs
    [xs,ys] = find(isnan(thisTM) == 1);
    thisTM(xs,ys) = 0;
    
    tms{i} = thisTM;
    subplot(3,4,i);
    imagesc(thisTM);
    t = sprintf('%s, TM probabilities');    
    title(t);
end

% calc entropy
entropies = {};
figure;
for i=1:size(tms,2)
    thisTM = tms{i};
    
    entropy = [];
    for r=1:size(thisTM,1)
        entropy(r) = size(find(thisTM(r,:) > 0),2);
    end
    entropies{i} = entropy;
    
    subplot(3,4,i);
    plot(entropy);
    t = sprintf('%s, Entropy=%d', subjects(i).name, mean(entropy));
    title(t);
end