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

H_Pbar=H_Unique_MinSup;
D=Gdensity_pts(H_Pbar,:);
RMAT=Gres_mat(H_Pbar,:);
odensity=Gdensity_sRes(H_Pbar,:);


%------------------Strong Inliers Identifiation---------------------------%
[~, Gden_ind_hyps]=sort(Gdensity_pts,2,'descend');

w_matrix=zeros(nPts,size(D,1));
tent_inliers=zeros(size(D,1),nPts);

tent_inliers_rem_out=zeros(size(D,1),nPts);
tent_inliers_sres=zeros(size(D,1),nPts);
tent_inliers_sden=zeros(size(D,1),nPts);
o_ddrop=zeros(size(D,1),1);
o_frac=zeros(size(D,1),1);
o_max_den=zeros(size(D,1),1);
for h_ind=1:size(D,1)
    w_vec=ones(nPts,1);
    supp=find(HypSupport(h_ind,:)==1);

    w_vec=prod(p_corr_den_norm(:,supp),2);
    w_vec=w_vec./sum(w_vec);
    w_matrix(:,h_ind)=w_vec;

    tent_inliers(h_ind,w_matrix(:,h_ind)>=min(w_matrix(supp,h_ind)))=1;
end

disp('Strong inliers identified');
%-------------------------------------------------------------------------%


%-------------Least square refinement-------------------------------------%
lsq_density_improvement;
disp('Hypothesis refined.');
%-------------------------------------------------------------------------%



%------------------Gross Outliers Detection-------------------------------%
grossOutInd=zeros(nPts,1);
tent_inliers_for_gross=tent_inliers(sel_list,:);

for i=1:nPts
    if ~any(tent_inliers_for_gross(:,i)) 
       grossOutInd(i,1)=1;
    end
end

disp('Gross outliers Indetified');
disp(nnz(grossOutInd));
%-------------------------------------------------------------------------%



disp('computing fractions....');
%-----------------------Fraction Estimation-------------------------------%
fractions=zeros(1,length(sel_list));
ddrop=zeros(1,length(sel_list));
ddrop_overall=zeros(1,length(sel_list));
kth=zeros(1,length(sel_list));
tent_inliers2=zeros(length(sel_list),nPts);
incl_list=[];
for h_ind=1:length(sel_list)
 [~,mind]=max(improved_den(h_ind,:));
 sorted_res=sort(improved_Sres(h_ind,:));
 [~,drop_rate,f_ind,Kthstronginlier]=computefracUsingExtrapolation(tent_inliers_for_gross(h_ind,:),...
   grossOutInd',improved_den(h_ind,:),improved_den_pts(h_ind,:),improved_den_ind_pts(h_ind,:),...
   sorted_res);

if ~isempty(f_ind)
    incl_list=[incl_list;h_ind];
    fractions(:,h_ind)=f_ind;
    kth(:,h_ind)=Kthstronginlier;
    ddrop(:,h_ind)=drop_rate;
    ddrop_overall(:,h_ind)=(improved_den(h_ind,mind)-improved_den(h_ind,f_ind))/sorted_res(1,f_ind);
    tent_inliers2(h_ind,improved_den_ind_pts(h_ind,1:fractions(:,h_ind)))=1;
else
fractions(:,h_ind)=0;
end
end
%-------------------------------------------------------------------------%

disp('fraction computed.');

improved_den=improved_den(incl_list,:);
improved_den_pts=improved_den_pts(incl_list,:);
improved_den_ind_pts=improved_den_ind_pts(incl_list,:);
improved_Sres=improved_Sres(incl_list,:);
ddrop=ddrop(1,incl_list);
ddrop_overall=ddrop_overall(1,incl_list);
tent_inliers2=tent_inliers2(incl_list,:);

disp('selecting models...');
%---------------------------Model Selection-------------------------------%
model_selection;

