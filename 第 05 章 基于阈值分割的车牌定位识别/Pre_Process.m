function [Plate, bw, Loc] = Pre_Process(Img, parm, flag)

if nargin < 1
    Img = imread(fullfile(pwd, 'images/car.jpg'));
end
if nargin < 2 || isempty(parm)
    if size(Img, 2) > 900
        parm = [0.35 0.9 90 0.35 0.7 90 2];
    end
    if size(Img, 2) > 700 && size(Img, 2) < 900
        parm = [0.6 0.9 90 0.6 0.8 90 0.5];
    end
    if size(Img, 2) > 500 && size(Img, 2) < 700
        parm = [0.5 0.54 50 0.6 0.7 50 3];
    end
    if size(Img, 2) < 500
        parm = [0.8 0.9 150 0.8 0.9 150 3];
    end
end
if nargin < 3
    flag = 1;
end
I = Img;
[y, ~, ~] = size(I); 
if y > 800
    rate = 800/y;
    I = imresize(I, rate);
end
[y, x, ~] = size(I); 

myI = double(I); 
bw1 = zeros(y, x);
bw2 = zeros(y, x);
Blue_y = zeros(y, 1);
for i = 1 : y
    for j = 1 : x
        rij = myI(i, j, 1)/(myI(i, j, 3)+eps);
        gij = myI(i, j, 2)/(myI(i, j, 3)+eps);
        bij = myI(i, j, 3);
        if (rij < parm(1) && gij < parm(2) && bij > parm(3)) ...
                || (gij < parm(1) && rij < parm(2) && bij > parm(3))
            Blue_y(i, 1) = Blue_y(i, 1) + 1; 
            bw1(i, j) = 1;
        end
    end
end

[~, MaxY] = max(Blue_y);
Th = parm(7);
PY1 = MaxY;
while ((Blue_y(PY1,1)>Th) && (PY1>1))
    PY1 = PY1 - 1;
end
PY2 = MaxY;
while ((Blue_y(PY2,1)>Th) && (PY2<y))
    PY2 = PY2 + 1;
end
PY1 = PY1 - 2;
PY2 = PY2 + 2;
if PY1 < 1
    PY1 = 1;
end
if PY2 > y
    PY2 = y;
end
IY = I(PY1:PY2, :, :);

Blue_x = zeros(1,x);
for j = 1:x
    for i = PY1:PY2
        rij = myI(i, j, 1)/(myI(i, j, 3)+eps);
        gij = myI(i, j, 2)/(myI(i, j, 3)+eps);
        bij = myI(i, j, 3);
        if (rij < parm(4) && gij < parm(5) && bij > parm(6)) ...
                || (gij < parm(4) && rij < parm(5) && bij > parm(6))
            Blue_x(1,j) = Blue_x(1,j) + 1; 
            bw2(i, j) = 1;
        end
    end
end

PX1 = 1;
while (Blue_x(1,PX1)<Th) && (PX1<x)
    PX1 = PX1 + 1;
end
PX2 = x;
while (Blue_x(1,PX2)<Th) && (PX2>PX1)
    PX2 = PX2 - 1;
end
PX1 = PX1 - 2;
PX2 = PX2 + 2;
if PX1 < 1
    PX1 = 1;
end
if PX2 > x
    PX2 = x;
end

IX = I(:, PX1:PX2, :);
Plate = I(PY1:PY2, PX1:PX2, :);
Loc.row = [PY1 PY2];
Loc.col = [PX1 PX2];
bw = bw1 + bw2;
bw = logical(bw);
bw(1:PY1, :) = 0;
bw(PY2:end, :) = 0;
bw(:, 1:PX1) = 0;
bw(:, PX2:end) = 0;
if flag
    figure;       
    subplot(2, 2, 3); imshow(IY); title('行过滤结果', 'FontWeight', 'Bold');
    subplot(2, 2, 1); imshow(IX); title('列过滤结果', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(I); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imshow(Plate); title('分割结果', 'FontWeight', 'Bold');
end

