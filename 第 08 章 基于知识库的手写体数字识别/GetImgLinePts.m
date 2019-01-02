function num = GetImgLinePts(bw, v)

num = 0;
for i = 1 : size(v, 1)
    if v(i, 2)>1 && v(i, 2)<size(bw,1) && v(i, 1)>1 && v(i, 1)<size(bw,2) && bw(v(i, 2), v(i, 1))==1
        num = num + 1;
    end
end
