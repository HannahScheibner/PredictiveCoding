function [Avg, Err, Distributions ] = Average_SF(ImFolder, SHINEpath, normalise, plot)
%[ Avg, Err, Distributions ] = Average_SF( ImFolder, SHINEpath, normalise, plot )
%   calculates average spatial frequency (log) distribution across images in a
%   folder
%
% ImFolder: full path to folder containing images of interest, defaults to
% pwd (current directory)
%
% SHINEpath: full path to folder containing code from the SHINE toolbox,
% defaults to [pwd filesep 'SHINEtoolbox' filesep]
%
% normalise: logical argument, distributions will be normalised by the
% maximum bin if set to 1 (default: 1; maximum should be DC component, so the average intensity of the image) 
%
% plot: logical argument, function will plot Avg if set to 1 (defaults to 1)
%
%
% Avg: average spatial frequency distribution across images
%
% Err: standard error of mean for each bin
%
% Distributions: all distributions (one row per image; normalised if requested, but not log'd)
%
% uses sfPlot from the SHINE toolbox to calculate rotational average of the Fourier energy
% spectrum for each image, normalises peak to one, takes log10, then averages distributions, across
% images (available here: http://www.mapageweb.umontreal.ca/gosselif/shine/)
%
% also uses errorplot (written by Sam Schwarzkopf) to produce shaded error plot
%
% found a bug? please let me know!
% benjamindehaas@gmail.com 5/2015
%

%% define defaults
if nargin<4
    plot=1;
end

if nargin<3
    normalise=1;
end

if nargin<2 || isempty(SHINEpath)
    SHINEpath=[pwd filesep 'SHINEtoolbox' filesep];
end

if nargin<1
    ImFolder=pwd;
end

addpath(SHINEpath);%make sure MATLAB has access to sfplot

%% Get SF distributions
ImFiles=dir(ImFolder);%get filenames
ImFiles={ImFiles(~[ImFiles.isdir]).name};

for iIm=1:length(ImFiles)
    ImFile=[ImFolder ImFiles{iIm}];%prepend path
    Distributions(iIm,:)=sfPlot(imread(ImFile),0)';%read in images, get SF distribution using sfplot and add a row for each image
end%for iIm

%% normalise if requested
if normalise
    Distributions=bsxfun(@rdivide,Distributions,max(Distributions,[],2));%divide each row by its maximum
end

%% take log to make more linear
LogDists=log10(Distributions);

%% calculate bin-wise summary stats
Avg=mean(LogDists);
Err=sqrt(nanvar(LogDists)./sum(~isnan(LogDists)));

%% plot if requested
if plot
    figure;
    set(gca, 'FontSize', 14);
    set(gca, 'FontWeight', 'b');
    
    errorplot(1:length(Avg), Avg, Err, 'r');
    xlabel('cycles/image');
    ylabel('log(rotational avg of Fourier energy)');
end%if plot





