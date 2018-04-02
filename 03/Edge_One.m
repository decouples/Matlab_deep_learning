function Gf = Edge_One(G,u)
%边缘融合函数
%G 边缘图像序列; u 参数向量
%Gf 边沿融合图像
if nargin<2
    u = rand(1,length(G));
    u = u/sum(u(:));
end
%初始化
Gf = zeros(size(G{1}));
for i = 1:length
    Gf = Gf +u(i)*double(G{i});
end
%类型转化
Gf = im2uint8(mat2gray(Gf));
