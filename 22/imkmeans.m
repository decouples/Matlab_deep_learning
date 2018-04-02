function [F,C] = imkmeans(I,C)
%I 图像矩阵 ；C 据类中心； F 样本据类编号
if nargin ~=2
    error('IMKEANS:INPUT PARAMENTER NOT RIGHT','只能输入两个参数');
end
if isempty(C)
    K = 2;
    C =[];
elseif isscalar(C)
    K =C;
    C =[];
else
    K=size(C,1);
end

%获取像素点特征向量
X = exactvecotr(I);

%搜索初始据类中心
if isempty(C)
    C = searchinitial(X,'sample',K);
end
%循环搜索据类中心
Cprev=rand(size(C));
while true
    %计算样本到中心的距离
    D = sampledist(X,C,'euclidean');
    %找出最近据类中心
    [~,locs] = min(D,[],2);
    %使用样本均值更新中心】
    for i=1:K
        C(i,:)=mean(X(locs==i,:),1);
    end
    %判断据类算法是否收敛
    if norm(C(:)-Cprev(:))<eps
        break
    end
    Cprev=C;
end

[m,n,~] = size(I);
F = reshape(locs,[m,n]);
