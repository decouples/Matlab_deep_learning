function [num, MC] = Reco(S, file)
MC = GetFeather(file);
N = [];
h = waitbar(0, '', 'Name', '音频识别...');
steps = length(MC);
for i = 1 : length(MC)
    mc = MC{i};  
    mindis = [];
    for j = 1 : length(S)
        MCJ = S(j).MC;     
        disk = [];
        for k = 1 : length(MCJ)
            mck = MCJ{k};
            disk(k) = norm(mc-mck);
        end
        mindis = [mindis min(disk)];
    end
    [mind, indd] = min(mindis(:));
    N = [N indd];
    waitbar(i/steps, h, sprintf('已处理：%d%%', round(i/steps*100)));
end
close(h);
Ni = [];
for i = 1 : length(S)
    Ni(i) = numel(find(N == i));    
end
[maxNi, ind] = max(Ni);
num = ind;