function Result = Process_Main(I)
if ndims(I) == 3
    I1 = rgb2gray(I);
else
    I1 = I;
end
I2 = hist_con(I1);
I3 = med_process(I2);
I4 = adjgamma(I3, 2);
[bw, th] = IterProcess(I4);
bw = ~bw;
bwn1 = bw_filter(bw, 15);
bwn2 = Identify_Object(bwn1);
[projectr, projectc] = Project(bwn2);
[r, c] = size(bwn2);
bwn3 = Judge_Crack(bwn2, I4);
bwn4 = Bridge_Crack(bwn3);
[flag, rect] = Judge_Direction(bwn4);
if flag == 1
    str = '∫·œÚ¡—∑Ï';
    wdmax = max(projectc);
    wdmin = min(projectc);
else
    str = '◊›œÚ¡—∑Ï';
    wdmax = max(projectr);
    wdmin = min(projectr);
end
Result.Image = I1; 
Result.hist = I2; 
Result.Medfilt = I3; 
Result.Enance = I4;
Result.Bw = bw; 
Result.BwFilter = bwn1; 
Result.CrackRec = bwn2;
Result.Projectr = projectr;
Result.Projectc = projectc;
Result.CrackJudge = bwn3;
Result.CrackBridge = bwn4; 
Result.str = str;
Result.rect = rect;
Result.BwEnd = bwn4; 
Result.BwArea = bwarea(bwn4); 
Result.BwLength = max(rect(3:4));
Result.BwWidthMax = wdmax; 
Result.BwWidthMin = wdmin; 
Result.BwTh = th; 