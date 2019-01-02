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

% Last Modified by GUIDE v2.5 20-Apr-2011 14:40:49

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
clc;
axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
set(handles.text1, 'string', '');
handles.output = hObject;
handles.file = [];
handles.Plate = [];
handles.bw = [];
handles.words = [];
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
          'Result\result.jpg');
if isempty(filename)
    return;
end
file = fullfile(pathname, filename);
f = getframe(gcf);
f = frame2im(f);
imwrite(f, file);
msgbox('保存结果图像成功！', '提示信息', 'modal'); 


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 载入车牌图像
set(handles.text_result, 'string', '');
axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
set(handles.text1, 'string', '');
handles.file = [];
handles.Plate = [];
handles.bw = [];
handles.words = [];

[filename, pathname, filterindex] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' }, '选择待处理图像', ...
    'images\car.jpg');
if filename == 0
    return;
end
file = fullfile(pathname, filename); 
Img = imread(file); 
[y, ~, ~] = size(Img); 
if y > 800
    rate = 800/y;
    Img1 = imresize(Img, rate);
else
    Img1 = Img;
end
axes(handles.axes1);
imshow(Img1); title('原图像', 'FontWeight', 'Bold');
handles.Img = Img;
handles.file = file;
guidata(hObject, handles);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.file)
    msgbox('请载入待检测图像', '提示信息', 'modal'); 
    return;
end
[Plate, ~, Loc] = Pre_Process(handles.Img, [], 0); 
axes(handles.axes1); hold on;
row = Loc.row;
col = Loc.col;
plot([col(1) col(2)], [row(1) row(1)], 'g-', 'LineWidth', 3);
plot([col(1) col(2)], [row(2) row(2)], 'g-', 'LineWidth', 3);
plot([col(1) col(1)], [row(1) row(2)], 'g-', 'LineWidth', 3);
plot([col(2) col(2)], [row(1) row(2)], 'g-', 'LineWidth', 3);
hold off;
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
imshow(Plate, []); title('车牌区域图像', 'FontWeight', 'Bold');
handles.Plate = Plate;
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
if isempty(handles.Plate)
    msgbox('请先进行车牌区域标定操作！', '提示信息', 'modal'); 
    return;
end
bw = Plate_Process(handles.Plate, 0);
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
imshow(bw, []); title('车牌区域二值图像', 'FontWeight', 'Bold');
handles.bw = bw;
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.bw)
    msgbox('请先进行车牌区域二值化操作！', '提示信息', 'modal'); 
    return;
end
bw = Segmation(handles.bw);
words = Main_Process(bw, 0); 
axes(handles.axes4); cla reset; box on; set(gca, 'XTickLabel', [], 'YTickLabel', []);
words_display = [words.word1 words.word2 words.word3 ...
    words.word4 words.word5 words.word6 words.word7];
imshow(words_display, []); title('车牌字符图像', 'FontWeight', 'Bold');
handles.words = words;
guidata(hObject, handles);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.words)
    msgbox('请先进行车牌区域字符分割操作！', '提示信息', 'modal'); 
    return;
end
str = Pattern_Recognition(handles.words);
set(handles.text_result, 'string', str);
