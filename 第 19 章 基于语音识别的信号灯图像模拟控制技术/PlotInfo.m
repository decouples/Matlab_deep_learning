function PlotInfo(gh, k)

t = linspace(0, 2*pi);
xt = cos(t);
yt = sin(t);
axes(gh); 
h = fill(xt, yt, k);
set(h, 'EdgeColor', k);
axis off; 
axis equal;