function y = upsample_prcoess(x)

y = upsample(x, 2, 1);
y = [y(:); 0];