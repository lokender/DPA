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


% Least Square fit

RH=length(H_Pbar);
improved_den=[];
improved_den_pts=[];
improved_den_ind_pts=[];
improved_Sres=[];
sel_list=[];
for indx=1:RH

points_for_lsq=find(tent_inliers(indx,:)==1);

if length(points_for_lsq)>=nElem

if strcmp(data_params.ds_name,'circle')
fittingfn =  data_params.fitFunc;
distfn    = data_params.distFunc;
M = fittingfn(data(:,points_for_lsq),data_params);
error = distfn(data,M);
[~,~,res, FGsorted_ind_pts,~,FGdensity_sRes,FGdensity_pts] = computeDensityPost_Processing(nElem,data,error,nFracs,data_params);
end
if ~isnan(FGdensity_sRes)
improved_den=[improved_den; FGdensity_sRes];
improved_Sres=[improved_Sres;res];
improved_den_pts=[improved_den_pts;FGdensity_pts];
improved_den_ind_pts=[improved_den_ind_pts;FGsorted_ind_pts];
sel_list=[sel_list;indx];  
end
end
end

