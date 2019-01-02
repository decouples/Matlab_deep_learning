clc; clear all; close all;
warning off all;
% 读取图像
filename = fullfile(pwd, 'images/test.jpg');
Img = imread(filename);
% 灰度化
if ndims(Img) == 3
    I = rgb2gray(Img);
else
    I = Img;
end
% 直接二值化
bw_direct = im2bw(I);
figure; imshow(bw_direct); title('直接二值化分割');
% 圈选胃区域空气
c = [1524 1390 1454 1548 1652 1738 1725 1673 1524];
r = [1756 1909 2037 2055 1997 1863 1824 1787 1756];
bw_poly = roipoly(bw_direct, c, r);
figure;
imshow(I, []);
hold on;
plot(c, r, 'r-', 'LineWidth', 2);
hold off;
title('胃区域空气选择');
% 设置胃内空气为255
J = I;
J(bw_poly) = 255;
% 图像增强
J = mat2gray(J);
J = imadjust(J, [0.532 0.72], [0 1]);
J = im2uint8(mat2gray(J));
figure; imshow(J, []); title('图像增强处理');
% 直方图统计
[counts, gray_style] = imhist(J);
% 亮度级别
gray_level = length(gray_style);
% 计算各灰度概率
gray_probability  = counts ./ sum(counts);
% 统计像素均值
gray_mean = gray_style' * gray_probability;
% 初始化
gray_vector = zeros(gray_level, 1);
w = gray_probability(1);
mean_k = 0;
gray_vector(1) = realmax;
ks = gray_level-1;
for k = 1 : ks
    % 迭代计算
    w = w + gray_probability(k+1);
    mean_k = mean_k + k * gray_probability(k+1);
    % 判断是否收敛
    if (w < eps) || (w > 1-eps)
        gray_vector(k+1) = realmax;
    else
        % 计算均值
        mean_k1 = mean_k / w;
        mean_k2 = (gray_mean-mean_k) / (1-w);
        % 计算方差
        var_k1 = (((0 : k)'-mean_k1).^2)' * gray_probability(1 : k+1);
        var_k1 = var_k1 / w;
        var_k2 = (((k+1 : ks)'-mean_k2).^2)' * gray_probability(k+2 : ks+1);
        var_k2 = var_k2 / (1-w);
        % 计算目标函数
        if var_k1 > eps && var_k2 > eps
            gray_vector(k+1) = 1+w * log(var_k1)+(1-w) * log(var_k2)-2*w*log(w)-2*(1-w)*log(1-w);
        else
            gray_vector(k+1) = realmax;
        end
    end
end
% 极值统计
min_gray_index = find(gray_vector == min(gray_vector));
min_gray_index = mean(min_gray_index);
% 计算阈值
threshold_kittler = (min_gray_index-1)/ks;
% 阈值分割
bw__kittler = im2bw(J, threshold_kittler);
% 显示
figure; imshow(bw__kittler, []); title('最小误差法分割');
% 形态学后处理
bw_temp = bw__kittler;
% 反色
bw_temp = ~bw_temp;
% 填充孔洞
bw_temp = imfill(bw_temp, 'holes');
% 去噪
bw_temp = imclose(bw_temp, strel('disk', 5));
bw_temp = imclearborder(bw_temp);
% 区域标记
[L, num] = bwlabel(bw_temp);
% 区域属性
stats = regionprops(L);
Ar = cat(1, stats.Area);
% 提取目标并清理
[Ar, ind] = sort(Ar, 'descend');
bw_temp(L ~= ind(1) & L ~= ind(2)) = 0;
% 去噪
bw_temp = imclose(bw_temp, strel('disk',20));
bw_temp = imfill(bw_temp, 'holes');
figure;
subplot(1, 2, 1); imshow(bw__kittler, []); title('待处理二值图像');
subplot(1, 2, 2); imshow(bw_temp, []); title('形态学后处理图像');
% 提取肺边缘
ed = bwboundaries(bw_temp);
% 显示
figure;
subplot(2, 2, 1); imshow(I, []); title('原图像');
subplot(2, 2, 2); imshow(J, []); title('增强图像');
subplot(2, 2, 3); imshow(bw_temp, []); title('二值化图像');
subplot(2, 2, 4); imshow(I, []); hold on;
for k = 1 : length(ed)
    % 边缘
    boundary = ed{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
end
title('肺边缘显示标记');
figure;
subplot(1, 2, 1); imshow(bw_temp, []); title('二值图像');
subplot(1, 2, 2); imshow(I, []); hold on;
for k = 1 : length(ed)
    % 边缘
    boundary = ed{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
end
title('肺边缘显示标记');
