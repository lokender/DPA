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


function [ distFun, hpFun, fit_model, cardmss, isdegen, d  ] = set_model( model )

switch model
    case 'line'
    
    case 'segment'
       
    case 'circle'
        distFun = @distPointCircle;
        hpFun = @hpCircles;
        fit_model = @fit_circles;
        cardmss = 3;
         isdegen = @isdegen_circle;
        d=3;
    case 'fundamental'
    
    case 'homography'
     
  
    otherwise
        warning('Wrong Model')
end



end

