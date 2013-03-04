function lengths = calc_saccade_lengths(fixations)

% every 2 fixations makes a saccade
for i=1:length(fixations)-1
    curFix = fixations(i,:);
    nextFix = fixations(i+1,:);
    
    % euclidian distance
    dx = (curFix(1)-nextFix(1))^2;
    dy = (curFix(2)-nextFix(2))^2;
    d = sqrt(dx+dy);
    
    lengths(i) = d;
end