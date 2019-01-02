function [Ipca,ratio,contribution]=pcaimage(I,pset,block)
if nargin<1
    I=imread('football.jpg');
end
if nargin<2
    pset=3;
end
if nargin<3
    block=[16 16];
end
if ndims(I)==3
    I=rgb2gray(I);
end
X=im2col(double(I),block,'distinct')';
[n,p]=size(X);
m=min(pset,p);
[coeff,score,contribution]=pcasample(X,m);
X=score*coeff';
Ipca=cast(col2im(X',block,size(I),'distinct'),class(I));
ratio=n*p/(n*m+p*m);
