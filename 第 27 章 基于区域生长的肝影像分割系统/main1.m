clc; clear all; close all;
I = imread(fullfile(pwd, 'images/test.jpg'));
X = imadjust(I, [0.2 0.8], [0 1]);
% 区域生长分割
X = im2double(im2uint8(mat2gray(X)));
[J, seed_point, ts] = Regiongrowing(X);
figure(1);
subplot(1, 2, 1); imshow(I, []);
hold on;
plot(seed_point(1), seed_point(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
title('种子点选择');
hold off;
subplot(1, 2, 2); imshow(J, []); title('区域生长分割结果');