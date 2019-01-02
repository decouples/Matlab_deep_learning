function plot_wave_coef(cf_vec)
dn = 3;
num = (length(cf_vec)-1)/dn;
figure;
subplot(num+1, 3, 2);
yt = im2uint8(mat2gray(cf_vec{1}));
imshow(yt, []); 
title(sprintf('近似分量A_{%d}', num));
info = {'垂直细节V', '水平细节H', '对角线细节D'};
ps = 2;   
for i = 1 : num
    for j = 1 : dn
        yt = im2uint8(mat2gray(cf_vec{ps}));
        subplot(num+1, dn, ps+2);
        imshow(yt, []);
        title(sprintf('%s_{%d}', info{j}, num-i+1));
        ps = ps+1;
    end
end