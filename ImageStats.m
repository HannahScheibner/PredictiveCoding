% CONVERTS ALL TIF FILES IN A FOLDER TO WEBP FORMAT AND SAVES SSMI
% (STRUCTURAL SIMILARITY VALUES
% needs SPM12b installed
% need WEBP converter installed https://developers.google.com/speed/webp/docs/precompiled
% on windows Matlab needs to be started with administrative rights

clear all

% [webp_directory] = spm_select(1, 'dir' )

webp_directory = '/Volumes/Transcend/14_PC/01_Pictures';

%% gunzips all gz fmri files and recycles the gz file
[webp_files] = spm_select('FPListRec',webp_directory,'.*\.webp$');
[tif_files] = spm_select('FPListRec',webp_directory,'.*\.tif$');

 tif_file = strtrim(tif_files(1,:));

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
    
    %% other image characteristics
    tif_file = strtrim(tif_files(i,:));
    I = imread(tif_file);
    RMS=std(double(I(:)/max(I(:))));
    Avg=sfPlot(I,0);
    %RMS
    file.rms{i} = RMS;
    %avg
    file.avg{i} = Avg;
    tiffiles{i} = I;
    
end

stats = imstats(tiffiles)

%% zunächst einmal Korrelationen berechnen

X = zeros(length(webp_files(:,1)), 4);

 
for i = 1:length(webp_files(:,1));

    X(i,1) = file.size{i};
    X(i,2) = file.rms{i};
    X(i,3) = stats.meanVec(i);
    X(i,4) = stats.stdVec(i);
     
end

[r,p] = corrcoef(X) 


%% save files

[save_directory] = spm_select(1, 'dir' )

%webp_directory = 'C:\Users\Peter\Documents\GitHub\PredictiveCoding';
cd(save_directory)

save file file
save stats stats



