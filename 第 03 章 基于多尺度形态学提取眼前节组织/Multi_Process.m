function [Gi, ng] = Multi_Process(I, g, n)

if nargin < 3
    n = 6;
end
ng = g;
for i = 1:n
    ng = imdilate(ng, g);
end

Gi1 = imopen(I, ng); 
Gi1 = imdilate(Gi1, ng);
Gi2 = imclose(I, ng); 
Gi2 = imerode(Gi2, ng);
Gi = imsubtract(Gi1, Gi2); 