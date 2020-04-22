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


function [f_ind,den_slope,f_ind_zero,kth]=computefracUsingExtrapolation(tent_inliers_for_gross,grossOutInd,improved_den,improved_den_pts,improved_den_pts_ind,RMAT)

nPts=length(improved_den);
[~,max_den_ind]=max(improved_den);
strong_inliers_ordered=tent_inliers_for_gross(1,improved_den_pts_ind);
strong_inliers1=find(strong_inliers_ordered==1);
strong_inliers=strong_inliers1(strong_inliers1>max_den_ind);

strong_outliers_ordered=grossOutInd(1,improved_den_pts_ind);
strong_outliers=find(strong_outliers_ordered==1);
strong_outliers=strong_outliers(strong_outliers>max_den_ind);
if isempty(strong_outliers)
    strong_outliers=nPts;
end

if ~isempty(strong_inliers) && ~isempty(strong_outliers)


b_in=find(strong_inliers<strong_outliers(1));
b_out=find(strong_outliers>strong_inliers(end));


if ~isempty(b_in) && ~isempty(b_out)
b_in=b_in(end);
b_out=b_out(1);
kth=nnz(strong_inliers1(strong_inliers1<=strong_inliers(b_in)));

%-----inliers drop----
tot_strong_inliers=(strong_inliers(b_in)-max_den_ind );
for_drop_est=strong_inliers(b_in)-max(2,floor(0.1*tot_strong_inliers))+1:strong_inliers(b_in);

x_inliers = [ RMAT((for_drop_est))];   
del_res=abs(x_inliers-RMAT(max_den_ind));
den_inliers = [improved_den(1,[(for_drop_est)])];

del_den=abs(den_inliers-improved_den(1,max_den_ind));
den_slope=mean(del_den)/mean(del_res);

int_ress=RMAT(1:end);

int_den=zeros(1,length(int_ress));
at_point=length(for_drop_est);

for i_indx=1:length(int_ress)
      int_den(i_indx) = str_lin3(-1*den_slope,[RMAT((for_drop_est(at_point))) improved_den((for_drop_est(at_point)))], int_ress(i_indx));
end


f_ind_zero=find(int_den<=0,1,'first');
f_ind=[];
else
    f_ind=[];
    den_slope=0;
    f_ind_zero=[];
    kth=[];
end
else
    f_ind=[];
    den_slope=0;
     f_ind_zero=[];
     kth=[];
end
end

