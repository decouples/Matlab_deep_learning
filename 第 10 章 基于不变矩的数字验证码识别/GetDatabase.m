function GetDatabase()
files = dir(fullfile(pwd, 'images/*.jpg'));
for i = 0 : 9
    foldername = fullfile(pwd, sprintf('Databse/%d', i));
    if ~exist(foldername, 'dir')
        mkdir(foldername);
    end
end
h = waitbar(0,'正在处理，请等待...', 'Name', '生成模板库');
steps = length(files);

for fi = 1 : length(files)
    filename = fullfile(pwd, sprintf('images/%s', files(fi).name));
    [pathstr, name, ext] = fileparts(filename);
    name = name(1:4);
    Img = imread(filename);   
    hsv = rgb2hsv(Img);
    h = hsv(:, :, 1);
    s = hsv(:, :, 2);
    v = hsv(:, :, 3);
    bw1 = h > 0.16 & h < 0.30;
    bw2 = s > 0.65 & s < 0.80;
    bw = bw1 & bw2;
    Imgr = Img(:, :, 1);
    Imgg = Img(:, :, 2);
    Imgb = Img(:, :, 3);
    Imgr(bw) = 255;
    Imgg(bw) = 255;
    Imgb(bw) = 255;
    Imgbw = cat(3, Imgr, Imgg, Imgb);
    Ig = rgb2gray(Imgbw);
    Ibw = im2bw(Ig, 0.8);
    sz = size(Ibw);
    cs = sum(Ibw, 1);
    mincs = min(cs);
    maxcs = max(cs);
    masksize = 16;
    S1 = []; E1 = [];
    flag = 1;
    s1 = 1;
    tol = maxcs;
    
    while s1 < sz(2)
        for i = s1 : sz(2)
            s2 = i;
            if cs(s2) < tol && flag == 1
                flag = 2;
                S1 = [S1 s2-1];
                break;
            elseif cs(s2) >= tol && flag == 2
                flag = 1;
                E1 = [E1 s2];
                break;
            end
        end
        s1 = s2 + 1;
    end
    Ibw = ~Ibw;
    Ibw = bwmorph(Ibw, 'thin', inf);
    for i = 1 : length(S1)
        Ibwi = Ibw(:, S1(i):E1(i));
        [L, num] = bwlabel(Ibwi);
        stats = regionprops(L);
        Ar = cat(1, stats.Area);
        [maxAr, ind_maxAr] = max(Ar);
        recti = stats(ind_maxAr).BoundingBox;
        recti(1) = recti(1) + S1(i) - 1;
        recti(2) = recti(2);
        recti(3) = recti(3);
        recti(4) = recti(4);
        Ibwi = imcrop(Ibw, recti);
        rate = masksize/max(size(Ibwi));
        Ibwi = imresize(Ibwi, rate, 'bilinear');
        ti = zeros(masksize, masksize);
        rsti = round((size(ti, 1)-size(Ibwi, 1))/2);
        csti = round((size(ti, 2)-size(Ibwi, 2))/2);
        ti(rsti+1:rsti+size(Ibwi,1), csti+1:csti+size(Ibwi,2))=Ibwi;
        Ti{i} = ti;
    end
    for i = 1 : length(Ti)
        namei = name(i);
        outfilenamei = fullfile(pwd, sprintf('Databse/%s/%s_%d_%d.jpg', namei, namei, fi, i));
        imwrite(Ti{i}, outfilenamei);
    end
    fprintf('\n已处理%d------%d\n', fi, length(files));
    h = waitbar(fi / steps);
end
close(h) ;