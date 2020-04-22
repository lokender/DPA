function r = isdegen_circle(X)
X=[X; ones(1,size(X,2))];        

x1 = X(1:3,:);    % Extract x1 and x2 from x
%x2 = X(4:6,:);
if size(X,2)==2
    r=0;
else
r = iscolinear(x1(:,1),x1(:,2),x1(:,3));
end
end
