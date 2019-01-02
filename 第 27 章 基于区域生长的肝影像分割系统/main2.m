clc; clear all; close all;
I = imread(fullfile(pwd, 'images/test.jpg'));
X = imadjust(I, [0.2 0.8], [0 1]);
% 阈值分割
bw = im2bw(X, graythresh(X));
[r, c] = find(bw);
rect = [min(c) min(r) max(c)-min(c) max(r)-min(r)];
Xt = imcrop(X, rect);
% 自动获取种子点
seed_point = round([size(Xt, 2)*0.15+rect(2) size(Xt, 1)*0.4+rect(1)]);
% 区域生长分割
X = im2double(im2uint8(mat2gray(X)));
X(1:rect(2), :) = 0;
X(:, 1:rect(1)) = 0;
X(rect(2)+rect(4):end, :) = 0;
X(:, rect(1)+rect(3):end) = 0;
[J, seed_point, ts] = Regiongrowing(X, seed_point);
figure(1);
subplot(1, 2, 1); imshow(I, []);
hold on;
plot(seed_point(1), seed_point(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
title('种子点自动选择');
hold off;
subplot(1, 2, 2); imshow(J, []); title('区域生长图像');
% 形态学后处理
bw = imfill(J, 'holes');
bw = imopen(bw, strel('disk', 5));
% 提取边缘
ed = bwboundaries(bw);
figure;
subplot(1, 2, 1); imshow(bw, []); title('形态学后处理图像');
subplot(1, 2, 2); imshow(I); 
hold on;
for k = 1 : length(ed)
    % 边缘
    boundary = ed{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
end
hold off;
title('边缘标记图像');