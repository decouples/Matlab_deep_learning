function S = PSNR(s,t)
%计算PSNR
% s 图像矩阵1；t 图像矩阵2； s 输出结果
%预处理
[m,n,~] = size(s);
s = im2uint8(mat2gray(s));
t = im2uint8(mat2gray(t));
s = double(s);
t = double(t);
%初始值
sd = 0;
mi = m*n*max(max(s.^2));
%计算
for u = 1:m
    for v = 1:n
        sd = sd+(s(u,v)-t(u,v))^2;
    end
end
if sd == 0;
    sd =1;
end
S = mi/sd;
S = 10*log10(s);
