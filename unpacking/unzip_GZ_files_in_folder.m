% UNPACKS ALL GZ FILES IN A FOLDER YOU SELECT AND RECYCLES THEM AFTER
% UNPACKING
% needs SPM12b installed
% need gunzip_and_recycle.m

clear all

[data_directory] = spm_select(1, 'dir' )
cd(data_directory)

%% gunzips all gz fmri files and recycles the gz file
[gz_files] = spm_select('FPListRec',data_directory,'.*\.gz$');

gunzip_and_recycle(gz_files)