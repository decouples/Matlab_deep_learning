function bw2 = Image_Binary(I, flag)

if nargin < 2
    flag = 1;
end
bw1 = im2bw(I, graythresh(I));
bw2 = ~bw1;
if flag
    figure('units', 'normalized', 'position', [0 0 1 1]);
    subplot(1, 3, 1); imshow(I, []); title('待处理图像', 'FontWeight', 'Bold');
    subplot(1, 3, 2); imshow(bw1, []); title('二值化图像', 'FontWeight', 'Bold');
    subplot(1, 3, 3); imshow(bw2, []); title('二值化反色图像', 'FontWeight', 'Bold');
end