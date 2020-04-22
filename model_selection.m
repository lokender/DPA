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

consensus_card=sum(tent_inliers2,2);
[~,s_ind_card]=sort(consensus_card);
[~,i_dpts_t]=sort(improved_Sres,2);



%--------------------------Hypothesis correlation-------------------------%
N=length(consensus_card);
T=max(10,round(0.10*nPts));   
h_corr_res_exp=zeros(N,N);
for i=1:N
        
    for j=i+1:N       
        [~,T_ind]=min(consensus_card([i j]));
        a1=zeros(1,nPts);
        a2=zeros(1,nPts);
        a1(1,i_dpts_t(i,1:T))=1;
        a2(1,i_dpts_t(j,1:T))=1;     
         common_pts=all([a1;a2],1);
         all_points=any([a1;a2],1);
      
         R=[improved_Sres(i,common_pts==1);improved_Sres(j,common_pts==1)];
         if ~isempty(R)
                which_one=[i j];
                sig=std(improved_Sres(which_one(T_ind),i_dpts_t(which_one(T_ind),1:T)));
                corr=nnz(common_pts)/T;
        
         else
             corr=0;
         end
         h_corr_res_exp(i,j)=corr;
     end
    
end
h_corr_res_exp=h_corr_res_exp+h_corr_res_exp'+eye(N); % point corr using density
%------------------------------------------------------------------------------%


INL=zeros(N,nPts);
track=ones(1,N);
track_points=zeros(1,nPts);
incl=[];
den_incl_list=[];
h_corr_res_exp_orig=h_corr_res_exp;
th_h_corr=(h_corr_res_exp>0.75);  %homo + circle
while nnz(track)>0
    Track=find(track==1);
    
    if ~isempty(Track)      % 
        [~,dmax]=max(ddrop_overall(Track));
        if (max(improved_den(Track(dmax),:))-(5*median(improved_den(Track(dmax),end-floor(0.05*nPts):nPts))))>0
   
        tmp_set=find(th_h_corr(Track(dmax),Track)==1);
        tmp_set=Track(tmp_set);
        
        tmp_intersect=zeros(1,length(tmp_set));
        for hyp=1:length(tmp_set)
          tmp_intersect(1,hyp)=(nnz(all([track_points;tent_inliers2(tmp_set(hyp),:)],1))/nPts);
        end
        tmp_intersect=[tmp_intersect;consensus_card(tmp_set)'];
        [~,sel_min_contri]=find(tmp_intersect(1,:)<=0.025); 
        [~,sel_min_contri2]=find(tmp_intersect(2,sel_min_contri)>=floor(0.07*nPts));  
        sel_min_contri=sel_min_contri(sel_min_contri2);
        if ~isempty(sel_min_contri)
        [mxcar_val,mxcar_ind]=max(consensus_card(tmp_set(sel_min_contri)));
        mxcar_ind=sel_min_contri(mxcar_ind);
        %[Track(dmax) tmp_set(mxcar_ind)]
        INL(tmp_set(mxcar_ind),:)=any([tent_inliers2(tmp_set(mxcar_ind),:)],1);
        track_points=any([INL],1);
        nnz(track_points);
       
        if any(incl==tmp_set(mxcar_ind))
            break;
        else
        incl=[incl tmp_set(mxcar_ind)];
        track(1,h_corr_res_exp(tmp_set(mxcar_ind),:)>=0.10)=0;   
        end
        else
            track(1,tmp_set)=0;
        end
        else
             track(1,Track(dmax))=0;
        end
    else
        break;
    end

end 
disp('model selected.');    
INL=INL(incl,:);
[est_labels1]=pointModelAssignment(INL,improved_den_pts(incl,:));
[CA,~,~,~]=compute_clustering_performance(gt_data',est_labels1);
figure(100);
plot_labld_data(data,est_labels1);
title('Result');
disp('----------------------------------------------');
disp('Result');
disp('Classification Accuracy (%)');
disp(CA*100);


