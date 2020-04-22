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




%% Source code to generate circle data

% radii of the circles
radii = [0.08, 0.22, 0.45];


% center of the circles
xc = [0.5, 0.5,0.5];
yc = [0.5, 0.5,0.5];


% number of points on the circles
n_p = [250 450 650];

% total number of outliers
n_o = 300;

% noise
sigma = [0.01 0.015 0.018];


X = rand(2, n_o);
C2=[];

for n_c = 1:numel(radii)
    phi = 2*pi*rand(1, n_p(n_c));    
    x = xc(n_c)+radii(n_c)*cos(phi);
    y = yc(n_c)+radii(n_c)*sin(phi);
    C = [x;y] + sigma(n_c)*randn(2,n_p(n_c));
    
    C2 = [ C2 C];
end
Y = [C2 X];
data=Y;
gt_data=zeros(size(Y,2),1);
gt_data(1:n_p(1))=1;
gt_data(n_p(1)+1:n_p(1)+n_p(2))=2;
gt_data(n_p(1)+n_p(2)+1:n_p(1)+n_p(2)+n_p(3))=3;
