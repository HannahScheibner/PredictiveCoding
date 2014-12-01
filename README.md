PredictiveCoding
================
In this project, we try to see whether visual processing parallels webp image processing.

### 1 Picture processing

1. Download picture files from:
http://crcns.org/data-sets/vc/vim-1/about-vim-1
(to automate the downloads in Windows you will need to download Cygwin to run the bash scripts (install Net>cURL during installation, then follow the instructions linked to above)

2. Transform matlab pictures into Tif format using this code:
MatlabEncodeTif.m

3. Transform the Tif pictures into WebP

    On Windows: use webp_conversion.m

    On Mac, Unix using this code (works e.g. on mac with webp Terminal):
    TerminalEncodeWebP


4. Run webp_filesize.m to extract information about image file size (creates file.mat).

5. Run create_onset_files.m to create onsets.mat

#4. Then stored information about filesize and picture number on these files (the code used to do this was a really crappy combination of copypaste and excel, don't know whether I want to upload it here...):
#filesizes_trn.txt
#filesize_val.txt

#5. And then created a file that contains: picture number, onset of picture (realtive to fmri), size of picture
#for each {trial} seperately using this function:
#match.m

#(for the match function to work, use 14_PC/matlab_dateien/ folder
#to get 'Stimuli.mat' and 'filesizes_trn.txt')


### 2 Data processing

The data for this project stems from:
http://crcns.org/data-sets/vc/vim-1/about-vim-1
*Kay, K. N., Naselaris, T., Prenger, R. J., & Gallant, J. L. (2008). Identifying natural images from human brain activity. Nature, 452(7185), 352-355.
Naselaris, T., Prenger, R. J., Kay, K. N., Oliver, M., & Gallant, J. L. (2009). Bayesian reconstruction of natural images from human brain activity. Neuron, 63(6), 902-915.

http://www.dam.brown.edu/people/elie/NEUR_1680_2012/Gallant_Nature_2008.pdf

1. Unpack the data using this function:

unpacking\unzip_GZ_files_in_folder.m
(note that you must have all the functions in this folder in your path)

2. smooth the data using this function:

smoothing_job.m

3. run first level analysis:
- needs vast amount of RAM or virtual ram (in windows set your page file to ~ 50 gb of RAM)
- set your MATLAB preferences to support .Mat files larger than 2gb. Preferences > General > Mat files > Version 7.3
- open spm_defaults.m : switch from '-v6' to '-v7.3' under mat format

run batch_social_firstlevel_job_pmod.m

4. run add_pmod_contrasts_pc.m to add contrasts