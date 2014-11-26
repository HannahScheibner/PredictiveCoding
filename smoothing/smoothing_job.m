% SMOOTH functional files

clear all

[data_directory] = spm_select(1, 'dir' )

[functional_files] = spm_select('FPListRec',data_directory,'^Sub\d_Ses');

for i = 1:length(functional_files(:,1));
    
    matlabbatch{1}.spm.spatial.smooth.data{i,:} = functional_files(i,:);    
    matlabbatch{1}.spm.spatial.smooth.fwhm = [4 4 4];
    % spatial resolution of the data: 2x2x2.5 voxel
    matlabbatch{1}.spm.spatial.smooth.dtype = 0;
    matlabbatch{1}.spm.spatial.smooth.im = 0;
    matlabbatch{1}.spm.spatial.smooth.prefix = 's';
    spm('defaults', 'FMRI');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
    
end