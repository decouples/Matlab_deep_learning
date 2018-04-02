function result = Main_Process(Img,n)
%主函数
%Img 图像矩阵； n 尺度参数； 
%result 结果矩阵
if ndims(Img) == 3
    I = rgb2gray(Img);
else
    I = Img;
end
%结构元素
g1 = [0 1 0;0 1 0;0 1 0];
g2 = [0 0 0;1 1 1;0 0 0];
g3 = [0 0 1;0 1 0;1 0 0];
g4 = [1 0 0;0 1 0;0 0 1];
g5 = [0 1 0;1 1 1;0 1 0];
%指定尺度计算边沿图像
Gi1 = Multi_Process(I,g1,n);
Gi2 = Multi_Process(I,g2,n);
Gi3 = Multi_Process(I,g3,n);
Gi4 = Multi_Process(I,g4,n);
Gi5 = Multi_Process(I,g5,n);
G{1} = Gi1;G{2} = Gi2;G{3} = Gi3;G{4} = Gi4;G{5} = Gi5;
%计算权系数
ua1 = Coef(Gi1,G);
ua2 = Coef(Gi2,G);
ua3 = Coef(Gi3,G);
ua4 = Coef(Gi4,G);
ua5 = Coef(Gi5,G);
u = [ua1,ua2,ua3,ua4,ua5];
u = u/sum(u);
Gf1 = Edge_One(G,u);%融合
result = Gf1;
