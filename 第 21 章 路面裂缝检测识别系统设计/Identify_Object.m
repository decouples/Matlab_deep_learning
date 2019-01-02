function bwn = Identify_Object(bw, MinArea, MinRate)
if nargin < 3    
    MinRate = 3; 
end
if nargin < 2
    MinArea = 20;
end
[L, num] = bwlabel(bw); 
stats = regionprops(L, 'Area', 'MajorAxisLength', ...
    'MinorAxisLength'); 
Ap = cat(1, stats.Area);
Lp1 = cat(1, stats.MajorAxisLength);
Lp2 = cat(1, stats.MinorAxisLength); 
Lp = Lp1./Lp2; 
for i = 1 : num
    if Ap(i) < MinArea
        bw(L == i) = 0;
    end
end
MinRate = max(Lp)*0.4;
for i = 1 : num
    if Lp(i) < MinRate
        bw(L == i) = 0;
    end
end
bwn = bw;
