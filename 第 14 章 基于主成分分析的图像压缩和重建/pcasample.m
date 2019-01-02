function [coeff,score,rate]=pcasample(X,p)
[V,D]=eig(X'*X);
for i=1:size(V,2)
    [~,idx]=max(abs(V(:,i)));
    V(:,i)=V(:,i)*sign(V(idx,i));
end
[lambda,locs]=sort(diag(D),'descend');
V=V(:,locs);
coeff=V(:,1:p);
score=X*V(:,1:p);
rate=sum(lambda(1:p))/sum(lambda);