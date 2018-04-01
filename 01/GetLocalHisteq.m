function g = GetLocalHisteq(I)
%对灰度图像进行局部均衡化
%I 输入图像矩阵，g 结果图像
g = adapthisteq(I,'clipLimit',0.02,'Distribution','rayleigh');
