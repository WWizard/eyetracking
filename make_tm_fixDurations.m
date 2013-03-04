function tm = make_tm_fixDurations(fixDurations, stateBounds)

tm = zeros(size(stateBounds,2), size(stateBounds,2));

for i=1:length(fixDurations)-1
    curDuration = fixDurations(i);
    nextDuration = fixDurations(i+1);
    
    % find state of curLength and nextLength
    gts = find(stateBounds >= curDuration);
    stateBound = stateBounds(gts(1));
    curState = find(stateBounds == stateBound);
    
    gts = find(stateBounds >= nextDuration);
    stateBound = stateBounds(gts(1));
    nextState = find(stateBounds == stateBound);
    
    tm(curState, nextState) = tm(curState, nextState) + 1;
end