function [cf_vec, dim_vec] = wavedec_process(x, num, wave_name)

if ndims(x) == 3
    x = rgb2gray(x);
end
[lf, hf] = wfilters(wave_name, 'd');
o = x;
x = double(x);
cf_vec = [];
dim_vec = size(x);
for i = 1 : num
    [ya, yv, yh, yd] = dwt2_process(x, lf, hf);
    tmp = {yv; yh; yd};
    dim_vec = [size(yv); dim_vec];
    cf_vec=[tmp; cf_vec];
    x = ya;
end
cf_vec = [ya; cf_vec];
figure; imshow(o, []); title('Ô­Í¼Ïñ');
plot_wave_coef(cf_vec);
plot_wave_coef_join(cf_vec, dim_vec);