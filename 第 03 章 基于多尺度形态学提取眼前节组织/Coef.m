function ua = Coef(fa, f)
N = length(f);
s = [];
for i = 1 : N
    fi = f{i};
    si = supoles(fi, f);
    s = [s si];
end
sp = min(s(:));
sa = supoles(fa, f);
ka = sp/sa; 
k = 0;
for i = 1 : N
    fb = f{i};
    s = [];
    for i = 1 : N
        fi = f{i};
        si = supoles(fi, f);
        s = [s si];
    end
    sp = min(s);
    sb = supoles(fb, f);
    kb = sp/sa; 
    k = k + kb;
end
ua = ka/k; 