function Watershed_Fun(fileName)

rgb = imread(fileName);
if ndims(rgb) == 3
    I = rgb2gray(rgb);
else    
    I = rgb;
end
sz = size(I);
if sz(1) ~= 256
    I = imresize(I, 256/sz(1));
    rgb = imresize(rgb, 256/sz(1));
end
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
se = strel('disk', 3);
Io = imopen(I, se);
Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
Ioc = imclose(Io, se);
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fgm = imregionalmax(Iobrcbr);
se2 = strel(ones(3,3));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 15);
bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');

[pathstr, name, ext] = fileparts(fileName);
filefolder = fullfile(pwd, '实验结果', [name, '_实验截图']);
if ~exist(filefolder, 'dir')
    mkdir(filefolder);
end
h1 = figure(1);
set(h1, 'Name', '图像灰度化', 'NumberTitle', 'off');
subplot(1, 2, 1); imshow(rgb, []); title('原图像');
subplot(1, 2, 2); imshow(I, []); title('灰度图像');
fileurl = fullfile(filefolder, '1');
set(h1,'PaperPositionMode','auto');
print(h1,'-dtiff','-r200',fileurl);
h2 = figure(2);
set(h2, 'Name', '图像形态学操作', 'NumberTitle', 'off');
subplot(1, 2, 1); imshow(Iobrcbr, []); title('图像形态学操作');
subplot(1, 2, 2); imshow(bw, []); title('图像二值化');
fileurl = fullfile(filefolder, '2');
set(h2,'PaperPositionMode','auto');
print(h2,'-dtiff','-r200',fileurl);
h3 = figure(3);
set(h3, 'Name', '图像梯度显示', 'NumberTitle', 'off');
subplot(1, 2, 1); imshow(rgb, []); title('待处理图像');
subplot(1, 2, 2); imshow(gradmag, []); title('梯度图像');
fileurl = fullfile(filefolder, '3');
set(h3,'PaperPositionMode','auto');
print(h3,'-dtiff','-r200',fileurl);
h4 = figure(4); imshow(rgb, []); hold on;
himage = imshow(Lrgb);
set(h4, 'Name', '图像分水岭分割', 'NumberTitle', 'off');
set(himage, 'AlphaData', 0.3);
hold off;
fileurl = fullfile(filefolder, '4');
set(h4,'PaperPositionMode','auto');
print(h4,'-dtiff','-r200',fileurl);