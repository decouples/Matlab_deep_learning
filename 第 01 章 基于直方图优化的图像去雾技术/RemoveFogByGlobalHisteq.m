function In = RemoveFogByGlobalHisteq(I, flag)

if nargin < 2
    flag = 1;
end
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
M = histeq(R);
N = histeq(G);
L = histeq(B);
In = cat(3, M, N, L);
if flag
    figure;
    subplot(2, 2, 1); imshow(I); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(In); title('处理后的图像', 'FontWeight', 'Bold');
    Q = rgb2gray(I);
    W = rgb2gray(In);
    subplot(2, 2, 3); imhist(Q, 64); title('原灰度直方图', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imhist(W, 64); title('处理后的灰度直方图', 'FontWeight', 'Bold');
end