function In =RemoveFogByGlobalHisteq(I,flag)
%分别对三个通道进行均衡化，I原始图，flag标记矩阵，In 结果图像
if nargin<2
    flag=1;
end
%提取R,G,B分量
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
%分别对三个通道均衡化
M = histeq(R);N = histeq(G);L = histeq(B);
%得到结果图像
In = cat(3,M,N,L);
%显示结果
if flag
    figure;
    subplot(221);imshow(I);title('原图像','FontWeight','Bold');
    subplot(222);imshow(In);title('处理后的图像','FontWeight','Bold');
    %灰度化，用于计算直方图
    Q = rgb2gray(I);
    W = rgb2gray(In);
    subplot(223);imhist(Q,64);title('原始灰度直方图','FontWeight','Bold');
    subplot(224);imhist(W,64);title('处理后的灰度直方图','FontWeight','Bold');
end
