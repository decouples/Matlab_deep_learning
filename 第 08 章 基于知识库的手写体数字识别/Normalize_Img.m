function I1 = Normalize_Img(I)

if ndims(I) == 3
    I = rgb2gray(I);
end
I1 = imresize(I, [24 24], 'bicubic');