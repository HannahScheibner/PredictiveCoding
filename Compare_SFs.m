%% Compare_SFs

%script to compare avergae spatial frequency distributions across different types of images

%% optional parameter
normalise=1;%if you set this to one the distribution for each image will be normalised (divided by its peak, which should correspond to the DC component = average intensity of raw image )

%% define paths ( -> -> adjust accordingly! <- <-)

[Rootpath]  = spm_select(1, 'dir' )

%RootPath='C:\Users\Ben\Dropbox\work in progress\Aaa side projects\VisualEntropy_HaukeHannah\';%this is where data for this project lives on my machine

%% need to put different entropy folders in different files

directory = spm_select(1, 'dir' )
[tif_files] = spm_select('FPListRec',directory,'.*\.tif$');

for i = 1:1750;
    tif_file = strtrim(tif_files(i,:));
    
    if file.size{i} < 115548
        movefile (tif_file, strcat(directory,'/WebP_Lo'));
    elseif file.size{i}<126774
        movefile (tif_file, strcat(directory,'/WebP_Lo'));
    elseif file.size{i}<138284
        movefile (tif_file, strcat(directory,'/WebP_Lo'));
    else
        movefile (tif_file, strcat(directory,'/WebP_Lo'));
    end
    
end


%% set file paths


LoEntropyPath=[RootPath filesep 'WebP_Lo' filesep];%path to folder containing LOW entropy images
HiEntropyPath=[RootPath filesep 'WebP_Hi' filesep];%path to folder containing HIGH entropy images

SHINEpath=[RootPath 'SHINEtoolbox' filesep];%path to SHINE toolbox folder - it's probably best when you copy errorplot here as well

%% Get log averages for each type of image
[LoAvg, LoErr, Foo] = Average_SF( LoEntropyPath, SHINEpath, normalise, 0);
[HiAvg, HiErr, Foo] = Average_SF( HiEntropyPath, SHINEpath, normalise, 0);


%% plot both in one figure
figure;
hold on;
set(gca, 'FontSize', 14);
set(gca, 'FontWeight', 'b');

HiHandle=errorplot(1:length(HiAvg), HiAvg, HiErr, 'r');%high entropy images in red
LoHandle=errorplot(1:length(LoAvg), LoAvg, LoErr, 'k');%low entropy images in black

legend([HiHandle, LoHandle],{'High entropy', 'Low entropy'}, 'Location', 'NorthEast');

xlabel('cycles/image');
ylabel('log(rotational avg of Fourier energy)');

saveas(gcf, 'CompareSFs.png')
