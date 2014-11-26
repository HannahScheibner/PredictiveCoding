clc
clear all

% specify model name:
model = 'smoothed_pmod'

% for using spm_select to select data_dir
[data_directory] = spm_select(1, 'dir' )
% [files,dirs] = spm_select('ExtList',data_directory,'^sSub\d_Ses','inf')

cd(data_directory);
dir_var = dir;



for subject = 1:2
    
    % Create subject specific directories
    fmri_directory = sprintf('%s\\fmri_results\\%s\\subject%d', data_directory, model, subject)
    mkdir(fmri_directory) 
    
    matlabbatch{1}.spm.stats.fmri_spec.dir = {fmri_directory}
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 18;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 9;
 
% Counter for 25 runs (in SPM all called sessions) 5 sessions * 5 runs for
% each subject

 spm_session = 0;

    for session = 1:5
        
        for run = 1:5
            
        spm_session = spm_session + 1

       [run_files] = spm_select('FPListRec',data_directory,sprintf('sSub%d_Ses%d_Run%d_.*', subject, session, run));

       matlabbatch{1,1}.spm.stats.fmri_spec.sess(spm_session,1).scans{scan,1} = run_files;
     

        pmod = 1;
        
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).cond(pmod).name = 'All picture onsets';
        
        % here a file with all the onsets of all pictures must be specified
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).cond(pmod).onset = events3(:,1);
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).cond(pmod).duration = events3(1,2);
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).cond(pmod).tmod = 0;
        
        % Here a file with all the corresponding Predictive coding values or filesizes must be specified
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).cond(pmod).pmod(1).name = 'Filesize';
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).cond(pmod).pmod(1).param = events3(:,3);
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).cond(pmod).pmod(1).poly = 1;
        
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).cond(pmod).orth = 1;
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).multi = {''};
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).regress = struct('name', {}, 'val', {});
        
        [movement_file] = spm_select('FPListRec',event_directory,'Movement_Regressors.txt')
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).multi_reg = {movement_file};
        matlabbatch{1}.spm.stats.fmri_spec.sess(session).hpf = 128;
        
    end
    
    
    
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep;
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tname = 'Select SPM.mat';
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).name = 'filter';
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).value = 'mat';
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).name = 'strtype';
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).value = 'e';
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1).sname = 'fMRI model specification: SPM.mat File';
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_output = substruct('.','spmmat');
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
    
    
    
    %   running the job
    spm('defaults', 'FMRI');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
    
end