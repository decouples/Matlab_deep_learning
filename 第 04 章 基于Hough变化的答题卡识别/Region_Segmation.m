function [bw1, bw2] = Region_Segmation(XY, bw, Img, flag)

if nargin < 4
    flag = 1; 
end

for i = 1 : 2
    xy = XY{i}; 
    XY{i} = [1 xy(1, 2); size(bw, 2) xy(2, 2)];
    ri(i) = round(mean([xy(1,2) xy(2,2)]));
end
minr = min(ri);
maxr = max(ri);
bw1 = bw; bw2 = bw;
bw1(1:minr+5, :) = 0;
bw1(maxr-5:end, :) = 0;
bw2(minr-5:end, :) = 0;
bw2(1:round(minr*0.5), :) = 0;

if flag
    figure('units', 'normalized', 'position', [0 0 1 1]);
    subplot(2, 2, 1); imshow(Img, []); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(bw, []); title('原二值图像', 'FontWeight', 'Bold');
    hold on;
    for i = 1 : 2
        xy = XY{i}; 
        plot(xy(:, 1), xy(:, 2), 'r-', 'LineWidth', 2);
    end
    hold off;
    subplot(2, 2, 3); imshow(bw1, []); title('下区域图像', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imshow(bw2, []); title('上区域图像', 'FontWeight', 'Bold');
end