function D = sampledist(X,C,method,varargin)
%计算样本空间和据类中心的C 的距离
%x 样本空间，nxp 数组
% C 聚类中心，kxp数组
% method: 距离公式
% varargin: 其他参数
% D ：每个点到据类中心的欧氏距离
[n,p] = size(X);
K = size(C,1);
%初始化距离矩阵
D =zeros(n,K);
switch lower(method(1))
    %循环计算聚类中心的距离
    case 'e' %euclidean
        for i=1:K
            D(:,i) = (X(:,1)-C(i,1)).^2;
            for j = 2:p
                D(:,i) = D(:,i)+(X(:,j)-C(i,j)).^2;
            end
        end
    case 'c' %cityblock
        for i = 1:K
            D(:,i) =abs(X(:,1)-C(i,1));
            for j = 2:p
                D(:,i) = D(:,i)+abs(X(:,j)-C(i,j));
            end
        end
end
