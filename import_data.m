clear all;
close all;

% script for importing subjects' data
% this script calls import_data which handles the parsing of each file
% the result is a structure as follows
%
% subjects =
%
% 1x4 struct array with fields:
%     trials
%     name
%
% subjects(1).trials =
%
% 1x30 struct array with fields:
%     x
%     y
%     img
%     timestamp
%     fixX
%     fixY
%     fixTimes
%     fixDurations
%
% change the constants below to point to the experiment directory to
% import and the base names of the subjects to be added to the structure

global EXP_ROOT IMG_ROOT X_RES Y_RES BG_COLOR

% change these
EXP_ROOT = 'example/tobii/';
IMG_ROOT = 'example/images/';
X_RES = 1024;
Y_RES = 768;
BG_COLOR = 0;   % in grayscale
SUBJECT_NAMES = {'sub1'};

% set up data structures
numSubs = length(SUBJECT_NAMES);
subjects(1:numSubs) = struct();

% import subjects
for i=1:numSubs
    % get trials for each subject
    gazeFile = strcat(SUBJECT_NAMES{i}, 'GZD.txt');
    eventFile = strcat(SUBJECT_NAMES{i}, 'EVD.txt');
    fixationFile = strcat(SUBJECT_NAMES{i}, 'FXD.txt');
    fprintf('Importing subject %s...\n', SUBJECT_NAMES{i});
    trials = import_trials(strcat(EXP_ROOT, gazeFile), ...
        strcat(EXP_ROOT, eventFile), strcat(EXP_ROOT, fixationFile));

    % fill in fields
    subjects(i).trials = trials;
    subjects(i).name = SUBJECT_NAMES{i};
end

% add raw fixs and images
subjects = add_raw_fixations(subjects);
images = import_images(strcat(EXP_ROOT, eventFile));

fprintf('Saving data...\n');
save subjects