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


function [ mss,H,R] = genRandomHyps( X, model )

[distFun, hpFun, ~, cardmss, isdegen, ~] = set_model( model );

n=max(size(X));
nhper=cardmss;
mss = nan(nhper*max(size(X)),cardmss);
itr=1;
for nhp=1:max(size(X)):size(mss,1)
     pt_ind=1;
     
for i = nhp:itr*max(size(X))
       
        flag=1;
        mss(i,1) = pt_ind; 
        while flag==1
            
            othinx = randsample(n,cardmss-1);    
            if any(mss(i,1)==othinx) || isdegen( X(:,[mss(i,1) ;othinx]) )
             
            else
                
            mss(i,2:cardmss) = othinx;
            pt_ind=pt_ind+1;
            flag=0;
            end            
           
        end
       
end
itr=itr+1;
end


H = hpFun(X,mss); %hypotheses
disp('hypothesis generated.');
disp('computing residuals ...');
R = res( X, H, distFun ); 
disp('residuals computed.')

R=R';
mss=mss';

