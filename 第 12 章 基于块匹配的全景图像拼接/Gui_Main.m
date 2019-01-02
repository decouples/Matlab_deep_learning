function varargout = Gui_Main(varargin)
% GUI_MAIN MATLAB code for Gui_Main.fig
%      GUI_MAIN, by itself, creates a new GUI_MAIN or raises the existing
%      singleton*.
%
%      H = GUI_MAIN returns the handle to a new GUI_MAIN or the handle to
%      the existing singleton*.
%
%      GUI_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MAIN.M with the given input arguments.
%
%      GUI_MAIN('Property','Value',...) creates a new GUI_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui_Main

% Last Modified by GUIDE v2.5 27-Apr-2011 09:29:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Gui_Main_OpeningFcn, ...
    'gui_OutputFcn',  @Gui_Main_OutputFcn, ...
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


% --- Executes just before Gui_Main is made visible.
function Gui_Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui_Main (see VARARGIN)

% Choose default command line output for Gui_Main
clc; warning off all;
axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);

handles.output = hObject;
handles.file = [];
handles.MStitch = [];
handles.grayResult = [];
handles.RGBResult = [];
handles.grayListResult = [];
handles.RGBListResult = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui_Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui_Main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' }, '保存结果', ...
    'Result\result_gui.jpg');
if isempty(filename)
    return;
end
file = fullfile(pathname, filename);
f = getframe(gcf);
f = frame2im(f);
imwrite(f, file);
msgbox('保存GUI结果图像成功！', '提示信息', 'modal');


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);

handles.file = [];
handles.MStitch = [];
handles.grayResult = [];
handles.RGBResult = [];
handles.grayListResult = [];
handles.RGBListResult = [];

[filename, pathname, filterindex] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.bmp','All Image Files';...
    '*.*','All Files' }, '选择待处理图像', ...
    '.\\images\\', 'MultiSelect', 'on');
if ~isa(filename, 'cell') && isequal(filename, 0)
    return;
end

file = File_Process(filename, pathname);
if length(file) < 2
    msgbox('请选择至少两幅图像！', '提示信息', 'modal');
    return;
end
Img1 = imread(file{1});
Img2 = ImageList(file);
axes(handles.axes1);
imshow(Img1); title('图像序列1', 'FontWeight', 'Bold');
axes(handles.axes2);
imshow(Img2); title('图像序列2', 'FontWeight', 'Bold');

handles.Img1 = Img1;
handles.Img2 = Img2;
handles.file = file;
guidata(hObject, handles);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);

handles.file = [];
handles.MStitch = [];
handles.grayResult = [];
handles.RGBResult = [];

dname = uigetdir('.\\images\\风景图像', '请选择待处理图像文件夹：');
if dname == 0
    return;
end
df = ls(dname);
if length(df) > 2
    for i = 1 : size(df, 1)
        if strfind(df(i, :), '.db');
            df(i, :) = [];
            break;
        end
    end
    if length(df) > 2
        filename = fullfile(dname, df(end, :));
        pathname = [dname '\'];
    else
        msgbox('请选择至少两幅图像！', '提示信息', 'modal');
        return;
    end
else
    msgbox('请选择至少两幅图像！', '提示信息', 'modal');
    return;
end
file = File_Process(filename, pathname);
if length(file) < 2
    msgbox('请选择至少两幅图像！', '提示信息', 'modal');
    return;
end
Img1 = imread(file{1}); 
Img2 = ImageList(file); 
axes(handles.axes1);
imshow(Img1); title('图像序列1', 'FontWeight', 'Bold');
axes(handles.axes2);
imshow(Img2); title('图像序列2', 'FontWeight', 'Bold');

handles.Img1 = Img1;
handles.Img2 = Img2;
handles.file = file;
guidata(hObject, handles);



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.file)
    msgbox('请先载入图像！', '提示信息', 'modal');
    return;
end
if isempty(handles.MStitch)
    msgbox('请先进行图像匹配！', '提示信息', 'modal');
    return;
end
if ~isempty(handles.grayResult)
    msgbox('灰度拼接图像已完成！', '提示信息', 'modal');
    return;
end
if length(handles.file)
    [MStitch, result] = GrayMain_Process(handles.MStitch, ...
        handles.W_box, handles.H_box, handles.bdown);
end
grayResult = im2uint8(mat2gray(result));
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
imshow(grayResult, []);
title('灰度图像拼接结果', 'FontWeight', 'Bold');

handles.grayResult = grayResult;
guidata(hObject, handles);

msgbox('灰度拼接图像完成！', '提示信息', 'modal');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.file)
    msgbox('请先载入图像！', '提示信息', 'modal');
    return;
end
if isempty(handles.MStitch)
    msgbox('请先进行图像匹配！', '提示信息', 'modal');
    return;
end
if ~isempty(handles.RGBResult)
    msgbox('彩色拼接图像已完成！', '提示信息', 'modal');
    return;
end

if length(handles.file)
    [MStitch, result] = RGBMain_Process(handles.MStitch, ...
        handles.W_box, handles.H_box, handles.bdown);
end
RGBResult = im2uint8(mat2gray(result));
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
imshow(RGBResult, []);
title('彩色图像拼接结果', 'FontWeight', 'Bold');

handles.RGBResult = RGBResult;
guidata(hObject, handles);

msgbox('彩色拼接图像完成！', '提示信息', 'modal');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.grayResult) && isempty(handles.RGBResult)
    msgbox('请先拼接处理图像！', '提示信息', 'modal');
    return;
end

if ~isempty(handles.grayResult)
    figure(1); imshow(handles.grayResult, []);
    title('灰度图像拼接结果', 'FontWeight', 'Bold');
end
if ~isempty(handles.RGBResult)
    figure(2); imshow(handles.RGBResult, []);
    title('彩色图像拼接结果', 'FontWeight', 'Bold');
end
if ~isempty(handles.grayListResult)
    figure(3); imshow(handles.grayListResult, []);
    title('序列灰度图像拼接结果', 'FontWeight', 'Bold');
end
if ~isempty(handles.RGBListResult)
    figure(4); imshow(handles.RGBListResult, []);
    title('序列彩色图像拼接结果', 'FontWeight', 'Bold');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.grayResult) && isempty(handles.RGBResult)
    msgbox('请先拼接处理图像！', '提示信息', 'modal');
    return;
end
[filename, pathname] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' }, '保存结果', ...
    'Result\result.jpg');
if isempty(filename)
    return;
end
[pathstr, name, ext] = fileparts(filename);

if ~isempty(handles.grayResult)
    file = fullfile(pathname, [name, '_gray', ext]);
    imwrite(handles.grayResult, file);
end
if ~isempty(handles.RGBResult)
    file = fullfile(pathname, [name, '_rgb', ext]);
    imwrite(handles.RGBResult, file);
end
if ~isempty(handles.grayListResult)
    file = fullfile(pathname, [name, '_grayList', ext]);
    imwrite(handles.grayListResult, file);
end
if ~isempty(handles.RGBListResult)
    file = fullfile(pathname, [name, '_rgbList', ext]);
    imwrite(handles.RGBListResult, file);
end

msgbox('保存拼接图像成功！', '提示信息', 'modal');

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.file)
    msgbox('请先载入图像！', '提示信息', 'modal');
    return;
end
if ~isempty(handles.MStitch)
    msgbox('图像匹配已完成！', '提示信息', 'modal');
    return;
end

file = handles.file;
im1 = imread(file{1});
MStitch.imrgb1 = double(im1); 
im1 = rgb2gray(im1);
MStitch.im1 = double(im1); 
[Pheight, Pwidth] = size(im1);
MStitch.Pwidth = Pwidth; 
MStitch.Pheight = Pheight; 
MStitch.W_min = round(0.60*Pwidth);
MStitch.W_max = round(0.83*Pwidth); 
MStitch.H_min = round(0.98*Pheight); 
MStitch.minval = 255;
im2 = imread(file{2});
MStitch.imrgb2 = double(im2);
im2 = rgb2gray(im2);
im2 = double(im2);
MStitch.im2 = double(im2);
[W_box, H_box, bdown, MStitch] = Fun_Match(im2, MStitch);
msgbox('图像匹配完成！', '提示信息', 'modal');
handles.W_box = W_box;
handles.H_box = H_box;
handles.bdown = bdown;
handles.MStitch = MStitch;
guidata(hObject, handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('您确定要退出图像拼接系统？', ...
    '退出选项', ...
    '退出', '取消', '取消');
switch choice
    case '退出'
        close all;
    case '取消'
        return;
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.file)
    msgbox('请先载入图像！', '提示信息', 'modal');
    return;
end
if ~isempty(handles.grayListResult)
    msgbox('序列灰度图像拼接已完成！', '提示信息', 'modal');
    return;
end

if length(handles.file) == 2
    if ~isempty(handles.grayResult)
        msgbox('灰度拼接图像已完成！', '提示信息', 'modal');
        return;
    end
    if isempty(handles.MStitch)
        msgbox('请先进行图像匹配！', '提示信息', 'modal');
        return;
    end
    [MStitch, result] = GrayMain_Process(handles.MStitch, ...
        handles.W_box, handles.H_box, handles.bdown);
    grayResult = im2uint8(mat2gray(result));
    axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
    imshow(grayResult, []);
    title('灰度图像拼接结果', 'FontWeight', 'Bold');
    
    handles.grayResult = grayResult;
    guidata(hObject, handles);
    
    msgbox('灰度拼接图像完成！', '提示信息', 'modal');
else
    [MStitch, result] = GrayListMain_Process(handles.file);
    grayListResult = im2uint8(mat2gray(result));
    axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
    imshow(grayListResult, []);
    title('序列灰度图像拼接结果', 'FontWeight', 'Bold');
    
    handles.grayListResult = grayListResult;
    guidata(hObject, handles);
    
    msgbox('序列灰度拼接图像完成！', '提示信息', 'modal');
end



% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.file)
    msgbox('请先载入图像！', '提示信息', 'modal');
    return;
end
if ~isempty(handles.RGBListResult)
    msgbox('序列彩色图像拼接已完成！', '提示信息', 'modal');
    return;
end

if length(handles.file) == 2
    if ~isempty(handles.RGBResult)
        msgbox('彩色拼接图像已完成！', '提示信息', 'modal');
        return;
    end
    if isempty(handles.MStitch)
        msgbox('请先进行图像匹配！', '提示信息', 'modal');
        return;
    end
    [MStitch, result] = RGBMain_Process(handles.MStitch, ...
        handles.W_box, handles.H_box, handles.bdown);
    RGBResult = im2uint8(mat2gray(result));
    axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
    imshow(RGBResult, []);
    title('彩色图像拼接结果', 'FontWeight', 'Bold');
    
    handles.grayResult = grayResult;
    guidata(hObject, handles);
    
    msgbox('彩色拼接图像完成！', '提示信息', 'modal');
else
    [MStitch, result] = RGBListMain_Process(handles.file);
    RGBListResult = im2uint8(mat2gray(result));
    axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
    imshow(RGBListResult, []);
    title('序列彩色图像拼接结果', 'FontWeight', 'Bold');
    
    handles.RGBListResult = RGBListResult;
    guidata(hObject, handles);
    
    msgbox('序列彩色拼接图像完成！', '提示信息', 'modal');
end
