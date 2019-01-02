function D=sampledist(X,C,method,varargin)
[n,p]=size(X);
K=size(C,1);
D=zeros(n,K);
switch lower(method(1))
    case 'e'
        for i=1:K
            D(:,i)=(X(:,1)-C(i,1)).^2;
            for j=2:p
                D(:,i)=D(:,i)+(X(:,j) - C(i,j)).^2;
            end
        end
    case 'c'
        for i=1:K
            D(:,i)=abs(X(:,1) - C(i,1));
            for j=2:p
                D(:,i)=D(:,i) + abs(X(:,j) - C(i,j));
            end
        end
end