function [flag, rect] = Judge_Direction(bw)
[L, num] = bwlabel(bw); 
stats = regionprops(bw, 'Area', 'BoundingBox');
Area = cat(1, stats.Area); 
[Area, ind] = sort(Area, 'descend'); 
if num == 1
    rect = stats.BoundingBox;
else
    rect1 = stats(ind(1)).BoundingBox;
    rect2 = stats(ind(2)).BoundingBox;
    s1 = [rect1(1); rect2(1)];
    s2 = [rect1(2); rect2(2)];    
    s = [min(s1) min(s2) rect1(3)+rect2(3) rect1(4)+rect2(4)];
    rect = s;
end
rate = rect(3)/rect(4); 
if rate > 1
    flag = 1;
else
    flag = 2; 
end