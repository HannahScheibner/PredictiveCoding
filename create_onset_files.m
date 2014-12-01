% SAVES ONSET FILES FOR SPM ANALYSIS
%
% needs SPM12b installed
% on windows Matlab needs to be started with administrative rights

clear all

% [webp_directory] = spm_select(1, 'dir' )

webp_directory = 'C:\Users\Peter\Documents\GitHub\PredictiveCoding';
cd(webp_directory)

%% gunzips all gz fmri files and recycles the gz file
% [webp_files] = spm_select('FPListRec',webp_directory,'.*\.webp$');
load('Stimuli.mat')
load('file.mat')

for session = 1:25;
    
    % add all picture onset times in secondS to onsets.all for each session
    onsets.all{:,session} = find(seqTrn(:,session));
    
end

for session = 1:25;
    for pic = 1:140
        
        % find number of pic
        pic_no = seqTrn(onsets.all{:,session}(pic),session);
        
        % add all picture filesizes to the corresponding events for Parametric modulator
        onsets.filesize{:,session}(pic) = file.size{pic_no};
        
    end
end

save onsets onsets