function ua = Coef(fa,f)
% 计算加权系数
% fa 图像矩阵； f 图像序列
% ua 加权系数
N = length(f);
s = [];
for i=1:N
    fi = f{i};
    si = spoles(fi,f);
    s = [s si];
end
sp = min(s(:));
sa = spoles(fa,f);
%计算ka
ka = sp/sa;
k = 0;
for i =1:N
    fb = f{i};
    s = [];
    for i = 1:N
        fi = f{i};
        si = spoles(fi,f);
        s = [s si];
    end
    sp = min(s);
    sb = spoles(fb,f);
    %计算kb
    kb = sp/sa;
    k = k+kb;
end
