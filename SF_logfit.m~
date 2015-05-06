function [Slope, GOF] = SF_logfit( ImFile, SHINEpath, Seed )
%[Slope, GOF] = SF_logfit( ImFile, SHINEpath, Seed )
%   fits the slope of a log function to the (normalised) log amplitude by spatial frequency spectrum of a natural image 
%   (fitted to a function of the form y=log(x.^z), with z being the free parameter) 
%
% ImFile: full path to natural image file
%
% SHINEpath: full path to folder containing code from the SHINE toolbox,
% defaults to [pwd filesep 'SHINEtoolbox' filesep]
%
% Seed: seed value for slope fitting; defaults to -1.2 
% (e.g. Tolhurst et al., 1991 or Fig 2a in http://www.ucl.ac.uk/~smgxpbe/Bex&Makous_02.pdf)
%
% Slope: fitted slope parameter z
%
% GOF: goodness of fit (proportion of variance explained) 
%
%
% uses sfPlot from the SHINE toolbox to calculate rotational average of the Fourier energy
% spectrum for each image, normalises peak to one, takes log10, then fits function to distribution
% (SHINE available here: http://www.mapageweb.umontreal.ca/gosselif/shine/)
%
%  uses nlinfit from MATLAB's stats toolbox for fitting (i.e. nonlinear regression) 
%
% found a bug? please let me know!
% benjamindehaas@gmail.com 5/2015
%

%% define defaults
if nargin<3
    Seed=-1.2;
end

if nargin<2 || isempty(SHINEpath)
    SHINEpath=[pwd filesep 'SHINEtoolbox' filesep];
end

if nargin<1
    ImFolder=pwd;
end

addpath(SHINEpath);%make sure MATLAB has access to sfplot

%% Get SF distribution, normalise it and take log
Distribution=sfPlot(imread(ImFile),0)';%read in images, get SF distribution using sfplot 
Distribution=Distribution./(max(Distribution));
Distribution=log10(Distribution);

%% now fit slope of log function to it
ModelFunction=@(Slope,x) log(x.^Slope);
Slope=nlinfit(1:length(Distribution), Distribution, ModelFunction, Seed);

%% goodness of fit
Fit=log([1:length(Distribution)].^Slope);
SSe=sum((Fit-Distribution).^2);
SStotal=sum((Distribution-mean(Distribution)).^2);
GOF=1-(SSe/SStotal);








