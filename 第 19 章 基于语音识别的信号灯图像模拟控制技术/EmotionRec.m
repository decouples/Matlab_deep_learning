function varargout = EmotionRec(varargin)
% EMOTIONREC M-file for EmotionRec.fig
%      EMOTIONREC, by itself, creates a new EMOTIONREC or raises the existing
%      singleton*.
%
%      H = EMOTIONREC returns the handle to a new EMOTIONREC or the handle to
%      the existing singleton*.
%
%      EMOTIONREC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMOTIONREC.M with the given input arguments.
%
%      EMOTIONREC('Property','Value',...) creates a new EMOTIONREC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EmotionRec_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EmotionRec_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EmotionRec

% Last Modified by GUIDE v2.5 12-May-2013 18:24:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @EmotionRec_OpeningFcn, ...
    'gui_OutputFcn',  @EmotionRec_OutputFcn, ...
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


% --- Executes just before EmotionRec is made visible.
function EmotionRec_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EmotionRec (see VARARGIN)

% Choose default command line output for EmotionRec
handles.output = hObject;
addpath(fullfile(pwd, 'voicebox'));
clc;
axes(handles.axes1); cla reset; box on;
set(gca, 'XTick', [], 'YTick', [], ...
    'XTickLabel', '', 'YTickLabel', '', 'Color', [0.7020 0.7804 1.0000]);
set(handles.axes2, 'XTick', [], 'YTick', [], ...
    'XTickLabel', '', 'YTickLabel', '', 'Color', [0.7020 0.7804 1.0000], ...
    'Box', 'On');
handles.dirName = 0;
handles.S = 0;
handles.fileurl = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EmotionRec wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EmotionRec_OutputFcn(hObject, eventdata, handles)
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
%% 载入语音库
% 数据库路径
dirName = './wav/Database';
dirName = uigetdir(dirName);
if isequal(dirName, 0)
    return;
end
msgbox(sprintf('载入%s成功！', dirName), '提示信息');
handles.dirName = dirName;
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 提取特征参数
if isequal(handles.dirName, 0)
    msgbox('请选择音频库目录', '提示信息', 'modal');
    return;
end
S = GetDatabase(handles.dirName);
handles.S = S;
guidata(hObject, handles);
msgbox('音频信号特征提取完毕', '提示信息', 'modal');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 选择测试文件
file = './wav/Test/1.wav';
[Filename, Pathname] = uigetfile('*.wav', '打开新的语音文件',...
    file);
if Filename == 0
    return;
end
fileurl = fullfile(Pathname,Filename);
[signal, fs] = audioread(fileurl);
axes(handles.axes1); cla reset; box on;
plot(signal); title('待识别语音信号', 'FontWeight', 'Bold');
msgbox('载入语音文件成功', '提示信息', 'modal');
handles.fileurl = fileurl;
handles.signal = signal;
handles.fs = fs;
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% 识别
if isequal(handles.fileurl, 0)
    msgbox('请选择音频文件', '提示信息', 'modal');
    return;
end
if isequal(handles.S, 0)
    msgbox('请计算音频库MFCC特征', '提示信息', 'modal');
    return;
end
S = handles.S;
[num, MC] = Reco(S, handles.fileurl);
result = S(num).name;
result = result(1:2);
c = 'r';
switch result
    case '打开'
        c = 'r';
    case '关闭'
        c = 'g';
    case '继续'
        c = 'b';
    case '开始'
        c = 'c';
    case '停止'
        c = 'y';
    case '暂停'
        c = 'm';
end
PlotInfo(handles.axes2, c);
msgbox('识别完成', '提示信息', 'modal');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 播放测试文件
if isequal(handles.fileurl, 0)
    msgbox('请选择音频文件', '提示信息', 'modal');
    return;
end
sound(handles.signal, handles.fs);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 发送控制命令按钮
str = get(handles.textReconResult, 'String');
if isequal(strtrim(str), '')
    msgbox('无控制命令！', '提示信息', 'modal');
    return;
end
str = sprintf('控制命令"%s"已发送！', str);
msgbox(str, '提示信息', 'modal');
