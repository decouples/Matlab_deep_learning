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

% Last Modified by GUIDE v2.5 22-Dec-2013 09:58:50

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
axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc; 
axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');
axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');
axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');
handles.file1 = [];
handles.file2 = [];
handles.result = [];
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif', 'All Image Files';...
          '*.*', 'All Files' }, '选择图像1', ...
          fullfile(pwd, 'images\\实验图像1\\a.tif'));
if isequal(filename, 0)
    return;
end
handles.file1 = fullfile(pathname, filename);
guidata(hObject, handles);
Img1 = imread(fullfile(pathname, filename));
axes(handles.axes1); 
imshow(Img1, []);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif', 'All Image Files';...
          '*.*', 'All Files' }, '选择图像2', ...
          fullfile(pwd, 'images\\实验图像1\\b.tif'));
if isequal(filename, 0)
    return;
end
handles.file2 = fullfile(pathname, filename);
guidata(hObject, handles);
Img2 = imread(fullfile(pathname, filename));
axes(handles.axes2);
imshow(Img2, []);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.file1)
    msgbox('请载入图像1！', '提示信息', 'modal');
    return;
end
if isempty(handles.file2)
    msgbox('请载入图像2！', '提示信息', 'modal');
    return;
end
[imA, map1] = imread(handles.file1);
[imB, map2] = imread(handles.file2);
M1 = double(imA) / 256;
M2 = double(imB) / 256;
zt = 2;
wtype = 'haar';
[c0, s0] = Wave_Decompose(M1, zt, wtype);
[c1, s1] = Wave_Decompose(M2, zt, wtype);
Coef_Fusion = Fuse_Process(c0, c1, s0, s1);
Y = Wave_Reconstruct(Coef_Fusion, s0, wtype);
handles.result = im2uint8(mat2gray(Y));
guidata(hObject, handles);
msgbox('小波融合处理完毕！', '提示信息', 'modal');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.result)
    msgbox('请进行填充处理！', '提示信息', 'modal');
    return;
end
axes(handles.axes3); 
imshow(handles.result, []);
