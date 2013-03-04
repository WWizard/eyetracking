function [tm, states] = make_tm(fixations, img, M, N)

% subdivides an image into m x n regions or m * n states and then
% determines the probability of transitions between states. it is assumed
% that X_RES is evenly divisible by M and Y_RES evenly divisible by N

global X_RES Y_RES;
numStates = M*N;
% states = reshape([1:numStates], M,N)
states = reshape([1:numStates], M,N)'


% calculate region bounds for each state
subs = subdivide(img, Y_RES/N, X_RES/M);

% initialize tm and img regions
tm = zeros(numStates,numStates);

numFixsHere = 0;
for i=1:length(fixations)-1
    curFixX = fixations(i,1);
    curFixY = fixations(i,2);
    nextFixX = fixations(i+1,1);
    nextFixY = fixations(i+1,2);

    clear curState nextState
    curStateFound = 0;
    nextStateFound = 0;
    % find state of current/previous fixations
    for j=0:M-1
        for k=0:N-1
            % is fixation greater than left/bottom bound
            if curFixY >= size(subs,1)*k && ...
                    curFixX >= size(subs,2)*j && ~curStateFound
                % and less than right/top bound
                if curFixY < size(subs,1)*(k+1) && ...
                        curFixX < size(subs,2)*(j+1)
                    curStateFound = 1;
                    curState = states((k+1),(j+1));                  

                end
            end
            if nextFixY >= size(subs,1)*k && ...
                    nextFixX >= size(subs,2)*j && ~nextStateFound
                if nextFixY < size(subs,1)*(k+1) && ...
                        nextFixX < size(subs,2)*(j+1)
                    nextStateFound = 1;
                    nextState = states((k+1),(j+1));

                end
            end
        end
    end

    try
        tm(curState, nextState) = tm(curState, nextState) + 1;
    catch
%         fprintf('HELP ME...\n');
%         curFixX
%         curFixY
%         nextFixX
%         nextFixY
    end

end