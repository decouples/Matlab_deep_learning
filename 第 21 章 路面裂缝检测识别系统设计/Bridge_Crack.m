function bwn = Bridge_Crack(bw)
[row, col] = size(bw); 
[L, num] = bwlabel(bw); 
bwn = bw; 
if num < 2
    return;
end
stats = regionprops(L, 'BoundingBox');
for i = 1 : num
    l(i) = round(stats(i).BoundingBox(1) + 0.5);
    b(i) = round(stats(i).BoundingBox(2) - 0.5);
    r(i) = round(stats(i).BoundingBox(1) + stats(i).BoundingBox(3) - 1.5);
    rb(i) = round(stats(i).BoundingBox(2) + stats(i).BoundingBox(4));
end
l(l<=0) = 1;
b(b<=0) = 1;
r(r>=col) = col;
rb(rb>=row) = row;
try
    for i = 1 : num-1
        for j = b(i) : rb(i)
            if bw(j, r(i)) ~= 0
                break;
            end
        end
        for k = b(i+1) : rb(i+1)
            if bw(k, l(i+1)) ~= 0
                break;
            end
        end
        Yi = l(i+1); Ya = r(i);
        Xi=  k; Xa = j;
        d = Yi - Ya;
        e = Xa - Xi;
        if e>0
            if (d>e) || (d==e);
                for p = 1 : e
                    bw(j-p, r(i)+p) = 1;
                    bw(j-p-1, r(i)+p) = 1;
                    bw(j-p+1, r(i)+p) = 1;
                end
                for q = e+1 : d-1
                    bw(j-e, r(i)+q) = 1;
                    bw(j-e-1, r(i)+q) = 1;
                    bw(j-e+1, r(i)+q) = 1;
                end
            end
            if d<e
                for p = 1:d
                    bw(j-p, r(i)+d) = 1;
                    bw(j-p-1, r(i)+d) = 1;
                    bw(j-p+1, r(i)+d) = 1;
                end
                for q = d+1 : e-1
                    bw(j-q, r(i)+d) = 1;
                    bw(j-q, r(i)+d-1) = 1;
                    bw(j-q, r(i)+d+1) = 1;
                end
            end
            if d == 0;
                for p = 1 : e
                    bw(j-p, r(i)) = 1;
                    bw(j-p, r(i)-1) = 1;
                    bw(j-p, r(i)+1) = 1;
                end
            end
        end
        if e < 0
            e = abs(e);
            if (d>e) || (d==e)
                for p = 1:e;
                    bw(j+p, r(i)+p) = 1;
                    bw(j+p-1, r(i)+p) = 1;
                    bw(j+p+1, r(i)+p) = 1;
                end
                for q = e+1 : d-1
                    bw(j+e, r(i)+q) = 1;
                    bw(j+e-1, r(i)+q) = 1;
                    bw(j+e+1, r(i)+q) = 1;
                end
            end
            if d < e
                for p = 1 : d
                    bw(j+p, r(i)+p) = 1;
                    bw(j+p-1, r(i)+p) = 1;
                    bw(j+p+1, r(i)+p) = 1;
                end
                for q = d+1 : e-1
                    bw(j+q, r(i)+d) = 1;
                    bw(j+q, r(i)+d-1) = 1;
                    bw(j+q, r(i)+d+1) = 1;
                end
            end
            if d == 0
                for p = 1:e
                    bw(j+p, r(i)) = 1;
                    bw(j+p, r(i)-1) = 1;
                    bw(j+p, r(i)+1) = 1;
                end
            end
        end
        if e == 0
            for p = 1 : d
                bw(j, r(i)+p) = 1;
                bw(j-1, r(i)+p) = 1;
                bw(j+1, r(i)+p) = 1;
            end
        end
        if d<0
            for p = min(Xa, Xi) : max(Xa, Xi)
                for q = min(Ya, Yi) : max(Ya, Yi)
                    bw(p, q) = 1;
                end
            end
        end
    end
catch
    bwn = bw;
    return;
end
bwn = bw;
