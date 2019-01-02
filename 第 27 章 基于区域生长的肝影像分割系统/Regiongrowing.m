function [J, seed_point, ts] = Regiongrowing(I, seed_point)
% 统计耗时
t1 = cputime;
% 参数检测
if nargin < 2
    % 显示并选择种子点
    figure; imshow(I,[]);  hold on;
    seed_point = ginput(1);   
    plot(seed_point(1), seed_point(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    title('种子点选择');
    hold off;
end
% 变量初始化
seed_point = round(seed_point);
x = seed_point(2);
y = seed_point(1);
I = double(I);
rc = size(I);
J = zeros(rc(1), rc(2));
% 参数初始化
seed_pixel = I(x,y);
seed_count = 1;
pixel_free = rc(1)*rc(2); 
pixel_index = 0;
pixel_list = zeros(pixel_free, 3);
pixel_similarity_min = 0;
pixel_similarity_limit = 0.1;
% 邻域
neighbor_index = [-1 0;
        1 0;
        0 -1;
        0 1];
% 循环处理
while pixel_similarity_min < pixel_similarity_limit && seed_count < rc(1)*rc(2)   
    % 增加邻域点
    for k = 1 : size(neighbor_index, 1)
        % 计算相邻位置
        xk = x + neighbor_index(k, 1); 
        yk = y + neighbor_index(k, 2);
        % 区域生长
        if xk>=1 && yk>=1 && xk<=rc(1) && yk<=rc(2) && J(xk,yk) == 0
            % 满足条件
            pixel_index = pixel_index+1;
            pixel_list(pixel_index,:) = [xk yk I(xk,yk)]; 
            % 更新状态
            J(xk, yk) = 1;
        end
    end
    % 更新空间
    if pixel_index+10 > pixel_free 
        pixel_free = pixel_free+pixel_free;
        pixel_list(pixel_index+1:pixel_free,:) = 0;
    end
    % 统计迭代
    pixel_similarity = abs(pixel_list(1:pixel_index,3) - seed_pixel);
    [pixel_similarity_min, index] = min(pixel_similarity);
    % 更新状态
    J(x,y) = 1; 
    seed_count = seed_count+1;
    seed_pixel = (seed_pixel*seed_count + pixel_list(index,3))/(seed_count+1);
    % 存储位置
    x = pixel_list(index,1); 
    y = pixel_list(index,2);
    pixel_list(index,:) = pixel_list(pixel_index,:);
    pixel_index = pixel_index-1;
end
% 返回结果
J = mat2gray(J);
J = im2bw(J, graythresh(J));
% 统计耗时
t2 = cputime;
ts = t2 - t1;