function diff_fab = usim(fa, f)
diff_fab = 0;
N = length(f);
for i = 1 : N
    fb = f{i};
    diff_ab = usimole(fa, fb);
    diff_fab = diff_fab + diff_ab;
end