function num = GetImgEndPts(bw)

num = 0;
for i = 1 : size(bw, 1)
    for j = 1 : size(bw, 2)
        if i>2 && i<size(bw,1)-2 && j>2 && j<size(bw,2)-2 ...
                && bw(i, j)==1 ...
                && sum(sum(bw(i-1:i+1, j-1:j+1)))==1
            num = num + 1;
        end
    end
end