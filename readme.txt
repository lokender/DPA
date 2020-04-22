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


The program is free for non-commercial academic use. Any commercial use is strictly prohibited without the authors' consent. 
Please acknowledge the authors by citing the above paper in any academic publications that have made use of this package or part of it.

If you encounter any problems or questions please email to 
lokendert@iiitd.ac.in.

### ABSTRACT###########
Robust multi-model fitting problems are often solved using consensus based or preference based methods, each of which captures
largely independent information from the data. However, most existing techniques still adhere to either of these approaches. In this paper, we
bring these two paradigms together and present a novel robust method for discovering multiple structures from noisy, outlier corrupted data.
Our method adopts a random sampling based hypothesis generation and works on the premise that inliers are densely packed around the
structure, while the outliers are sparsely spread out. We leverage consensus maximization by defining the residual density, which is a simple
and efficient measure of density in the 1-D residual space. We locate the inlier-outlier boundary by using preference based point correlations
together with the disparity in residual density of inliers and outliers. Finally, we employ a simple strategy that uses preference based hypothesis
correlation and residual density to identify one hypothesis representing each structure and their corresponding inliers. The strength of the pro-
posed approach is evaluated empirically by comparing with state-of-the-art techniques over synthetic data and the AdelaideRMF dataset.
#######################

Examples for the following applications are provided:
1. Circle fitting (Three concentric circles).


######################
Main file:  Run following file for demo

>>dpa_main.m
#####################

To develop the code for a new model, specify corresponding model parameters in "set_model.m" and "init_params.m"
and change the model type in "dpa_main.m" .

Key Functions:
----------------------------------------- ---------------------------------------------------------------------
Name								Purpose
---------------------------------------------------------------------------------------------------------------
init_config.m 		      Setup configuration; Initialize the parameters
genRandomHyps.m 	      Hypothesis generation (Note: In orginal paper we used DHF[17] guided sampling algorithm instead of random sampling).
                              (In order to replicate the results of the paper please use DHF for sampling part). 
computeDensity.m	      Compute residual density matrix
computeOverlapPer.m           Compute point correlation score  
lsq_density_improvement.m     Hypothesis refinement
model_selection.m             final model selection
---------------------------------------------------------------------------------------------------------------

For more information about the usage of various functions, refer to individual .m files.

NOTE: The code was only tested on Ubuntu 14.04. Please let us know if you have trouble running the programs on other platforms. 

