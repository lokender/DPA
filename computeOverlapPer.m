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

function [per,len,lenth] = computeOverlapPer(arr1, arr2)

% Input:- 
%        arr1- first set of top-k preference
%        arr2- second set of top-k preference
% Output:- 
%        per - fraction of common preferences 
%        lenth - Number of common preferences


lar1=length(arr1);
lar2=length(arr2);

arr1 = arr1(:); arr2 = arr2(:);

min_val = min([arr1;arr2]);
max_val = max([arr1;arr2]);

arr1 = arr1-min_val+1;
arr2 = arr2-min_val+1;

bins = min_val:max_val;
n_arr = zeros(length(bins),1);

n_arr(arr1) = n_arr(arr1) + 1;
n_arr(arr2) = n_arr(arr2) + 1;

lenth = sum(n_arr==2);


len=lar2-lenth;
per=lenth/lar2;
if lar2<lar1
per=lenth/lar1;
end
       

return;
end