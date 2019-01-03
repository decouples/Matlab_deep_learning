function MainForm
global bw;
global bl;
global bll;
global s;
global fontSize;
global charpic;
global hMainFig;
global pic;
global hText;

clc; close all; warning off all;
if ~exist(fullfile(pwd, 'pic'), 'dir')
    mkdir(fullfile(pwd, 'pic'));
end
picname = fullfile(pwd, 'image.jpg');
pic = imread(picname);
s = size(pic);
if length(s) == 3
    pic = rgb2gray(pic);
end
bw = im2bw(pic, 0.7);
bw = ~bw;
for i = 1 : s(1)
    if sum(bw(i,:) ~=0) > 0
        FontSize_s = i;
        break;
    end
end
for i = FontSize_s : s(1)
    if sum(bw(i,:) ~=0) == 0
        FontSize_e = i;
        break;
    end
end
FontSizeT = FontSize_e - FontSize_s;
fontName = 'ËÎÌו';
fontSize = FontSizeT;
bw1 = imclose(bw, strel('line', 4, 90));
bw2 = bwareaopen(bw1, 20);
bwi2 = bwselect(bw2, 368, 483, 4);
bw2(bwi2) = 0;
bw3 = bw .* bw2;
bw4 = imclose(bw3, strel('square', 4));
[Lbw4, numbw4] = bwlabel(bw4);
stats = regionprops(Lbw4);
for i = 1 : numbw4
    tempBound = stats(i).BoundingBox;
    tempPic = imcrop(pic, tempBound);
    tempStr = fullfile(pwd, sprintf('pic\\%03d.jpg', i));
    imwrite(tempPic, tempStr);
end
[bl, num] = bwlabel(bw1, 4);
chars = [char(uint8('A'):uint8('Z')), uint8('a'):uint8('z'), uint8('0'):uint8('9')];
eleLen = length(chars);
charpic = cell(1,eleLen);
hf1 = figure('Visible', 'Off');
imshow(zeros(32,32));
h = text(15, 15, 'a', 'Color', 'w', 'Fontname', fontName, 'FontSize', fontSize);
for p = 1 : eleLen
    set(h, 'String', chars(p));
    fh = getframe(hf1, [85, 58, 30, 30]);
    temp = fh.cdata;
    temp = im2bw(temp, 0.2);
    [r, c] = find(temp == 0);
    rect = [min(c) min(r) max(c)-min(c) max(r)-min(r)];
    temp = imcrop(temp, rect);
    [f1, f2] = find(temp == 1);
    sz = size(temp);
    temp = temp(max(1, min(f1)-1):min(max(f1)+1, sz(1)),max(1, min(f2)-1):min(max(f2)+1, sz(2)));
    charpic{p} = temp;
end
delete(hf1);
bll = zeros(size(bl));
for i = 1:num
    [f1, f2] = find(bl == i);
    bll(min(f1):max(f1), min(f2):max(f2)) = i;
end
hMainFig = figure(1);
imshow(picname, 'Border', 'loose'); hold on;
for i = 1 : numbw4
    tempBound = stats(i).BoundingBox;
    rectangle('Position', tempBound, 'EdgeColor', 'r');
end
hText = axes('Units', 'Normalized', 'Position', [0 0 0.1 0.1]); axis off;
set(hMainFig, 'WindowButtonMotionFcn', @ShowPointData);
end

function ShowPointData(hObject, eventdata, handles)
global bw;
global bl;
global bll;
global s;
global charpic;
global hMainFig;
global pic;
global hText;

p = get(gca,'currentpoint');
x = p(3);
y = p(1);
if x<1 || x>s(1) || y<1 || y>s(2)
    return;
end
curlabel = bll(uint32(x), uint32(y));
if curlabel ~= 0
    [f1, f2] = find(bl == curlabel);
    minx = min(f1);
    maxx = max(f1);
    miny = min(f2);
    maxy = max(f2);
    tempic = pic(minx:maxx, miny:maxy);
    temp = bw(minx:maxx, miny:maxy);
    tempIm = zeros(round(size(temp)*2)); tempIm = logical(tempIm);
    tempIm(round((size(tempIm, 1)-size(temp, 1))/2):round((size(tempIm, 1)-size(temp, 1))/2)+size(temp, 1)-1, ...
        round((size(tempIm, 2)-size(temp, 2))/2):round((size(tempIm, 2)-size(temp, 2))/2)+size(temp, 2)-1) = temp;
    set(0, 'CurrentFigure', hMainFig);
    imshow(tempIm, [], 'Parent', hText);
    mincost = 100000;
    mark = 1;
    for i = 1 : length(charpic)
        temp1 = charpic{i};
        ss = size(temp);
        temp1 = imresize(temp1, ss);
        % tempcost = sum(sum(abs(temp - temp1)));
        tempcost = norm(temp - temp1);
        if tempcost < mincost
            mincost = tempcost;
            mark = i;
        end
    end
end
end