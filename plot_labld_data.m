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

function plot_labld_data(X,C)

uniqLbl=unique(C);
n=size(X,1);
x=X;
msize=20;

if n==2
    
     if length(uniqLbl)==1
       hold on;plot(x(1,C'==uniqLbl(1)),x(2,C'==uniqLbl(1)),'k.','MarkerSize',msize);
     %  hold on;plot(x(1,C'==uniqLbl(2)),x(2,C'==uniqLbl(2)),'m.','MarkerSize',msize);
     end
     
     if length(uniqLbl)==2
       hold on;plot(x(1,C'==uniqLbl(1)),x(2,C'==uniqLbl(1)),'g.','MarkerSize',msize);
       hold on;plot(x(1,C'==uniqLbl(2)),x(2,C'==uniqLbl(2)),'m.','MarkerSize',msize);
     end
     
     if length(uniqLbl)==3
        hold on;plot(x(1,C'==uniqLbl(1)),x(2,C'==uniqLbl(1)),'g.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(2)),x(2,C'==uniqLbl(2)),'m.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(3)),x(2,C'==uniqLbl(3)),'r.','MarkerSize',msize,'LineWidth',4);
     
     end
     if length(uniqLbl)==4
        hold on;plot(x(1,C'==uniqLbl(1)),x(2,C'==uniqLbl(1)),'g.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(2)),x(2,C'==uniqLbl(2)),'m.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(3)),x(2,C'==uniqLbl(3)),'c.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(4)),x(2,C'==uniqLbl(4)),'r.','MarkerSize',msize,'LineWidth',4);
                 
     end
     if length(uniqLbl)==5
        hold on;plot(x(1,C'==uniqLbl(1)),x(2,C'==uniqLbl(1)),'g.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(2)),x(2,C'==uniqLbl(2)),'m.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(3)),x(2,C'==uniqLbl(3)),'k.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(4)),x(2,C'==uniqLbl(4)),'r.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(5)),x(2,C'==uniqLbl(5)),'b.','MarkerSize',msize,'LineWidth',4);

     end
     
      if length(uniqLbl)==6
        hold on;plot(x(1,C'==uniqLbl(1)),x(2,C'==uniqLbl(1)),'g.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(2)),x(2,C'==uniqLbl(2)),'m.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(3)),x(2,C'==uniqLbl(3)),'k.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(4)),x(2,C'==uniqLbl(4)),'r.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(5)),x(2,C'==uniqLbl(5)),'b.','MarkerSize',msize,'LineWidth',4);
        hold on;plot(x(1,C'==uniqLbl(5)),x(2,C'==uniqLbl(5)),'c.','MarkerSize',msize,'LineWidth',4);
  
      end
      
      
   
     
end
     
     return;
end

