clc; clear all; close all;
I = imread('IMG00016.jpg');
bw = im2bw(I, graythresh(I));
figure; 
subplot(1, 2, 1); imshow(I, []); title('Ô­Í¼Ïñ');
subplot(1, 2, 2); imshow(bw, []); title('ãÐÖµ·Ö¸îÍ¼Ïñ');