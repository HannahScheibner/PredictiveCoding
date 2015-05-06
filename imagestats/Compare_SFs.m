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
    
    if file.size{i} < 115588
        movefile (tif_file, strcat(directory,'/WebP_Lo'));
    elseif file.size{i}<126842
        movefile (tif_file, strcat(directory,'/WebP_LoMi'));
    elseif file.size{i}<138434
        movefile (tif_file, strcat(directory,'/WebP_HiMi'));
    else
        movefile (tif_file, strcat(directory,'/WebP_Hi'));
    end
    
end



            

%% set file paths


LoEntropyPath=[Rootpath filesep 'WebP_Lo' filesep];%path to folder containing LOW entropy images
HiEntropyPath=[Rootpath filesep 'WebP_Hi' filesep];%path to folder containing HIGH entropy images
LoMiEntropyPath=[Rootpath filesep 'WebP_LoMi' filesep];%
HiMiEntropyPath=[Rootpath filesep 'WebP_HiMi' filesep];%



SHINEpath='/Users/hannahscheibner/Documents/MATLAB/SHINEtoolbox/';%path to SHINE toolbox folder - it's probably best when you copy errorplot here as well

%% Get log averages for each type of image
[LoAvg, LoErr, Foo] = Average_SF( LoEntropyPath, SHINEpath, normalise, 0);
[HiAvg, HiErr, Foo] = Average_SF( HiEntropyPath, SHINEpath, normalise, 0);
[HiMiAvg, HiMiErr, Foo] = Average_SF(HiMiEntropyPath, SHINEpath, normalise, 0);
[LoMiAvg, LoMiErr, Foo] = Average_SF(LoMiEntropyPath, SHINEpath, normalise, 0);



%% plot both in one figure
figure;
hold on;
set(gca, 'FontSize', 14);
set(gca, 'FontWeight', 'b');

HiHandle=errorplot(1:length(HiAvg), HiAvg, HiErr, 'r');%high entropy images in red
LoHandle=errorplot(1:length(LoAvg), LoAvg, LoErr, 'k');%low entropy images in black
HiMiHandle=errorplot(1:length(HiMiAvg), HiMiAvg, HiMiErr, 'b');%
LoMiHandle=errorplot(1:length(LoMiAvg), LoMiAvg, LoMiErr, 'y');%




legend([HiHandle, HiMiHandle, LoMiHandle, LoHandle],{'Quartile 1', 'Quartile 2' 'Quartile 3' 'Quartile 4' }, 'Location', 'NorthEast');

xlabel('cycles/image');
ylabel('log(rotational avg of Fourier energy)');

saveas(gcf, 'CompareSFs.png')
