function [word, result] = Word_Segmation(d)

word = [];
flag = 0;
[m, n] = size(d);
wideTol = round(n/20); 
rateTol = 0.25; 
while flag == 0
    [m, n] = size(d);
    wide = 0;
    while sum(d(:,wide+1)) ~= 0 && wide <= n-2
        wide = wide + 1;
    end
    temp = Segmation(imcrop(d, [1 1 wide m]));
    [m1,n1] = size(temp);
    if wide<wideTol && n1/m1>rateTol
        d(:, 1:wide) = 0;
        if sum(sum(d)) ~= 0
            d = Segmation(d);  
        else
            word = [];
            flag = 1;
        end
    else
        word = Segmation(imcrop(d, [1 1 wide m]));
        d(:, 1:wide) = 0;
        if sum(sum(d)) ~= 0;
            d = Segmation(d);
            flag = 1;
        else
            d = [];
        end
    end
end
result = d;