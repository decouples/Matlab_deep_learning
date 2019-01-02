function [F,C]=imkmeans(I,C)
if nargin~=2
    error('IMKMEANS:InputParamterNotRight','只能有两个输入参数！');
end
if isempty(C)
    K=2;
    C=[];
elseif isscalar(C)
    K=C;
    C=[];
else
    K=size(C,1);
end
X=exactvecotr(I);
if isempty(C)
    C=searchintial(X,'sample',K);
end
Cprev=rand(size(C));
while true
    D=sampledist(X,C,'euclidean');
    [~,locs]=min(D,[],2);
    for i=1:K
        C(i,:)=mean(X(locs==i,:),1);
    end
    if norm(C(:)-Cprev(:))<eps
        break
    end
    Cprev=C;
end
[m,n,~]=size(I);
F=reshape(locs,[m,n]);