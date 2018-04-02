function vec = exactvecotr(img)
% 从img图像中获取特征向量，包括颜色，距离和纹理
% img 图像矩阵，可以为灰度或者彩色
% vec 像素点的特征向量
%初始化特征向量，每个点对应一个特征向量
[m,n,~] = size(img);
vec = zeros(m*n,3);

%转换到特定的颜色空间
%img = rgb2lab(img);
img = double(img);

%循环创建特征像素点
for j=1:n
    for i = 1:m
        %颜色特征
        color = img(i,j,:);
        %距离特征
        %wx =1;wy=1;%距离权值
        %dist = [wx*j/n,wy*i/m];
        dist=[];
        %纹理特征
        texture=[];
        %组成特征向量
        vec((j-1)*m+i,:) = [color(:);dist(:);texture(:)];
    end
end
