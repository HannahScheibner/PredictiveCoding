% SAVES ONSET FILES FOR SPM ANALYSIS
%
% needs SPM12b installed
% on windows Matlab needs to be started with administrative rights

clear all

[webp_directory] = spm_select(1, 'dir' )

%webp_directory = 'C:\Users\Peter\Documents\GitHub\PredictiveCoding';
cd(webp_directory)


% [webp_files] = spm_select('FPListRec',webp_directory,'.*\.webp$');
load('Stimuli.mat')
load('file.mat')
load ('stats.mat')


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
        onsets.rms{:,session}(pic) = file.rms{pic_no};
        onsets.meanVec{:,session}(pic) = stats.meanVec(pic_no);
        onsets.stdVec{:,session}(pic) = stats.stdVec(pic_no);
        
    end
end

save onsets onsets