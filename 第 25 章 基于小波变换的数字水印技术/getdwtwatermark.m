function [Wg,nc]=getdwtwatermark(Iw,W,ntimes,rngseed,flag)
[mW,nW]=size(W);
if mW~=nW
    error('GETDWTWATERMARK:ARNOLD','ARNOLD置乱要求水印图像长宽必须相等！')
end
Iw=double(Iw);
W=logical(W);
ca1w=dwt2(Iw,'haar');
ca2w=dwt2(ca1w,'haar');
Wa=W;
rng(rngseed);
idx=randperm(numel(ca2w),numel(Wa));
for i=1:numel(Wa)
    c=ca2w(idx(i));
    z=mod(c,nW);
    if z<nW/2
        Wa(i)=0;
    else
        Wa(i)=1;
    end
end
Wg=Wa;
H=[2 -1;-1,1]^ntimes;
for i=1:nW
    for j=1:nW
        idx=mod(H*[i-1;j-1],nW)+1;
        Wg(idx(1),idx(2))=Wa(i,j);
    end
end
nc=sum(Wg(:).*W(:))/sqrt(sum(Wg(:).^2))/sqrt(sum(W(:).^2));
if flag
    figure('Name','数字水印提取结果')
    subplot(121)
    imshow(W)
    title('原始水印')
    subplot(122)
    imshow(Wg)
    title(['提取水印，NC=',num2str(nc)]);
end