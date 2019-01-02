function xmean = Get_StandSample(allsamples, samplemean)

for i = 1 : size(allsamples, 1)
    xmean(i, :) = allsamples(i, :) - samplemean;
end