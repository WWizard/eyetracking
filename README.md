eyetracking
===========
Suite of Matlab scripts for analyzing eye tracking data. Built-in support for analyzing data from [Tobii eye trackers](http://www.tobii.com/), 
but should be easily extendable to any system that outputs a list of gaze coordinates and their timestamps.

Probably the easiest way to adapt code for non-Tobii eye trackers, would be to write your own import_trials
function that parses the data and creates the appropriate fields below. This should be relatively 
easy with a list of gaze coordinates and their timestamps. There are some extra scripts in the
extra/ directory that are generic fixation-finding algorithms to help with this.


Usage
----
To import data, edit the constants at the top of import_data.m

* EXP_ROOT: root directory of the experiment. trailing slash required
* IMG_ROOT: root directroy of the images. trailing slash required
* X_RES: X dimension of the display resolution
* Y_RES: Y dimension of the display resolution
* SUBJECT_NAMES: a cell array containing the base names of the subjects. 
* The base name is the filename with the extension and GZD/EVD/FXD truncated. For example, the base of sub1GZD.txt 
is sub1.

the resulting structure is called subjects. the general organization is as follows:

 > subjects = 
 
 > 1x4 struct array with fields:  
 >    trials  
 >    name  

 > subjects(1).trials = 
 
 > 1x30 struct array with fields:  
 >     x  
 >     y  
 >     img  
 >     timestamp  
 >     fixX  
 >     fixY  
 >     fixTimes  
 >    fixDurations  

* subjects(i).name: the subject's name  
* subjects(i).trials: 1xnumTrials vector containing the data for each trial  
* subjects(i).trials(j).x: 1xnumDataPoints vector containing the raw x gaze data  
* subjects(i).trials(j).y: 1xnumDataPoints vector containing the raw y gaze data  
* subjects(i).trials(j).img: contains the image shown for the trial. NOTE: the  
	image either needs to be centered on a background of size X_RES x  
	Y_RES or the gaze/fixation coordinates need to be transformed  
	appropriately because the Tobii records with respect to monitor resolution,  
	not image size. quickdemo.m overlays the image on a black background.  
* subjects(i).trials(j).timestamp: the start time for trial j   
* subjects(i).trials(j).fixX: 1xnumFixations vector containing the x fixation data  
* subjects(i).trials(j).fixY: 1xnumFixations vector containing the y fixation data  
* subjects(i).trials(j).fixTimes: 1xnumFixations vector containing the absolute   
	timestamps of each fixation.  
* subjects(i).trials(j).fixDurations: 1xnumFixations vector containing the durations   
	of each fixation  

Also, the data may need to be cleaned to exclude trials that suffer from gaze drift or other
unwanted artifcats. Run clean_data(subjects) to do so. Each trial will be displayed with the data
overlaid. Matlab will prompt you to enter 1 if the trial is free of artifacts and 0 if not. 
subjects(i).trials(j) will be augmented with the field 'clean' which contains either a 1 or 0 for clean 
or unclean data respectively, which can then be used to filter the data.
