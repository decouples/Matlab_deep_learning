function [x, y] = CheckRC(x, y, im)
y = max(y, 1);
y = min(y, size(im, 1));
x = max(x, 1);
x = min(x, size(im, 2));