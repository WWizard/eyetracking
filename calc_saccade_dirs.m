function dirs = calc_saccade_dirs(fixations)

% every 2 fixations makes a saccade
% algorithm for z from Ponsoda Scott, Findlay, 1995
for i=1:length(fixations)-1
    % saccade composed of x1,y1 x2,y2
    x1 = fixations(i,1);
    y1 = fixations(i,2);
    x2 = fixations(i+1,1);
    y2 = fixations(i+1,2);

    % compute z based on Ponsoda et al
    % atan returns radians, so convert to degrees
    if x2 > x1 && y2 > y1
        z = (atan((y2 - y1)/(x2 - x1))*(180/pi));
    elseif x2 > x1 && y2 < y1
        z = 360 + (atan((y2 - y1)/(x2 - x1))*(180/pi));
    elseif x2 < x1
        z = 180 + (atan((y2 - y1)/(x2 - x1))*(180/pi));
    end

    % compute direction based on Ponsoda et al
    if z <= 22.5 || z > 337.5
        direction = 1; % E
    elseif z > 292.5 && z <= 337.5
        direction = 2;
    elseif z > 247.5 && z <= 292.5
        direction = 3; % S
    elseif z > 202.5 && z <= 247.5
        direction = 4;
    elseif z > 157.5 && z <= 202.5
        direction = 5; % W
    elseif z > 112.5 && z <= 157.5
        direction = 6;
    elseif z > 67.5 && z <= 112.5
        direction = 7; % N
    elseif z > 22.5 && z <= 67.5
        direction = 8;
    end
    
    dirs(i) = direction;
end