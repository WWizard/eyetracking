function tm = make_tm_length(fixations, stateBounds)

lengths = calc_saccade_lengths(fixations);
tm = zeros(size(stateBounds,2), size(stateBounds,2));

for i=1:length(lengths)-1
    curLength = lengths(i);
    nextLength = lengths(i+1);
    
    % find state of curLength and nextLength
    gts = find(stateBounds >= curLength);
    stateBound = stateBounds(gts(1));
    curState = find(stateBounds == stateBound);
    
    gts = find(stateBounds >= nextLength);
    stateBound = stateBounds(gts(1));
    nextState = find(stateBounds == stateBound);
    
    tm(curState, nextState) = tm(curState, nextState) + 1;
end