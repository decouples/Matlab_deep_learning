function plot_wave_coef_join(cf_vec,dim_vec)
dn = 3;
num = (length(cf_vec)-1)/dn;
tmpa = wkeep(cf_vec{1}, dim_vec(1, :), 'c');
tmpa = im2uint8(mat2gray(tmpa));
tmpa(1, :) = 255; tmpa(end, :) = 255;
tmpa(:, 1) = 255; tmpa(:, end) = 255;
for j = 1:num
    tmpv = wkeep(cf_vec{(j-1)*dn+2}, dim_vec(j, :), 'c');
    tmph = wkeep(cf_vec{(j-1)*dn+3}, dim_vec(j, :), 'c');
    tmpd = wkeep(cf_vec{(j-1)*dn+4}, dim_vec(j, :), 'c');
    tmpv = im2uint8(mat2gray(tmpv));
    tmph = im2uint8(mat2gray(tmph));
    tmpd = im2uint8(mat2gray(tmpd));
    tmpv(1, :) = 255; tmpv(end, :) = 255;
    tmpv(:, 1) = 255; tmpv(:, end) = 255;
    tmph(1, :) = 255; tmph(end, :) = 255;
    tmph(:, 1) = 255; tmph(:, end) = 255;
    tmpd(1, :) = 255; tmpd(end, :) = 255;
    tmpd(:, 1) = 255; tmpd(:, end) = 255;    
    tmp = [tmpa,tmpv;tmph,tmpd];
    stc = size(tmp);
    if stc >= dim_vec(j+1, :)
        tmpa = tmp(1:dim_vec(j+1, 1), 1:dim_vec(j+1,2));
    else
        tmp = tmp([1:end-1, end-2:end-1], [1:end-1, end-2:end-1]);
        tmpa = tmp(1:dim_vec(j+1, 1), 1:dim_vec(j+1,2));
    end
    tmpa = im2uint8(mat2gray(tmpa));
    tmpa(1, :) = 255; tmpa(end, :) = 255;
    tmpa(:, 1) = 255; tmpa(:, end) = 255;
end
figure;
imshow(tmpa, []);
title('小波系数塔式图');
