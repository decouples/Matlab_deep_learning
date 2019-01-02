function In = RemoveFogByLocalHisteq(I, flag)

g1 = GetLocalHisteq(I(:, :, 1));
g2 = GetLocalHisteq(I(:, :, 2));
g3 = GetLocalHisteq(I(:, :, 3));

In = cat(3, g1, g2, g3);

if flag
    figure;
    subplot(2, 2, 1); imshow(I); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(In); title('处理后的图像', 'FontWeight', 'Bold');
    Q = rgb2gray(I);
    W = rgb2gray(In);
    subplot(2, 2, 3); imhist(Q, 64); title('原灰度直方图', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imhist(W, 64); title('处理后的灰度直方图', 'FontWeight', 'Bold');
end

function g = GetLocalHisteq(I)
% 对灰度图像，进行局部直方图均衡化
% 输入参数：
%  I——图像矩阵
% 输出参数：
%  g——结果图像
% 调用库函数adapthisteq，执行局部均衡化增强
g = adapthisteq(I,'clipLimit',0.02,'Distribution','rayleigh');