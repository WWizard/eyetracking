function data = parse_gaze_data_tobii(filename)

global X_RES Y_RES;

% tab delimiter
DELIM = char(9);

fid = fopen(filename, 'r');

% parse through headers (15 lines)
for i=1:15
   fgetl(fid);
end

data = struct();
data.x = [];
data.y = [];
data.timestamp = [];
% get first line
tline = fgetl(fid);
while tline ~= -1
    [timestamp, tline] = strtok(tline, DELIM);
    [number, tline] = strtok(tline, DELIM);
    
    [L_gazePtX, tline] = strtok(tline, DELIM);
    [L_gazePtY, tline] = strtok(tline, DELIM);
    [L_camX, tline] = strtok(tline, DELIM);
    [L_camY, tline] = strtok(tline, DELIM);
    [L_distance, tline] = strtok(tline, DELIM);
    [L_pupil, tline] = strtok(tline, DELIM);
    [L_validity, tline] = strtok(tline, DELIM);
    
    [R_gazePtX, tline] = strtok(tline, DELIM);
    [R_gazePtY, tline] = strtok(tline, DELIM);
    [R_camX, tline] = strtok(tline, DELIM);
    [R_camY, tline] = strtok(tline, DELIM);
    [R_distance, tline] = strtok(tline, DELIM);
    [R_pupil, tline] = strtok(tline, DELIM);
    [R_validity, tline] = strtok(tline, DELIM);
    
    lx = str2num(L_gazePtX);
    ly = str2num(L_gazePtY);
    rx = str2num(R_gazePtX);
    ry = str2num(R_gazePtY);
    % average left/right x/y
    x = mean([lx, rx]);
    y = mean([ly, ry]);
    
    % fill in fields
    % filter data    
    if (x > 0 & x < X_RES) & (y > 0 & y < Y_RES)
        data.timestamp = [data.timestamp, str2num(timestamp)];        
        data.x = [data.x, x];
        data.y = [data.y, y];
    end
    
    if mod(str2num(number), 1000) == 0
        fprintf('Parsing frame %s\n', number);
    end
    
    tline = fgetl(fid);
end

fclose(fid);