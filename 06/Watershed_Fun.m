function Watershed_Fun(fileName)
%入口函数
%fileName 图像文件名
rgb = imread(fileName);
if ndims(rgb) == 3
    I = rgb2gray(rgb);
else 
    I = rgb;
end
sz = size(I);
if sz(1) ~=256
    I = imresize(I,256/sz(1));
    rgb = imresize(rgb,256/sz(1));
end
%y 方向边缘提取算子
hy = fspecial('sobel');
%x 方向边缘提取算子
hx = hy';
% 提取y方向边缘
Iy = imfilter(double(I),hy,'replicate');
%提取X方向边缘
Ix = imfilter(double(I),hx,'replicate');
%计算梯度图像
gradmag = sqrt(Ix.^2+Iy.^2);
%形态学算子
se = strel('disk',3);
%开运算
Io = imopen(I,se);
%图像腐蚀
Ie = imerode(I,se);
%图像重建
Iobr = imreconstruct(Ie,I);
%闭运算
Ioc = imclose(Io,se);
%膨胀
Iobrd = imdilate(Iobr,se);
%图像重建
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
%图像求反
Iobrcbr = imcomplement(Iobrcbr);
%句柄极大操作
fgm = imregionalmax(Iobrcbr);
%形态学算子
se2 = strel(ones(3,3));
%闭操作
fgm2 = imclose(fgm,se2);
%腐蚀
fgm3 = imerode(fgm2,se2);
%面积开操作
fgm4 = bwareaopen(fgm3,15);
%二值化
bw = im2bw(Iobrcbr,graythresh(Iobrcbr));
%计算区域距离
D = bwdist(bw);
%分水岭
DL = watershed(D);
%过滤背景
bgm = DL == 0;
%处理背景
gradmag2 = imimposemin(gradmag,bgm|fgm4);
%分水岭
L =watershed(gradmag2);
%标记矩阵加颜色
Lrgb = label2rgb(L,'jet','w','shuffle');
[pathstr,name,ext] = fileparts(fileName);
%整合得到详细目录
filefolder = fullfile(pwd,'实验结果',[name,'_实验截图']);
%判断文件夹是否存在
if ~exist(filefolder,'dir')
    mkdir(filefolder);
end
%显示中间过程
h1 = figure(1);
set(h1,'Name','图像灰度化','NumberTitle','off');
subplot(121);imshow(rgb,[]);title('原图像');
subplot(122);imshow(I,[]);title('灰度图像');
fileurl = fullfile(filefolder,'1');
set(h1,'PaperPositionMode','auto');
print(h1,'-dtiff','-r200',fileurl);
h2 = figure(2);
set(h2,'Name','形态学操作','NumberTitle','off');
subplot(121);imshow(rgb,[]);title('原图像');
subplot(122);imshow(I,[]);title('灰度图像');
fuleurl = fullfile(filefolder,'2');
set(h2,'PaperPositionMode','auto');
print(h2,'-dtiff','-r200',fileurl);
h3 = figure(3);
set(h3,'Name','图像梯度显示','NumberTitle','off');
subplot(121);imshow(rgb,[]);title('待处理的图像');
subplot(122);imshow(gradmag,[]);title('梯度图像');
fileurl = fullfile(filefolder,'3');
set(h3,'PaperPositionMode','auto');
print(h3,'-dtiff','-r200',fileurl);
%显示结果
h4 = figure(4);imshow(rgb,[]);hold on;
himage = imshow(Lrgb);
set(h4,'Name','图像分水岭分割','NumberTitle','off');
%显示矩阵
set(himage,'AlphaData',0.3);
hold off;
fileurl = fullfile(filefolder,'4');
set(h4,'PaperPositionMode','auto');
print(h4,'-dtiff','-r200',fileurl);
