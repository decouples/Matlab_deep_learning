function I1 = Pre_Process(I)

if ndims(I) == 3
    I = rgb2gray(I);
end
hsize = [3 3];
sigma = 0.5;
h = fspecial('gaussian', hsize, sigma);
I = imfilter(I, h, 'replicate');
r = 112; c = 98;
I1 = imresize(I, [r, c], 'bilinear');
