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

function [vol_all,sorted_ind_pts,density_all,density_pts] = computeDensity(data_params,data,hyps_all,nFracs,res_matG)
%%%%%%%%%%%%% USAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:-
%    data_params -  model specific parameters
%    data-          Data
%    hyps_all-      Minimal sample sets of generated hypothesis
%    nFracs-        Number of fraction fixed (40)
%    res_matG-      Residual matrix
% Output:- 
%    sorted_ind_pts- indices of data points sorted in increasing order of 
%                    their residual values with respect to hypothesis
%    density_all-    density values according to the sorted indices of data points
%    density_pts-    density values with respect to orginal indices of data points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nDim_res = 1; 
[~,nPts] = size(data);
nHyps = size(hyps_all,2);
nElem = data_params.nElem;
winSize = ceil(nPts/nFracs);
win = ones(1,winSize)/winSize;


[dist_sorted_array,sorted_ind_pts] = sort(res_matG,2,'ascend');
dist_sorted_array(:,1:2*nElem)=dist_sorted_array(:,2*nElem)*ones(1,2*nElem)+1e-3;

dist_padded = [dist_sorted_array(:,floor(winSize/2):-1:1),dist_sorted_array,dist_sorted_array(:,end-(floor(winSize/2))+1:end)];

for hyp_i = 1:nHyps,
    vol_all(hyp_i,:) = conv(dist_padded(hyp_i,:),win,'same');
end
vol_all=vol_all(:,floor(winSize/2)+1:floor(winSize/2)+nPts);
assert(size(vol_all,2)==nPts);


density_all = (ones(nHyps,1)*((1:nPts).^(1/nDim_res)))./vol_all; 
density_all(:,end-winSize+1:end) = density_all(:,end-winSize)*ones(1,winSize);

density_all = density_all/mean(density_all(:,end));
density_pts = zeros(size(density_all));
[~,inds_orig] = sort(sorted_ind_pts,2);

for hyp_i = 1:nHyps,
    density_pts(hyp_i,:) = density_all(hyp_i,inds_orig(hyp_i,:));
end

return;
end