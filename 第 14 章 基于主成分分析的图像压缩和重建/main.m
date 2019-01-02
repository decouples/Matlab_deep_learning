clc; clear all; close all;
I=imread('liftingbody.png');
k=1;
figure('Units', 'Normalized', 'Position', [0 0 1 1]);
for p=1:5:20
    [Ipca,ratio,contribution]=pcaimage(I,p,[24 24]);
    subplot(2,2,k);    
    imshow(Ipca)
    title(['主成分个数=',num2str(p),...
        ',压缩比=',num2str(ratio),...
        ',贡献率=',num2str(contribution)],'fontsize',14);
    k=k+1;
end
