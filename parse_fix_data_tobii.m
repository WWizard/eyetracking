function fixations = parse_fix_data_tobii(filename)

% tab delimiter
DELIM = char(9);

fid = fopen(filename, 'r');

% parse through headers (13 lines)
for i=1:20
   fgetl(fid);
end

fixations = struct();
fixations.x = [];
fixations.y = [];
fixations.timestamp = [];
fixations.duration = [];
% get first line
tline = fgetl(fid);
while tline ~= -1
    % parse line
    [fix_num, tline] = strtok(tline, DELIM);
    [timestamp, tline] = strtok(tline, DELIM);
    [duration, tline] = strtok(tline, DELIM);
    [gazeX, tline] = strtok(tline, DELIM);
    [gazeY, tline] = strtok(tline, DELIM);
    
    % fill in fields
    fixations.x = [fixations.x, str2num(gazeX)];
    fixations.y = [fixations.y, str2num(gazeY)];
    fixations.timestamp = [fixations.timestamp, str2num(timestamp)];
    fixations.duration = [fixations.duration, str2num(duration)];
    
    tline = fgetl(fid);
end

fclose(fid);