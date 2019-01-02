function ind_dis_sort = SearchResult(vec_hu, vec_color, H)
% 图像检索
vec_hus = cat(1, H.vec_hu);
vec_colors = cat(1, H.vec_color);
% 分别计算Hu、颜色的距离差异
vec_hu = repmat(vec_hu, size(vec_hus, 1), 1);
vec_color = repmat(vec_color, size(vec_colors, 1), 1);
dis_hu = sum((vec_hu-vec_hus).^2, 2);
dis_color = sum((vec_color-vec_colors).^2, 2);
% 按比例加权整合
rate = 0.1;
dis = rate*mat2gray(dis_hu) + (1-rate)*mat2gray(dis_color);
% 排序，将相似的，差异度小的，排在前面
[~, ind_dis_sort] = sort(dis);