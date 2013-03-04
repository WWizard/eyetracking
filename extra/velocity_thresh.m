function [fixX, fixY, fixTimes fixDurations] = velocity_thresh(data, times)

% velocity_thresh is velocity threshold based algorithm for finding
% fixations. for more information about the algorithm, or more algorithms,
% see the pdf SalvucciGoldberg00.pdf

% Salvucci, D. & Goldberg, J. (2000). Identifying fixations and saccades in
% eye-tracking protocols. 

% basic algorithm:

% for each point-to-point velocity in data, if the velocity is < D_THRESH,
% the point is part of a fixation. gather up contiguous marked fixation
% points and label the center as the fixation and the duration as the
% number of points the constitute it

% threshold for determining whether or not a gaze point is part of a
% fixation or saccade.
% NOTE: it might be useful to define this in terms of the sampling rate and
% visual angle
% S_RATE = 30;
D_THRESH = 40;

% velocity is change in distance over change in time. since change in time
% is constant (30 Hz), we can just take the change in distance
dx = diff(data(:,1));
dy = diff(data(:,2));

d = sqrt(dx.^2 + dy.^2);

% now any point in data whose distance < D_THRESH is a fixation
isFix = zeros(1,size(data, 1));
isFix(find(d < D_THRESH)) = 1;

% now create a simple turing machine that looks for groups of consecutive
% ones
fixX = [];
fixY = [];
fixTimes = [];
fixDurations = [];

i = 1;
while i < length(isFix)
    if(isFix(i))    % found a one
        % mark the onset of the fixation
        fixTimes = [fixTimes, times(i)];
        
        % gather the consecutive ones with a second pointer
        j = i;
        while(isFix(j))
           j = j+1;
        end
        
        % mark the center and duration
        fixX = [fixX, mean(data(i:j-1, 1))];
        fixY = [fixY, mean(data(i:j-1, 2))];
        fixDurations = [fixDurations, j-i]; % in frames
        
        % update first pointer to point to second pointer
        i = j;    
    else
        % increment first pointer until we find a one
        i = i+1;
    end
end