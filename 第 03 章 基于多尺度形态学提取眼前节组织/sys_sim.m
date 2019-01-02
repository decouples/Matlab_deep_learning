function supo = sys_sim(fa, f)
supo = 0;
N = length(f); 
for i = 1 : N
    fb = f{i}; 
    supo = supo + norm(double(fa(:)-fb(:)));
end