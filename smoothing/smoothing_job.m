% SMOOTH functional files

clear all

currentFolder = pwd;
folder_name = uigetdir(currentFolder ,'Select data directory');
cd = folder_name;

data_directory = folder_name;

[files,subject_dirs] = spm_select('ExtFPList',data_directory,'^Sub.*');
% [files,subject_dirs] = spm_select('ExtFPList',data_directory,'dummy.xxx');
%no dummy files in this data set? wie genau findet matlab hier die
%"subject_dirs? --> funktioniert noch nicht

for subject = 1:2
     [scan_frames,dirs] = spm_select('ExtFPListRec',subject_dirs(subject,:),sprintf('^Sub.*',scan_direction),inf)
     
for i = 1:length(scan_frames)
    
    matlabbatch{1}.spm.spatial.smooth.data{i,:} = strtrim(scan_frames(i,:));
    
end
    
    matlabbatch{1}.spm.spatial.smooth.fwhm = [4 4 4];
    % spatial resolution of the data: 2x2x2.5 voxel
    matlabbatch{1}.spm.spatial.smooth.dtype = 0;
    matlabbatch{1}.spm.spatial.smooth.im = 0;
    matlabbatch{1}.spm.spatial.smooth.prefix = 's';
    spm('defaults', 'FMRI');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
 end
end