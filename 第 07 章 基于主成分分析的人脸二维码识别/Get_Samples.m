function allsamples = Get_Samples(classNum, sampleNum)

if nargin < 1
    classNum = 40;
    sampleNum = 10;
end
allsamples = [];
for i = 1 : classNum
    for j = 1 : sampleNum
        a = imread(sprintf('ÈËÁ³¿â\\ORL%03d.BMP', (i-1)*sampleNum+j));
        [row, col] = size(a);
        b = a(1 : row*col);
        b = double(b);
        allsamples = [allsamples; b];
    end
end