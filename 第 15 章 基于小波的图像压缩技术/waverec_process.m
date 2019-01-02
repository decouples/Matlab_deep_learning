function x = waverec_process(cf_vec, dim_vec, wave_name, th)

if nargin < 4
    th = 10;
end
[lf, hf] = wfilters(wave_name, 'r');
dn = 3;
num = (length(cf_vec)-1)/dn;
ya = cf_vec{1};
for i = 1 : num
    yv = cf_vec{(i-1)*3+2};
    yh = cf_vec{(i-1)*3+3};
    yd = cf_vec{(i-1)*3+4};
    yv(abs(yv)<th) = 0;
    yh(abs(yh)<th) = 0;
    yd(abs(yd)<th) = 0;
    ya = idwt2_process(ya, yv, yh, yd, lf, hf, dim_vec(i+1,:));
end
x = im2uint8(mat2gray(ya));
figure; imshow(x, []); title('ÖØ¹¹Í¼Ïñ');