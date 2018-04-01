clc;clear all;close all;
filename = fullfile(pwd,'02.jpg');
Img = imread(filename);
%灰度化
if ndims(Img) ==3
    I = rgb2gray(Img);
else
    I = Img;
end
%添加噪声
Ig = imnoise(I,'poisson');
%获取算子
s = GetStrelList();
%串联去噪
e = ErodeList(Ig,s);
%计算权重
f = GetRateList(Ig,e);
%并联
Igo = GetRemoveResult(f,e);
%显示结果
figure;
subplot(121);imshow(I,[]);title('原始图');
subplot(122);imshow(Ig,[]);title('噪声图像');
figure;
subplot(221);imshow(e.eroded_co12,[]);title('串联1处理结果');
subplot(222);imshow(e.eroded_co22,[]);title('串联2处理结果');
subplot(223);imshow(e.eroded_co32,[]);title('串联3处理结果');
subplot(224);imshow(e.eroded_co42,[]);title('串联4处理结果');
figure;
subplot(121);imshow(Ig,[]);title('噪声图像');
subplot(122);imshow(Igo,[]);title('并联去噪图像');
%计算PSNR值
psnr1 = PSNR(I,e.eroded_co12);
psnr2 = PSNR(I,e.eroded_co22);
psnr3 = PSNR(I,e.eroded_co32);
psnr4 = PSNR(I,e.eroded_co42);
psnr5 = PSNR(I,Igo);
psnr_list = [psnr1 psnr2 psnr3 psnr4 psnr5];
figure;
plot(1:5,psnr_list,'r+-');%这里有点错误，长度不匹配
axis([0 6 18 24]);
set(gca,'XTick',0:6,'XTickLabel',{'','串联1','串联2','串联3','串联4','并联',''});
grid on;
title('PSNR曲线比较');


