function I1 = Image_Normalize(I, flag)

if nargin < 2
    flag = 1;
end
if size(I, 1) > 2000
    I = imresize(I, 0.2, 'bilinear');
end
I1 = imadjust(I, [0 0.6], [0 1]);

if flag
    figure('units', 'normalized', 'position', [0 0 1 1]);
    subplot(2, 1, 1); imshow(I, []); title('Ô­Í¼Ïñ', 'FontWeight', 'Bold');
    subplot(2, 1, 2); imshow(I1, []); title('¹éÒ»»¯Í¼Ïñ', 'FontWeight', 'Bold');
end
