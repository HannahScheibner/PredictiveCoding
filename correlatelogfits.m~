
% set paths
SHINEpath = '/Users/hannahscheibner/Documents/MATLAB/SHINEtoolbox/'; 
tifdirectory = spm_select(1, 'dir' )
cd '/Volumes/Transcend/14_PC/02_Scripts/01_github/PredictiveCoding/';
load('file.mat');

[tif_files] = spm_select('FPListRec',tifdirectory,'^0.*\.tif$');

%execute for all images
for i = 1:1750;
    tif_file = strtrim(tif_files(i,:));
    [Slope, GOF] = SF_logfit(tif_file, SHINEpath);
    Slopes(i)=Slope;%store away across images
    GOFs(i)=GOF;
end


%compare to filesize


for i = 1:1750;

    X(i,1) = file.size{i};
    X(i,2) = Slopes(i);
    X(i, 3) = GOFs(i);
     
end
[r,p] = corrcoef(X) 

for i = 1:1750;

    Y(i,1) = file.size{i};
    Y(i,2) = Slopes(i);

end
scatterplot(Y)

corrplot(X)


