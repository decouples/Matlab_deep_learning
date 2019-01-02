function I1 = Gray_Convert(I, flag)

if nargin < 2
    flag = 1;
end
if ndims(I) == 3
    I1 = rgb2gray(I);
else
    I1 = I;
end
if flag
    figure('units', 'normalized', 'position', [0 0 1 1]);
    subplot(2, 1, 1); imshow(I, []); title('RGBÍ¼Ïñ', 'FontWeight', 'Bold');
    subplot(2, 1, 2); imshow(I1, []); title('»Ò¶ÈÍ¼Ïñ', 'FontWeight', 'Bold');
end