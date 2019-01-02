function y = downsample_prcoess(x)
N = 1:length(x);
Nx = downsample(N, 2);
N(Nx) = [];
y = x(N);