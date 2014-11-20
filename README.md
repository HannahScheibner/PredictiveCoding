PredictiveCoding
================
In this project, we try to see whether visual processing parallels webp image processing.

### 1 Picture processing

1. Downloaded picture files from:
http://crcns.org/data-sets/vc/vim-1/about-vim-1


2. Transformed matlab pictures into Tif format using this code:
MatlabEncodeTif.m

3. Transformed the Tif pictures into WebP using this code (works e.g. on mac with webp Terminal)
TerminalEncodeWebP

4. Then stored information about filesize and picture number on these files:
filesizes_trn.txt
filesize_val.txt


5. And then created a file that contains: picture number, onset of picture (realtive to fmri), size of picture
for each {trial} seperately using this function:

match.m

(for the match function to work, use 14_PC/matlab_dateien/ folder
to get 'Stimuli.mat' and 'filesizes_trn.txt')





### 2 Data processing
The data for this project stems from:
http://crcns.org/data-sets/vc/vim-1/about-vim-1

1. gunzipped the data using this function:

2. smoothed the data using this function:



