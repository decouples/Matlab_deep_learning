function In = RemoveFogByLocalHisteq(I,flag)
%分别对三个通道进行均衡化，I原始图，flag标记矩阵，In 结果图像
%分别对三层进行局部直方图均衡化
g1 = GetLocalHisteq(I(:,:,1));
g2 = GetLocalHisteq(I(:,:,2));
g3 = GetLocalHisteq(I(:,:,3));
%集成局部均衡化的结果
In = cat(3,g1,g2,g3);
%显示结果
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
