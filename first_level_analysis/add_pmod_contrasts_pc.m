clc
clear all

data_directory = 'C:\Users\Peter\Documents\MATLAB\PredictiveCoding\download\vim-1\fmri_results\smoothed_pmod_comp';

[files,subject_dirs] = spm_select('ExtFPList',data_directory,'dummy.xxx');

[no_subj dummy] = size(subject_dirs)

for subject = 1:no_subj
    
    SPM_filename = spm_select('FPListRec',sprintf('%s', subject_dirs(subject,:)),'^SPM.mat$');
    
    matlabbatch{1}.spm.stats.con.spmmat(1) = {SPM_filename};
    
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'All_images';
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1];
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'both';
    
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Filesize_pos';
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [0 1];
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'both';
    
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'Filesize_neg';
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [0 -1];
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'both';
    
    matlabbatch{1}.spm.stats.con.consess{4}.fcon.name = 'Effects of interest';
    matlabbatch{1}.spm.stats.con.consess{4}.fcon.convec = {
        [1 0
        0 1]
        }';
    
    matlabbatch{1}.spm.stats.con.consess{4}.fcon.sessrep = 'both';
    
    matlabbatch{1}.spm.stats.con.delete = 1;
    
   
    
    spm('defaults', 'FMRI');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
    
    
end