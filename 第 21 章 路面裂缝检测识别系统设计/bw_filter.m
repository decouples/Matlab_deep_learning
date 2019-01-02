function bwn = bw_filter(bw, keepnum)
if nargin < 2
    keepnum = 15;
end
[L, num] = bwlabel(bw, 8); 
Ln = zeros(1, num);
stats = regionprops(L, 'Area'); 
Ln = cat(1, stats.Area);
[Ln, ind] = sort(Ln);
if num>keepnum || num==keepnum
    for i = 1 : num-keepnum
        bw(L == ind(i)) = 0;
    end
end
bwn = bw;
