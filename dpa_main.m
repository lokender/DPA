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

%% Please report any bug to lokendert@iiitd.ac.in %%

clc
clear all;
disp('---------------------------------------');
disp(' Density Preference Analysis (DPA) (ACCV 2016)');
disp('---------------------------------------');
%-------------------------------------------------------------------------%
% GENERATE CONCENTRIC CIRCLE DATA
gen_syn_circles;               
%-------------------------------------------------------------------------%




%------------------Set Model Specific Details and Data parameters---------%
model_type='circle';
data_params.ds_name=model_type;
init_config;
%[~,~,data_params] = get_data(data_params); 
data=Y;
data_params.ds_name = model_type; 
data_params.nPts=size(data,2);
%M=data_params.nPts; 
nPts=data_params.nPts;
nElem=data_params.nElem; % Size of minimal sample set


%% NOTE:- In original paper hypothesis are generated using DHF algorithm.
disp('generating hypothesis ...');
%-------------------------Generate Random Hypothesis----------------------%
[ hypsG,~,Gres_mat] = genRandomHyps( data, model_type );
%-------------------------------------------------------------------------%


MultiModelFitting;


