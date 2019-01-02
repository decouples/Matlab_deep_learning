function varargout=harris(I,k,q,h)
narginchk(0,4);
nargoutchk(0,2);
if nargin<1
    I=checkerboard(50,2,2);
end
if nargin<2
    k=0.04;
end
if nargin<3
    q=0.01;
end
if nargin<3
    h=fspecial('gaussian',[5 5],1.5);
end
fx=[-2,-1,0,1,2];
Ix=filter2(fx,I);
fy=[-2,-1,0,1,2]';
Iy=filter2(fy,I);
Ix2=filter2(h,Ix.^2);
Iy2=filter2(h,Iy.^2);
Ixy=filter2(h,Ix.*Iy);
rfcn=@(a,b,c)(a*b-c^2)-k*(a+b)^2;
R=arrayfun(rfcn,Ix2,Iy2,Ixy);
R(R < q*max(R(:)))=0;
[xp,yp]=find(imregionalmax(R,8));
if nargout==0
    subplot(121)
    imshow(I);
    hold on;
    plot(xp,yp,'ro');
    title('自己编写HARRIS算法')
    subplot(122)
    cp=corner(I);
    imshow(I)
    hold on
    plot(cp(:,1),cp(:,2),'ro');
    title('MATLAB自带CORNER函数')
elseif nargout==1
    varargout={[xp,yp]};
elseif nargout==2
    varargout={xp,yp};
end
