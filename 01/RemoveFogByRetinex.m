function In = RemoveFogByRetinex(f,flag)
%用Retinex的MSR实现图像去雾
%f 图像矩阵；flag 显示矩阵；In 结果图像
%
if nargin<2
    flag=1;
end
%提取RGB分量
fr = f(:,:,1);
fg = f(:,:,2);
fb = f(:,:,3);
%数据类型归一化
mr = mat2gray(im2double(fr));
mg = mat2gray(im2double(fg));
mb = mat2gray(im2double(fb));
%定义alph参数
alpha = 1200;
%定义模板大小
n1 = floor((n+1)/2);
for i =1:n
    for j=1:n
        b(i,j) = exp(-((i-n1)^2+(j-n1)^2)/(4*alpha))/(pi*alpha);
    end
end
%卷积滤波
nr1 = imfilter(mr,b,'conv','replicate');
ng1 = imfilter(mg,b,'conv','replicate');
nb1 = imfilter(mb,b,'conv','replicate');
ur1 = log(nr1);
ug1 = log(ng1);
ub1 = log(nb1);
tr1 = log(mr);
tg1 = log(mg);
tb1 = log(mb);
yr1 = (tr1-ur1)/3;
yg1 = (tg1-ug1)/3;
yb1 = (tb1-ub1)/3;

%定义beta参数
beta = 55;
%定义模板大小
x = 32;
%计算中心
x1 = floor((n+1)/2);
for i=1:n
    for j=1:n
        %高斯函数
        a(i,j) = exp(-((i-n1)^2+(j-n1)^2)/(4*beta))/(6*pi*beta);
    end
end
%卷积滤波
nr2 = imfilter(mr,a,'conv','replicate');
ng2 = imfilter(mg,a,'conv','replicate');
nb2 = imfilter(mg,a,'conv','replicate');
ur2 = log(nr2);ug2 = log(ng2);ub2 = log(nb2);
tr2 = log(mr);tg2 = log(mg);tb2 = log(mb);
yr2 = (tr2-ur2)/3;yg2 = (tg2-ug2)/3;yb2 = (tb2-ub2)/3;
%定义eta参数
eta = 13944.5;
%定义模板大小
l = 500;
%计算中心
l1 = floor((n+1)/2);
for i = 1:n
    for j = 1:n
        %高斯函数
        e(i,j) = exp(-((i-n1)^2+(j-n1)^2)/(4*beta))/(4*pi*beta);
    end
end
%卷积滤波
nr3 = imfilter(mr,e,'conv','replicate');
ng3 = imfilter(mg,e,'conv','replicate');
nb3 = imfilter(mb,e,'conv','replicate');
ur3 = log(nr3);ug3 = log(ng3);ub3 = log(nb3);
tr3 = log(mr);tg3 = log(mg);tb3 = log(mb);
yr3 = (tr3-ur3)/3;yg3 = (tg3-ug3)/3;yb3 = (tb3-ub3)/3;
dr = yr1+yr2+yr3;
dg = yg1+yg2+yg3;
db = yb1+yb2+yb3;
cr =im2uint8(dr);
cg =im2uint8(dg);
cb =im2uint8(db);
%集成处理后得到的结果
In = cat(3,cr,cg,cb);
%结果显示
if flag
    figure;
    subplot(221);imshow(f);title('原图像','FontWeight','Bold');
    subplot(222);imshow(In);title('处理后的图像','FontWeight','Bold');
    %灰度化，用于计算直方图
    Q = rgb2gray(f);
    M = rgb2gray(In);
    subplot(223);imhist(Q,64);title('原始灰度直方图','FontWeight','Bold');
    subplot(224);imhist(M,64);title('处理后的灰度直方图','FontWeight','Bold');
end

