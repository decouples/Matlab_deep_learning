function [bw, th] = IterProcess(Img)
if ndims(Img) == 3
    I = rgb2gray(Img);
else
    I = Img;
end

T0 = (double(max(I(:))) + double(min(I(:))))/2;
flag = 1; 

while flag
    ind1 = I > T0; 
    ind2 = ~ind1;
    T1 = (mean(double(I(ind1))) + mean(double(I(ind2))))/2;
    flag = abs(T1-T0) > 0.5;
    T0 = T1; 
end
bw = ind1;
th = T1;