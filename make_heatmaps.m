% batch script to create heatmaps for all subjects, all trials

clear all;
close all;

OUTPUT_ROOT = 'heatmaps/';
mkdir(OUTPUT_ROOT);

try
    load subjects;
catch
    import_data;
end

numSubjects = length(subjects);
numTrials = length(subjects(1).trials);

for i=1:numSubjects
    for j=1:numTrials
        heatmap_image(subjects(i).trials(j).rawFixations, images{j});
        % let image stabilize
        pause(.1);
        
        % write out heatmap
        filename = strcat(subjects(i).name, strcat('_', num2str(j)));
        print(gcf, '-dpng', strcat(OUTPUT_ROOT, filename));                        
    end
end