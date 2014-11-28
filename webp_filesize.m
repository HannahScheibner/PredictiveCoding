% CONVERTS ALL TIF FILES IN A FOLDER TO WEBP FORMAT AND SAVES SSMI
% (STRUCTURAL SIMILARITY VALUES
% needs SPM12b installed
% need WEBP converter installed https://developers.google.com/speed/webp/docs/precompiled
% on windows Matlab needs to be started with administrative rights

clear all

% [webp_directory] = spm_select(1, 'dir' )

webp_directory = 'C:\Users\Peter\Documents\MATLAB\PredictiveCoding\download\vim-1\Pictures';

%% gunzips all gz fmri files and recycles the gz file
[webp_files] = spm_select('FPListRec',webp_directory,'.*\.webp$');


for i = 1:length(webp_files(:,1));
    
    webp_file = strtrim(webp_files(i,:));
    file_data = dir(webp_file);
    file.name{i} = webp_file(length(webp_directory)+2:end);
    filename = webp_file(length(webp_directory)+2:end);
    dashes = strfind(filename, '_');
    
    %session
    file.session{i} = str2num(filename(1:dashes(1)-1));
    % pic number
    file.pic_no{i} = str2num(filename(dashes(1)+1:dashes(2)-1));
    % file size
    file.size{i} = file_data.bytes;
    
end
save file file