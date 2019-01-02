function bw = Bw_Img(I)

if ndims(I) == 3
    I = rgb2gray(I);
end
bw = im2bw(I, graythresh(I));
bw = ~bw;