clc; clear all; close all;
I = checkerboard(50,3,3);
h = fspecial('gaussian',[5 5],2);
harris(I,0.05,0.01,h);
