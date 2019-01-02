function Inversef = supoles(fa, f)
Inversef = 0;
N = length(f);
for i = 1 : N
    fb = f{i};
    diff_fab = usim(fa, f);
    Inversef = Inversef + diff_fab;
end