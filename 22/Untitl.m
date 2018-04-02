clc;close all;
%读取
tic
I = imread('0000.bmp');
I = double(I)/255;
subplot(231)
imshow(I);
title('原始图像');

%不同据类中心图
for i=2:6
    G = imkmeans(I,i);
    subplot(2,3,i);
    imshow(G,[]);
    title(['聚类个数=',num2str(i)]);
end
toc
