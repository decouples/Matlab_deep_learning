function f = GetRateList(Ig, e)

f.df1 = sum(sum(abs(double(e.eroded_co12)-double(Ig))));
f.df2 = sum(sum(abs(double(e.eroded_co22)-double(Ig))));
f.df3 = sum(sum(abs(double(e.eroded_co32)-double(Ig))));
f.df4 = sum(sum(abs(double(e.eroded_co42)-double(Ig))));
f.df = sum([f.df1 f.df2 f.df3 f.df4]);