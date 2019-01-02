function newim = adjgamma(im, g)
if nargin < 2
    g = 1;
end

if g <= 0
    error('Gamma参数必须大于0');
end
if ndims(im) == 3
    I = rgb2gray(im);
else
    I = im;
end
if isa(I,'uint8');
    newim = double(I);
else
    newim = I;
end
newim = newim-min(min(newim));
newim = newim./max(max(newim));
newim =  newim.^(1/g);  
