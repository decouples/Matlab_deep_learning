function [Iw,psnr]=setdwtwatermark(I,W,ntimes,rngseed,flag)
type=class(I);
I=double(I);
W=logical(W);
[mI,nI]=size(I);
[mW,nW]=size(W);
if mW~=nW
    error('SETDWTWATERMARK:ARNOLD','ARNOLD置乱要求水印图像长宽必须相等！')
end
[ca1,ch1,cv1,cd1]=dwt2(I,'haar');
[ca2,ch2,cv2,cd2]=dwt2(ca1,'haar');

if flag
    figure('Name','载体小波分解')
    subplot(121)
    imagesc([wcodemat(ca1),wcodemat(ch1);wcodemat(cv1),wcodemat(cd1)])
    title('一级小波分解')
    subplot(122)
    imagesc([wcodemat(ca2),wcodemat(ch2);wcodemat(cv2),wcodemat(cd2)])
    title('二级小波分解')
end
Wa=W;
H=[1,1;1,2]^ntimes; 
for i=1:nW
    for j=1:nW
        idx=mod(H*[i-1;j-1],nW)+1;
        Wa(idx(1),idx(2))=W(i,j);
    end
end

if flag
    figure('Name','水印置乱效果')
    subplot(121)
    imshow(W)
    title('原始水印')
    subplot(122)
    imshow(Wa)
    title(['置乱水印，变换次数=',num2str(ntimes)]);
end
ca2w=ca2;
rng(rngseed);
idx=randperm(numel(ca2),numel(Wa));
for i=1:numel(Wa)
    c=ca2(idx(i));
    z=mod(c,nW);
    if Wa(i)
        if z<nW/4
            f=c-nW/4-z;
        else
            f=c+nW*3/4-z;
        end
    else 
        if z<nW*3/4
            f=c+nW/4-z;
        else
            f=c+nW*5/4-z;
        end
    end
    ca2w(idx(i))=f;
end
ca1w=idwt2(ca2w,ch2,cv2,cd2,'haar');
Iw=idwt2(ca1w,ch1,cv1,cd1,'haar');
Iw=Iw(1:mI,1:nI);
mn=numel(I);
Imax=max(I(:));
psnr=10*log10(mn*Imax^2/sum((I(:)-Iw(:)).^2));
I=cast(I,type);
Iw=cast(Iw,type);
if flag
    figure('Name','嵌入水印的图像')
    subplot(121)
    imshow(I);
    title('原始图像')
    subplot(122);
    imshow(Iw);
    title(['添加水印，PSNR=',num2str(psnr)]);
end