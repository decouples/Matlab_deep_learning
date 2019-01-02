function [I1, bw1] = Image_Rotate(I, bw, angle, flag)

if nargin < 4
    flag = 1;
end
I1 = imrotate(I, -90-angle, 'bilinear');
bw1 = imrotate(bw, -90-angle, 'bilinear');
if flag
    figure('units', 'normalized', 'position', [0 0 1 1]);
    subplot(2, 2, 1); imshow(I, []); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 3); imshow(bw, []); title('原二值图像', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(I1, []); title('校正图像', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imshow(bw1, []); title('校正二值图像', 'FontWeight', 'Bold');
end