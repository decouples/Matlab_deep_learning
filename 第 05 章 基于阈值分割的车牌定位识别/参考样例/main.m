function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 31-May-2016 17:38:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @main_OpeningFcn, ...
    'gui_OutputFcn',  @main_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;
clc; warning off all;
axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes5); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes6); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes7); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes8); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes9); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes10); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes11); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes12); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes13); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes14); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes15); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
set(handles.edit1, 'string', []);
handles.Img=[];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes5); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes6); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes7); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes8); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes9); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes10); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes11); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes12); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes13); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes14); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes15); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
set(handles.edit1, 'string', []);
set(handles.edit2, 'string', []);

[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif', 'All Image Files';...
    '*.*', '所有文件' }, '选择图像文件', fullfile(pwd, 'images/川F1A666.jpg'));

if filename == 0
    return;
end
% 文件名
file = fullfile(pathname, filename);
% 图像矩阵
Img = imread(file);
%激活第一个轴对象
axes(handles.axes1);
imshow(Img, []);
%激活第二个轴对象
axes(handles.axes2);
imshow(Img, []);
%保存为全局变量
handles.Img = Img;
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img=handles.Img;
%对图像I进行灰度处理
I_gray=rgb2gray(Img);
axes(handles.axes3);
imshow(I_gray);
title('灰度图像');
%利用Sobel算子进行边缘检测
I_edge=edge(I_gray,'sobel');
axes(handles.axes4);
imshow(I_edge)
title('边缘检测后图像');
se=[1;1;1];
%对边缘图像进行腐蚀
I_erode=imerode(I_edge,se);
axes(handles.axes5);
imshow(I_erode);
title('腐蚀后边缘图像');
se=strel('rectangle',[25,25]);
%填充图像
I_close=imclose(I_erode,se);
axes(handles.axes6);
imshow(I_close)
title('填充后图像');
%去除聚团灰度值小于1500的部分
I_final=bwareaopen(I_close,1500);
axes(handles.axes7);
imshow(I_final);
title('形态滤波后图像');

I_new=zeros(size(I_final,1),size(I_final,2));
location_of_1=[];
%寻找二值图像中白的点的位置
for i=1:size(I_final,1)
    for j=1:size(I_final,2)
        if I_final(i,j)==1;
            newlocation=[i,j];
            location_of_1=[location_of_1;newlocation];
        end
    end
end
mini=inf;maxi=0;
%寻找所有白点中，x坐标与y坐标的和最大，最小的两个点的位置
for i=1:size(location_of_1,1)
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
%和最小的点为车牌的左上角
first_point=location_of_1(a,:);
%和最大的点为车牌的右下角
last_point=location_of_1(b,:);
%坐标值修正
x1=first_point(1)+10;
x2=last_point(1)-4;
y1=first_point(2)+10;
y2=last_point(2)-4;
I_plate=Img(x1:x2,y1:y2);
g_max=double(max(max(I_plate)));
g_min=double(min(min(I_plate)));
% T为二值化的阈值
T=round(g_max-(g_max-g_min)/3);
I_plate =im2bw (I_plate,T/256);
I_plate=bwareaopen(I_plate,20);
I_plate(: ,y2)=0;
axes(handles.axes8);
I_plate=bwareaopen(I_plate,100);
%画出最终车牌
imshow(I_plate)
title('车牌提取')


%用来存放水平分割线的横坐标
X=[];
z=0;
flag=0;

for j=1:size(I_plate,2)
    sum_y=sum(I_plate(:,j));
    %列和有变化时，记录下此列
    if logical(sum_y)~=flag
        if(j-z>10)
            X=[X j];
            flag=logical(sum_y);
            %用z记录上一个j的值，防止两个列坐标间隔太小
            z=j;
        end
    end
    
end

for n=1:7
    %进行粗分割
    char=I_plate(:,X(2*n-1):X(2*n)-1);
    %这两个for循环对分割字符的上下进行裁剪
    for i=1:size(char,1)
        if sum(char(i,:))~=0
            top=i;
            break
        end
    end
    for i=1:size(char,1)
        if sum(char(size(char,1)-i,:))~=0
            bottom=size(char,1)-i;
            break
        end
    end
    char=char(top:bottom,:);
    %归一化为40*20的大小，以便模板匹配
    char=imresize(char,[40,20],'nearest');
    segchar(n,:,:)=char(:,:);
    %将分割的字符放入Char_i中
    eval(strcat('Char_',num2str(n),'=char;'));
end
axes(handles.axes9);
imgchar(:,:)=segchar(1,:,:);
imshow(imgchar)
axes(handles.axes10);
imgchar(:,:)=segchar(2,:,:);
imshow(imgchar)
axes(handles.axes11);
imgchar(:,:)=segchar(3,:,:);
imshow(imgchar)
axes(handles.axes12);
imgchar(:,:)=segchar(4,:,:);
imshow(imgchar)
axes(handles.axes13);
imgchar(:,:)=segchar(5,:,:);
imshow(imgchar)
axes(handles.axes14);
imgchar(:,:)=segchar(6,:,:);
imshow(imgchar)
axes(handles.axes15);
imgchar(:,:)=segchar(7,:,:);
imshow(imgchar)
char=[];
store1=strcat('贵','豫','粤','湘','鄂','皖','鲁','藏','京','苏','黑','吉','冀','晋','辽','浙','津','闽','云','陕','琼');  %创建汉字识别模板库
for j=1:21
    Im=Char_1;
    Template=imread(strcat('车牌汉字库\',num2str(j),'.jpg'));
    Template=im2bw(Template);
    Differ=Im-Template;
    Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
char=[char store1(index)];
store2=strcat('A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9'); %创建字母与数字识别模板库
for i=2:7
    for j=1:34
        Im=eval(strcat('Char_',num2str(i)));
        Template=imread(strcat('车牌字符库\',num2str(j),'.jpg'));
        Template=im2bw(Template);
        Differ=Im-Template;
        Compare(j)=sum(sum(abs(Differ)));
    end
    index=find(Compare==(min(Compare)));
    char=[char store2(index)];
end
set(handles.edit1, 'string', strcat('车牌为:',char), 'FontWeight', 'Bold', 'FontSize', 12, 'ForegroundColor', [1 0 0]);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
filename_list = ls(fullfile(pwd, 'images', '*.jpg'));
N = size(filename_list, 1);
err = 0;
% 进度条
h = waitbar(0, '', 'Name', '识别率 ...');
for i = 1 : N
    % 图片
    filenamei = fullfile(fullfile(pwd, 'images',  strtrim(filename_list(i, :))));
    [~, name, ~] = fileparts(filenamei);
    Img = imread(filenamei);
    res = '';
    try
        % 识别
        res = get_car_rec(Img);
    catch e
        disp(e);
    end
    if ~isequal(res, name)
        % 如果识别结果与名称不同
        err = err + 1;
        % 打印结果
        fprintf('\n原名称：%s，识别结果：%s，错误\n', name, res);
    else
        % 打印结果
        fprintf('\n原名称：%s，识别结果：%s，正确\n', name, res);
    end
    
    % 进度条显示
    waitbar(i/N, h, sprintf('已处理：%d%%', round(i/N*100)));
end
% 关闭进度条
close(h)
rate = (1 - err/N)*100;
str = sprintf('%.2f%%', rate);
set(handles.edit2, 'string', str, 'FontWeight', 'Bold', 'FontSize', 12, 'ForegroundColor', [1 0 0]);


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
