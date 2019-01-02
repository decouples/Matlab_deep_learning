function dwtwatermarkattack(action,Iw,W,ntimes,rngseed)
switch lower(action)
    case 'filter'
        Ia=imfilter(Iw,ones(3)/9);
    case 'resize'
        Ia=imresize(Iw,0.5);
        Ia=imresize(Ia,2);
    case 'noise'
        Ia=imnoise(Iw,'salt & pepper',0.01);
    case 'crop'
        Ia=Iw;
        Ia(50:400,50:400)=randn();
    case 'rotate'
        Ia=imrotate(Iw,45,'nearest','crop');
        Ia=imrotate(Ia,-45,'nearest','crop');
end
[Wg,nc]=getdwtwatermark(Ia,W,ntimes,rngseed,0);
figure('Name',['数字水印 ',upper(action),' 攻击试验'],'Position',[287,108,943,557]);
subplot(221)
imshow(Iw)
title('嵌入水印图像')
subplot(222)
imshow(Ia)
title(['遭受 ',upper(action), ' 攻击'])
subplot(223)
imshow(W)
title('原始水印图像')
subplot(224)
imshow(Wg)
title(['提取水印，NC=',num2str(nc)]);