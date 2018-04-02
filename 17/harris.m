function varargout=harris(I,k,q,h)
% I,原始灰度图
% k = 敏感因子
% q = 质量水平
% h = 滤波权值

%输入输出参数检查
narginchk(0,4);
nargoutchk(0,2);

%灰度图像
if nargin<1
    I = checkerboard(50,2,2);
end
%敏感因子 k ,取值范围一般 0.04~0.06
if nargin<2
    k = 0.04;
end
%质量水平q ,当R<q*Rmax,不认为是角点
if nargin<3
    q = 0.01;
end
%高斯权值h,采用高斯平滑消除图像噪声
if nargin<3
    h = fspecial('gaussian',[5 5],1.5);
end

% 1 利用差分算子进行滤波求的Ix,Iy
fx = [-2,-1,0,1,2];
Ix = filter2(fx,I);
fy = [-2,-1,0,1,2];
Iy=filter2(fy,I);

% 2 高斯滤波平滑消除突出点，计算矩阵M
Ix2 = filter2(h,Ix.^2);
Iy2 = filter2(h,Iy.^2);
Ixy = filter2(h,Ix.*Iy);

% 计算每一个像素点的harris响应值
% m = [a,c,c,b];
%R = det(m)-k*(trace(m))^2;
% =(a*b-c^2)-k*(a+b)^2;
rfcn = @(a,b,c)(a*b-c^2)-k*(a+b)^2;
R = arrayfun(rfcn,Ix2,Iy2,Ixy);
%根据质量水平去掉响应值低的点
R(R<q*max(R(:)))=0;

%4 找出[8,8]邻域内最大响应值即为角点
[xp,yp] = find(imregionalmax(R,8));

%输出参数处理
if nargout == 0
    subplot(121);
    imshow(I)
    hold on
    plot(xp,yp,'ro');
    title('自己编写HARRIS');
    
    subplot(122);
    cp = corner(I);
    imshow(I)
    hold on
    plot(cp(:,1),cp(:,2),'ro');
    title('MATLAB自带CORNER函数');
elseif nargout ==1
    vargout={[xp,yp]};
elseif nargout ==2
    vargout={xp,yp};
end
