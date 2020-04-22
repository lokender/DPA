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

disp('computing density...');
%--------------------Density Computation Start---------------------------%

[~, Gsorted_ind_pts,Gdensity_sRes,Gdensity_pts] = computeDensity(data_params,Y,hypsG,nFracs,Gres_mat);
disp('density computed.');
%--------------------Density Computation End-----------------------------%



disp('computing density based point correlation...');
%----- Density Based Point Correlation--------%

density_pts_t=Gdensity_pts';
[~,i_dpts_t]=sort(density_pts_t,2,'descend');

nHyps=size(Gdensity_pts,1);
T=max(10,round(0.01*nHyps));    
p_corr_den=zeros(nPts,nPts); 
for i=1:nPts
    for j=i+1:nPts    
         [per,~] = computeOverlapPer(i_dpts_t(i,1:T), i_dpts_t(j,1:T));
         p_corr_den(i,j)=per;
    end
end
p_corr_den=p_corr_den+p_corr_den'+eye(nPts);


%------------------Normalize point correlation----------%
p_corr_den_norm=zeros(nPts,nPts);
for p_i=1:nPts
      p_corr_den_norm(:,p_i)=p_corr_den(:,p_i)./sum(p_corr_den(:,p_i));   
end
%----- Point Correlation End--------%
disp('correlation computed.');






disp('computing votes...');
%-----Best Hyps Top-5 selection--------%
[~, Gden_ind]=sort(Gdensity_pts,1,'descend');
num_best=5;
bestHyps=Gden_ind(1:num_best,:);
H_Unique_all=unique(bestHyps(:));  % unique in top-5
%------Best Hyps--------%


%-----Hyps Votes Counting--------%
uH=length(H_Unique_all);
HypSupport=zeros(uH,nPts);
for i=1:uH  
    for  j=1:num_best
    HypSupport(i,bestHyps(j,:)==H_Unique_all(i))=1;
    end
end
%-------Hyps Votes Counting end--------%

%---------filtering based on atleast two votes------------%
minvotes=2;%+nElem;
tHypSupport=sum(HypSupport,2);
H_Unique_MinSup=H_Unique_all(tHypSupport>=minvotes);
HypSupport=HypSupport(tHypSupport>=minvotes,:);
tHypSupport=tHypSupport(tHypSupport>=minvotes,:);


[~,tsort_ind]=sort(tHypSupport,'descend');
H_Unique_MinSup=H_Unique_MinSup(tsort_ind);
HypSupport=HypSupport(tsort_ind,:);
tHypSupport=tHypSupport(tsort_ind);

disp('Hypothesis filtered based on at-least two votes');
%--------------------------------------------------------%
disp('refining hypothesis...');
%-------Hypothesis refinement and further-------------------------%
hypothesis_refinement;




