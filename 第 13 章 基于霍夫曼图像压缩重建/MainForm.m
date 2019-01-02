function varargout = MainForm(varargin)
% MAINFORM MATLAB code for MainForm.fig
%      MAINFORM, by itself, creates a new MAINFORM or raises the existing
%      singleton*.
%
%      H = MAINFORM returns the handle to a new MAINFORM or the handle to
%      the existing singleton*.
%
%      MAINFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFORM.M with the given input arguments.
%
%      MAINFORM('Property','Value',...) creates a new MAINFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainForm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainForm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainForm

% Last Modified by GUIDE v2.5 19-May-2012 11:20:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainForm_OpeningFcn, ...
    'gui_OutputFcn',  @MainForm_OutputFcn, ...
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


% --- Executes just before MainForm is made visible.
function MainForm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainForm (see VARARGIN)

% Choose default command line output for MainForm
handles.output = hObject;
clc;
% axis(handles.axes1); cla reset; box on;
% set(gca, 'XTickLabel', '', 'YTickLabel', '');
%
% axis(handles.axes2); cla reset; box on;
% set(gca, 'XTickLabel', '', 'YTickLabel', '');
handles.Img = 0;
handles.ImgH = 0;
handles.ImgL = 0;
handles.strH = 0;
handles.strL = 0;
InitFig(hObject,handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainForm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainForm_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打开
warning off all;
% 载入图像
[FileName,PathName,FilterIndex] = uigetfile({'*.bmp;*.jpg;*.tif;*.png;*.gif', ...
    '所有图像文件';...
    '*.*','所有文件' },'载入图像',...
    '.\images\\lena.bmp');
if isequal(FileName, 0) || isequal(PathName, 0)
    return;
end
InitFig(hObject, handles);
Img = imread(fullfile(PathName, FileName));
axes(handles.axes1);
imshow(Img, []);
handles.Img = Img;
handles.ImgH = 0;
handles.ImgL = 0;
guidata(hObject, handles);


function textInfo_Callback(hObject, eventdata, handles)
% hObject    handle to textInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textInfo as text
%        str2double(get(hObject,'String')) returns contents of textInfo as a double


% --- Executes during object creation, after setting all properties.
function textInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function SnapImg_Callback(hObject, eventdata, handles)
% hObject    handle to SnapImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 截图
SnapImage();

% --------------------------------------------------------------------
function SaveImg_Callback(hObject, eventdata, handles)
% hObject    handle to SaveImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 保存
if isequal(handles.ImgH, 0) && isequal(handles.ImgL, 0)
    msgbox('请进行压缩处理！', '提示信息');
    return;
end
if ~isequal(handles.ImgH, 0)
    SaveImage(handles.ImgH);
end
if ~isequal(handles.ImgL, 0)
    SaveImage(handles.ImgL);
end
msgbox('处理结果保存成功！', '提示信息');

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();


% --------------------------------------------------------------------
function CompressAlgorithm_Callback(hObject, eventdata, handles)
% hObject    handle to CompressAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Huffman_Callback(hObject, eventdata, handles)
% hObject    handle to Huffman (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Img, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end
if isequal(handles.ImgH, 0)
    dataImg = handles.Img;
    if ndims(dataImg) == 3
        dataImg = rgb2gray(dataImg);
    end
    sz = size(dataImg);
    [zipped,info] = Mat2Huff(dataImg);
    unzipped = Huff2Mat(zipped, info);
    dataImg = double(reshape(dataImg, sz));
    unzipped = double(reshape(unzipped, sz));
    info_dataImg = whos('dataImg');
    info_zipped = whos('zipped');
    info_unzipped = whos('unzipped');
    S = PSNR(dataImg, unzipped);
    str0 = sprintf('-----------------霍夫曼压缩-----------------\n');
    str1 = sprintf('原始数据维数为：%s，占用空间大小为：%d\n', num2str(info_dataImg.size), info_dataImg.bytes);
    str2 = sprintf('解压数据维数为：%s，占用空间大小为：%d\n', num2str(info_unzipped.size), info_unzipped.bytes);
    str3 = sprintf('压缩数据维数为：%s，占用空间大小为：%d\n', num2str(info_zipped.size), info_zipped.bytes);
    str4 = sprintf('压缩比为：%.3f%%\n', info_zipped.bytes/info_dataImg.bytes*100);
    str5 = sprintf('PSNR：%.3f\n', S);
    strH = [str0 str1 str2 str3 str4 str5];
    set(handles.textInfo, 'String', strH);
    tm = im2uint8(mat2gray(unzipped));
    axes(handles.axes2); imshow(tm, []);
    handles.strH = strH;
    handles.ImgH = tm;
    guidata(hObject, handles);
else
    set(handles.textInfo, 'String', handles.strH);
    axes(handles.axes2); imshow(mat2gray(handles.ImgH), []);
end


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function HisteqContrast_Callback(hObject, eventdata, handles)
% hObject    handle to HisteqContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 直方图对比
if isequal(handles.ImgH, 0) && isequal(handles.ImgL, 0)
    msgbox('请进行压缩处理！', '提示信息');
    return;
end
if ~isequal(handles.ImgH, 0)
    HisteqContrast(handles.Img, handles.ImgH);
end
if ~isequal(handles.ImgL, 0)
    HisteqContrast(handles.Img, handles.ImgL);
end

% --------------------------------------------------------------------
function AlgorithmFlow_Callback(hObject, eventdata, handles)
% hObject    handle to AlgorithmFlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = '图像压缩系统，首先载入图像，然后选择压缩算法，比较压缩效果，最后可以观察直方图对比效果。';
msgbox(str, '提示信息');

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('图像压缩系统，采用霍夫曼算法', '提示信息');
