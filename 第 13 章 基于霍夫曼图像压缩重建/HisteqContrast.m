function HisteqContrast(Img1, Img2)
figure('Name', '直方图对比', 'NumberTitle', 'Off', ...
    'Units', 'Normalized', 'Position', [0.1 0.1 0.5 0.5]);
subplot(2, 2, 1); imshow(mat2gray(Img1)); title('原图像', 'FontWeight', 'Bold');
subplot(2, 2, 2); imshow(mat2gray(Img2)); title('处理后的图像', 'FontWeight', 'Bold');
if ndims(Img1) == 3
    Q = rgb2gray(Img1);
else
    Q = mat2gray(Img1);
end

if ndims(Img2) == 3
    W = rgb2gray(Img2);
else
    W = mat2gray(Img2);
end

subplot(2, 2, 3); imhist(Q, 64); title('原灰度直方图', 'FontWeight', 'Bold');
subplot(2, 2, 4); imhist(W, 64); title('处理后的灰度直方图', 'FontWeight', 'Bold');
