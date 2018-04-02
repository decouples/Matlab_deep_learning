function [Gi,ng] = Multi_Process(I,g,n)
%多尺度边缘检测函数 
%I, 图像矩阵； G 尺度结构； n 尺度参数
%Gi 边缘图像； ng 多尺度结构元素
if nargin<3
    n=6;
end
%计算多尺度结构元素
ng = g;
for i=1:n
    ng = imdilate(ng,g);
end
%图像开操作
Gi1 = imopen(I,ng);
%膨胀
Gi1 = imdilate(Gi1,ng);
%闭操作
Gi2 = imclose(I,ng);
%腐蚀操作
Gi2 = imerode(Gi2,ng);
%剑法操作
Gi = imsubtract(Gi1,Gi2);
