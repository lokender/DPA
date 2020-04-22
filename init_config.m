%##########################################################################
%% ROBUST MULTI- MODEL FITTING USING DENSITY AND PREFERENCE ANALYSIS
%% This package contains the source code which implements Density Preference 
% Analysis proposed in
% L. Tiwari, S. Anand, and S. Mittal 
% Robust Multi-Model Fitting Using Density and Preference Analysis, 
% In Proceedings of the Asian Conference on Computer Vision (ACCV),
% November 2016, Taipei, Taiwan
% 
% Copyright (c) 2016 L. Tiwari (lokendert@iiitd.ac.in)
% Infosys Center for Artificial Intelligence,
% Dept. of Computer Science and Engineering, IIIT-Delhi, India
% https://www.iiitd.edu.in/~lokendert/
%% Please acknowledge the authors by citing the above paper in any academic 
%  publications that have made use of this package or part of it.
%##########################################################################



% Configuration file for robust estimation using density preferences

%% dpref parameters
nHyps = 500;
nFracs = 40;
frac_arr = 1/nFracs:1/nFracs:1;

switch(lower(data_params.ds_name))
    
    case 'homography'
    isHomography = true;
    data_params.nElem = 4;
    data_params.degenFunc = @isdegenerate_homography;
    data_params.fitFunc = @homography2d_fit;
    data_params.distFunc = @homog2d_dist;
    data_params.n=nan; % unused
    data_params.k=nan; % unused
    data_params.im1=[];
    data_params.orig_data = [];
    data_params.im2=[];
    
    case 'fundamental'
        data_params.nElem = 8;
        data_params.degenFunc = @isdegenerate_fundamental;
        data_params.fitFunc = @fundmatrix;
        data_params.distFunc = @funddistance;
        data_params.n=nan; % unused
        data_params.k=nan; % unused
        data_params.im1=[];
        data_params.orig_data = [];
        data_params.im2=[];
    case {'synthetic','subspace'}
        

    case 'circle'
     
        data_params.nElem=3;
        data_params.degenFunc = @isdegenerate_dummy;
        data_params.fitFunc = @fit_circles;
        data_params.distFunc = @distPointCircle;
        data_params.k = 1; 
        
    case 'hopkins'


    otherwise
end