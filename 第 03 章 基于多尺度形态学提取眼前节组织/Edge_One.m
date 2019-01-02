function Gf = Edge_One(G, u)
if nargin < 2
    u = rand(1, length(G));
    u = u/sum(u(:));
end
Gf = zeros(size(G{1})); 
for i = 1 : length(G)
    Gf = Gf + u(i)*double(G{i});
end
Gf = im2uint8(mat2gray(Gf)); 