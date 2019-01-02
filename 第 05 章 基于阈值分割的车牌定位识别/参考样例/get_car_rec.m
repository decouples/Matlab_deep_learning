function res = get_car_rec(Img)
if nargin < 1
    Img = imread(fullfile(pwd, 'images/京NU9K26.jpg'));
end
I_gray=rgb2gray(Img);                       %对图像I进行灰度处理
I_edge=edge(I_gray,'sobel');              %利用Sobel算子进行边缘检测
se=[1;1;1];
I_erode=imerode(I_edge,se);             %对边缘图像进行腐蚀
se=strel('rectangle',[25,25]);
I_close=imclose(I_erode,se);             %填充图像
I_final=bwareaopen(I_close,1500);        %去除聚团灰度值小于1500的部分
I_new=zeros(size(I_final,1),size(I_final,2));
location_of_1=[];
for i=1:size(I_final,1)                      %寻找二值图像中白的点的位置
    for j=1:size(I_final,2)
        if I_final(i,j)==1;
            newlocation=[i,j];
            location_of_1=[location_of_1;newlocation];
        end
    end
end
mini=inf;maxi=0;
for i=1:size(location_of_1,1)    %寻找所有白点中，x坐标与y坐标的和最大，最小的两个点的位置
    temp=location_of_1(i,1)+location_of_1(i,2);
    if temp<mini
        mini=temp;
        a=i;
    end
    if temp>maxi
        maxi=temp;
        b=i;
    end
end
first_point=location_of_1(a,:);             %和最小的点为车牌的左上角
last_point=location_of_1(b,:);             %和最大的点为车牌的右下角
x1=first_point(1)+10;                      %坐标值修正
x2=last_point(1)-4;
y1=first_point(2)+10;
y2=last_point(2)-4;
I_plate=Img(x1:x2,y1:y2);
g_max=double(max(max(I_plate)));
g_min=double(min(min(I_plate)));
T=round(g_max-(g_max-g_min)/3);         % T 为二值化的阈值
I_plate =im2bw (I_plate,T/256);
I_plate=bwareaopen(I_plate,20);
I_plate(: ,y2)=0;
I_plate=bwareaopen(I_plate,100);
X=[];                               %用来存放水平分割线的横坐标
z=0;
flag=0;

for j=1:size(I_plate,2)
    sum_y=sum(I_plate(:,j));
    if logical(sum_y)~=flag          %列和有变化时，记录下此列
        if(j-z>10)
            X=[X j];
            flag=logical(sum_y);
            z=j;                        %用z记录上一个j的值，防止两个列坐标间隔太小
        end
    end
    
end

for n=1:7
    res=I_plate(:,X(2*n-1):X(2*n)-1);     %进行粗分割
    for i=1:size(res,1)                  %这两个for循环对分割字符的上下进行裁剪
        if sum(res(i,:))~=0
            top=i;
            break
        end
    end
    for i=1:size(res,1)
        if sum(res(size(res,1)-i,:))~=0
            bottom=size(res,1)-i;
            break
        end
    end
    res=res(top:bottom,:);
    
    %      subplot(2,4,n);imshow(char);
    res=imresize(res,[40,20],'nearest');    %归一化为40*20的大小，以便模板匹配
    imgchar{n}=res;
    % eval(strcat('Char_',num2str(n),'=char;'));  %将分割的字符放入Char_i中
end

res=[];
store1=strcat('贵','豫','粤','湘','鄂','皖','鲁','藏','京','苏','黑','吉','冀','晋','辽','浙','津','闽','云','陕','琼');  %创建汉字识别模板库
for j=1:21
    Im=imgchar{1};
    Template=imread(strcat('车牌汉字库\',num2str(j),'.jpg'));
    Template=im2bw(Template);
    Differ=Im-Template;
    Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
res=[res store1(index)];
store2=strcat('A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9'); %创建字母与数字识别模板库
for i=2:7
    for j=1:34
        Im=imgchar{i};
        Template=imread(strcat('车牌字符库\',num2str(j),'.jpg'));
        Template=im2bw(Template);
        Differ=Im-Template;
        Compare(j)=sum(sum(abs(Differ)));
    end
    index=find(Compare==(min(Compare)));
    res=[res store2(index)];
end
