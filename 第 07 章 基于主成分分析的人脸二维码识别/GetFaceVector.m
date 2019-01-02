function c = GetFaceVector(img)

load(fullfile(pwd, '»À¡≥ø‚/model.mat'));
a = img;
[row, col] = size(a);
b=a(1:row*col); 
b=double(b);
b=b-samplemean;
c = b * base;
c = real(c);