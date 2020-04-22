function [ d ] = distPointCircle( x,C )
%DISTPOINTLINE calcola la distanza euclidea tra un punto x e un piano H
%   Detailed explanation goes here

%d=abs(norm(x-C(1:2))-C(3));

d=zeros(1,size(x,2));
for i=1:size(x,2)
d(1,i)=abs(norm(x(:,i)-C(1:2))-C(3));

end

