% 读取图像
clc; clear all; close all;
% 载入图像
[FileName,PathName,FilterIndex] = uigetfile(...
    {'*.jpg;*.tif;*.png;*.gif', ...
    '所有图像文件';...
    '*.*','所有文件' },'载入数字图像',...
    '.\\images\\手写数字\\t0.jpg');
if isequal(FileName, 0) || isequal(PathName, 0)    
    return;    
end
fileName = fullfile(PathName, FileName);
% 读取图像
Img = imread(fileName);
% 图像预处理
if ndims(Img) == 3    
    I = rgb2gray(Img);    
else    
    I = Img;    
end
% 非线性字体大小归一化为24×24点阵
I1 = imresize(I, [24 24], 'bicubic');
% 中值滤波
I2 = medfilt2(I1, 'symmetric');
% 二值化
bw = im2bw(I2, graythresh(I2));
% 反色
bw = ~bw;
% 显示处理结果
figure('Name', '图像预处理', 'NumberTitle', 'Off', ...
    'Units', 'Normalized', 'Position', [0.2 0.2 0.7 0.5]);
subplot(2, 2, 1); imshow(Img, []); title('原图像');
subplot(2, 2, 2); imshow(I1, []); title('灰度图像');
subplot(2, 2, 3); imshow(I2, []); title('滤波图像');
subplot(2, 2, 4); imshow(bw, []); title('二值化图像');
