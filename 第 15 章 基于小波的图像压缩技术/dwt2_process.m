function [ya, yv, yh, yd] = dwt2_process(x, lf, hf)
x = double(x);
for i = 1 : size(x, 1)
    [ya, yd] = dwt_process(x(i,:), lf, hf, 1);
    xt1(i, :) = [ya, yd];
end

for j = 1 : size(xt1, 2)
    [ya, yd] = dwt_process(xt1(:, j), lf, hf, 1);
    xt2(:, j) = [ya; yd];
end

[r, c] = size(xt2);
rm = round(r/2);
cm = round(c/2);
ya = xt2(1:rm, 1:cm);
yv = xt2(1:rm, cm+1:c);
yh = xt2(rm+1:r, 1:cm);
yd = xt2(rm+1:r, cm+1:c);