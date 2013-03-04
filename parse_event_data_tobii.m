function events = parse_event_data_tobii(filename)

% tab delimiter
DELIM = char(9);

fid = fopen(filename, 'r');

% parse through headers (13 lines)
for i=1:13
   fgetl(fid);
end

events = struct();
events.images = {};
events.showslide_times = [];
numImages = 1;
% get first line
tline = fgetl(fid);
while tline ~= -1
    [time, tline] = strtok(tline, DELIM);
    [event, tline] = strtok(tline, DELIM);
    [event_key, tline] = strtok(tline, DELIM);
    [date1, tline] = strtok(tline, DELIM);
    [date2, tline] = strtok(tline, DELIM);
    [description, tline] = strtok(tline, DELIM);
    
    time = str2num(time);
    % trim description
    description = description(8:length(description));
    
    if(strcmp(event, 'ShowSlide'))
       events.showslide_times = [events.showslide_times, time]; 
       events.images{numImages} = description;
       numImages = numImages + 1;
    end
    
    tline = fgetl(fid);
end

fclose(fid);