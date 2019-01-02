function num = Main_Process(I, flag)
if nargin < 2
    flag = 1;
end
I1 = Normalize_Img(I);
bw1 = Bw_Img(I1);
bw2 = Thin_Img(bw1);
bw = bw2;
sz = size(bw);
[r, c] = find(bw==1);
rect = [min(c) min(r) max(c)-min(c) max(r)-min(r)];
vs = rect(1)+rect(3)*[5/12 1/2 7/12];
hs = rect(2)+rect(4)*[1/3 1/2 2/3];
pt1 = [rect(1:2); rect(1:2)+rect(3:4)];
pt2 = [rect(1)+rect(3) rect(2); rect(1) rect(2)+rect(4)];
k1 = (pt1(1,2)-pt1(2,2)) / (pt1(1,1)-pt1(2,1));
x1 = 1:sz(2);
y1 = k1*(x1-pt1(1,1)) + pt1(1,2);
k2 = (pt2(1,2)-pt2(2,2)) / (pt2(1,1)-pt2(2,1));
x2 = 1:sz(2);
y2 = k2*(x2-pt2(1,1)) + pt2(1,2);
if flag
    figure('Name', '数字识别', 'NumberTitle', 'Off', 'Units', 'Normalized', 'Position', [0.2 0.45 0.5 0.3]);
    subplot(2, 2, 1); imshow(I, []); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(I1, []); title('归一化图像', 'FontWeight', 'Bold');
    hold on;
    h = rectangle('Position', [rect(1:2)-1 rect(3:4)+2], 'EdgeColor', 'r', 'LineWidth', 2);
    legend(h, '数字区域标记', 'Location', 'BestOutside');
    subplot(2, 2, 3); imshow(bw1, []); title('二值化图像', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imshow(bw, [], 'Border', 'Loose'); title('细化图像', 'FontWeight', 'Bold');
    hold on;
    h = [];
    for i = 1 : length(hs)
        h = [h plot([1 sz(2)], [hs(i) hs(i)], 'r-')];
    end
    for i = 1 : length(vs)
        h = [h plot([vs(i) vs(i)], [1 sz(1)], 'g-')];
    end
    h = [h plot(x1, y1, 'y-')];
    h = [h plot(x2, y2, 'm-')];
    legend([h(1) h(4) h(7) h(8)], {'水平线', '竖直线', '左对角线', '右对角线'}, 'Location', 'BestOutside');
    hold off;
end
v{1} = [1:sz(2); repmat(hs(1), 1, sz(2))]';
v{2} = [1:sz(2); repmat(hs(2), 1, sz(2))]';
v{3} = [1:sz(2); repmat(hs(3), 1, sz(2))]';
v{4} = [repmat(vs(1), 1, sz(1)); 1:sz(1)]';
v{5} = [repmat(vs(2), 1, sz(1)); 1:sz(1)]';
v{6} = [repmat(vs(3), 1, sz(1)); 1:sz(1)]';
v{7} = [x1; y1]';
v{8} = [x2; y2]';
for i = 1 : 8
    num(i) = GetImgLinePts(bw, round(v{i})-1);
end
num(9) = sum(sum(endpoints(bw)));