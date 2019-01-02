function s_out = hist_con(s_in, flag)
if nargin < 2
    flag = 0;
end
if ndims(s_in) == 3
    I = rgb2gray(s_in);
else
    I = s_in;
end
s_out = histeq(I);
if flag
    figure;
    subplot(2, 2, 1); imshow(I); title('原图');
    subplot(2, 2, 2); imhist(I); title('原图直方图');
    subplot(2, 2, 3); imshow(s_out); title('均衡化结果');
    subplot(2, 2, 4); imhist(s_out); title('均衡化结果直方图');
end