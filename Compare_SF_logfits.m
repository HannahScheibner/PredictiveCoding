%% Compare_SF_logfits

%script to compare slope parameters of fitted spatial frequency distributions across different types of images

clear all;
close all;
clc;

%% define paths ( -> -> adjust accordingly! <- <-)
RootPath='/Users/Ben/Dropbox/work in progress/Aaa side projects/VisualEntropy_HaukeHannah/';%this is where data for this project lives on my machine

LoEntropyPath=[RootPath 'WebP_Lo' filesep];%path to folder containing LOW entropy images
HiEntropyPath=[RootPath 'WebP_Hi' filesep];%path to folder containing HIGH entropy images

SHINEpath=[RootPath 'SHINEtoolbox' filesep];%path to SHINE toolbox folder - it's probably best when you copy errorplot here as well

%% Get images file names
LoEntropyIms=dir(LoEntropyPath);
LoEntropyIms={LoEntropyIms(~[LoEntropyIms.isdir]).name};

HiEntropyIms=dir(HiEntropyPath);
HiEntropyIms={HiEntropyIms(~[HiEntropyIms.isdir]).name};

%% fit a slope for each image

%first low entropy images
for iLoIm=1:length(LoEntropyIms)
    ImFile=[LoEntropyPath LoEntropyIms{iLoIm}];
    [Slope, GOF] = SF_logfit( ImFile, SHINEpath);
    
    LoSlopes(iLoIm)=Slope;%store away across images
    LoGOFs(iLoIm)=GOF;
end%for iLoIm

%now high entropy ones
for iHiIm=1:length(HiEntropyIms)%first low entropy images
    ImFile=[HiEntropyPath HiEntropyIms{iHiIm}];
    [Slope, GOF] = SF_logfit( ImFile, SHINEpath);
    
    HiSlopes(iHiIm)=Slope;%store away across images
    HiGOFs(iHiIm)=GOF;
end%for iLoIm

%% calculate stats across images
LoSlope=mean(LoSlopes);
LoSlopeErr=sqrt(nanvar(LoSlopes)./sum(~isnan(LoSlopes)));%standard error of the mean

LoGOF=mean(LoGOFs);
LoGOFErr=sqrt(nanvar(LoGOFs)./sum(~isnan(LoGOFs)));%standard error of the mean


HiSlope=mean(HiSlopes);
HiSlopeErr=sqrt(nanvar(HiSlopes)./sum(~isnan(HiSlopes)));%standard error of the mean

HiGOF=mean(HiGOFs);
HiGOFErr=sqrt(nanvar(HiGOFs)./sum(~isnan(HiGOFs)));%standard error of the mean

%% plot both in one figure
figure;
hold on;
set(gca, 'FontSize', 14);
set(gca, 'FontWeight', 'b');
LineWidth=2;
Saturation=.8;

%high entropy images
HiHandle=bar(1, HiSlope, 'FaceColor', [1 0 0].*Saturation, 'LineWidth', LineWidth);%high entropy images in red
errorbar(1,HiSlope,HiSlopeErr, '.k', 'LineWidth', LineWidth);

%low entropy images
LoHandle=bar(2, LoSlope, 'FaceColor', [.5 .5 .5].*Saturation, 'LineWidth', LineWidth);%high entropy images in red
errorbar(2,LoSlope,LoSlopeErr, '.k', 'LineWidth', LineWidth);

%labels etc.
legend([HiHandle, LoHandle],{'High entropy', 'Low entropy'}, 'Location', 'NorthEast');
set(gca, 'XTick', []);
ylabel('Slope parameter of log SF amplitude');

saveas(gcf, 'CompareSFslopes.png')


%% second plot for goodness of fit
figure;
hold on;
set(gca, 'FontSize', 14);
set(gca, 'FontWeight', 'b');
LineWidth=2;
Saturation=.8;

%high entropy images
HiHandle=bar(1, HiGOF*100, 'FaceColor', [1 0 0].*Saturation, 'LineWidth', LineWidth);%high entropy images in red
errorbar(1, HiGOF*100, HiGOFErr*100, '.k', 'LineWidth', LineWidth);

%low entropy images
LoHandle=bar(2, LoGOF*100, 'FaceColor', [.5 .5 .5].*Saturation, 'LineWidth', LineWidth);%high entropy images in red
errorbar(2, LoGOF*100, LoGOFErr*100, '.k', 'LineWidth', LineWidth);


%labels etc.
legend([HiHandle, LoHandle],{'High entropy', 'Low entropy'}, 'Location', 'SouthEast');
set(gca, 'XTick', []);
ylabel('% variance explained by log fit');

saveas(gcf, 'CompareSFslopes_GOF.png')



