% calculates image statistics for each webp picture

clear all

% [webp_directory] = spm_select(1, 'dir' )

%% select files
webp_directory = '/Volumes/Transcend/14_PC/01_Pictures';


[webp_files] = spm_select('FPListRec',webp_directory,'.*\.webp$');
[tif_files] = spm_select('FPListRec',webp_directory,'.*\.tif$');

 tif_file = strtrim(tif_files(1,:));
 
 %% calculate filesize and rms
 % note that I am not sure whether I ordered the tif and webpfiles in the
 % same way. may need to reconfigure accordingly

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
    %Avg=sfPlot(I,0); % ? several values per image --> how to handle this??
    %RMS
    file.rms{i} = RMS;
    %avg
    %file.avg{i} = Avg;
    tiffiles{i} = I;
    
end

%% calculate luminance and contrast
stats = imstats(tiffiles)

%% calculate correlations

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



