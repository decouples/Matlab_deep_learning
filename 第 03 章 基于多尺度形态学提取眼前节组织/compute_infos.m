function H = compute_infos(I)
level = 256;
dat = double(I);
p = zeros(1, level);
for i = 1 : size(dat, 1)
    for j = 1 : size(dat, 2)
        temp = dat(i,j);
        p(1, temp+1) = p(1, temp+1) + 1;
    end
end
p = p/(size(dat, 1)*size(dat, 2));
H = 0; 
for i = 1 : level
    if p(i) ~= 0
        H = H + p(i)*log2(p(i));
    end
end
H = -H;