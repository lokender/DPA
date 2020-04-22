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

function [est_label1]=pointModelAssignment(Final_inliers,FinalH_Res_Mat)
nPts=size(Final_inliers,2);
est_label1=zeros(1,nPts);


for m_ind=1:size(FinalH_Res_Mat,1)
    est_label1(1,Final_inliers(m_ind,:)==1)=m_ind;    
end
est_label2=est_label1;
for i=1:nPts
    multi_model_vec=find(Final_inliers(:,i)==1);
    if ~isempty(multi_model_vec) 
    tmp_vec=FinalH_Res_Mat(multi_model_vec,i);
    [~,pref_model]=sort(tmp_vec,'descend');
    est_label2(1,i)=multi_model_vec(pref_model(1));   
    end
end



end