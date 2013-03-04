function tm = make_tm_directional(fixations)

dirs = calc_saccade_dirs(fixations);

tm = zeros(8,8);
for i=1:size(dirs,2)-1
   thisDir = dirs(i);
   nextDir= dirs(i+1);
   
   tm(thisDir, nextDir) = tm(thisDir, nextDir) + 1;
end
