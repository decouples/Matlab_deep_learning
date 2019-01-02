clc
close all
I=imread('football.jpg');
I=double(I)/255;
subplot(2,3,1)
imshow(I)
title('原始图像')
for i=2:6
    F=imkmeans(I,i);
    subplot(2,3,i);
    imshow(F,[]);
    title(['聚类个数=',num2str(i)])
end