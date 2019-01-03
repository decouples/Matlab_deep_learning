function MC = GetFeather(file, flag)
if nargin < 2
    flag = 0;
end
if nargin < 1
    file = '.\wav\Database\¹Ø±Õ\¹Ø±Õ_bsm.wav';
end
[signal, fs] = audioread(file);
framelength = 1024;
framenumber = fix(length(signal)/framelength);
for L = 1:framenumber;
    for m = 1:framelength;
        framedata(m) = signal((L-1)*framelength+m);
    end
    E(L) = sum(framedata.^2);
end
if flag
    figure; plot(E);
end
meanE = mean(E);
startflag=0;
startnum=0;
startframe=0;
endframe = 0;
S = [];
for L = 1 : framenumber
    if E(L) > meanE
        startnum = startnum+1;
        if startnum == 2
            startframe = L-2;
            startflag = 1;
        end
    end
    if E(L) < meanE
        if startflag == 1
            endframe = L-1;
            S = [S; startframe endframe];
            startflag = 0;
            startnum = 0;
        end
    end
end
if size(S, 1) > 1
    ms = min(S(:, 1));
    es = max(S(:, 2));
else
    ms = S(1);
    es = S(2);
end

MC = [];
snum = 1;
for i = ms : es
    si = (i-1)*framelength;
    ei = i*framelength;
    fi = signal(si:ei);
    mc = mfcc(fi,fs);
    MC{snum} = mc;
    snum = snum + 1;
end