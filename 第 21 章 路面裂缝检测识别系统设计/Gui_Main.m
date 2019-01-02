function varargout = Gui_Main(varargin)
% GUI_MAIN M-file for Gui_Main.fig
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

% Last Modified by GUIDE v2.5 29-Mar-2011 22:28:58

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
handles.output = hObject;
handles.Result = [];
handles.File = [];
% Update handles structure
guidata(hObject, handles);
clc; warning off all;
InitAxes(handles);

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


% --- Executes on button press in pushbuttonOpenFile.
function pushbuttonOpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },'载入图像',...
    fullfile(pwd, 'images'));
if isequal(filename, 0) || isequal(pathname, 0)
    return;
end
I = imread(fullfile(pathname, filename));
Result = Process_Main(I);
handles.File = fullfile(pathname, filename);
handles.Result = Result;
guidata(hObject, handles);
InitAxes(handles)
axes(handles.axes1); imshow(handles.Result.Image); title('原图像');


% --- Executes on button press in pushbuttonHisteq.
function pushbuttonHisteq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonHisteq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.hist); title('直方图均衡化图像');
end



% --- Executes on button press in pushbuttonMedfilt.
function pushbuttonMedfilt_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonMedfilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.Medfilt); title('中值滤波图像');
end


% --- Executes on button press in pushbuttonBw.
function pushbuttonBw_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.Bw); title('二值图像');
end

% --- Executes on button press in pushbuttonEnance.
function pushbuttonEnance_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonEnance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.Enance); title('增强图像');
end

% --- Executes on button press in pushbuttonBwfilter.
function pushbuttonBwfilter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBwfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.Bw); title('二值图像');
    axes(handles.axes3); imshow(handles.Result.BwFilter); title('二值图像滤波');
end

% --- Executes on button press in pushbuttonCrackRec.
function pushbuttonCrackRec_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCrackRec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.Bw); title('二值图像');
    axes(handles.axes3); imshow(handles.Result.BwFilter); title('二值图像滤波');
    axes(handles.axes4); imshow(handles.Result.CrackRec); title('裂缝识别');
end


% --- Executes on button press in pushbuttonCrackJudge.
function pushbuttonCrackJudge_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCrackJudge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.BwFilter); title('二值图像滤波');
    axes(handles.axes3); imshow(handles.Result.CrackRec); title('裂缝识别');
    axes(handles.axes4); imshow(handles.Result.CrackJudge); title('裂缝判断');
end

% --- Executes on button press in pushbuttonCrackLoc.
function pushbuttonCrackLoc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCrackLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.CrackJudge); title('裂缝图像');
    axes(handles.axes3); imshow(handles.Result.CrackJudge); title(handles.Result.str);
    axes(handles.axes4); imshow(handles.Result.CrackJudge); title('裂缝标记图像');
    hold on;
    rectangle('Position', handles.Result.rect, 'EdgeColor', 'g', 'LineWidth', 2);
    hold off;
end

% --- Executes on button press in pushbuttonProject.
function pushbuttonProject_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonProject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.CrackJudge); title('裂缝图像');
    axes(handles.axes3); plot(1:size(handles.Result.Image, 1), handles.Result.Projectr);
    title('行投影');
    axes(handles.axes4); plot(1:size(handles.Result.Image, 2), handles.Result.Projectc);
    title('列投影');
end


% --- Executes on button press in pushbuttonClose.
function pushbuttonClose_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('确定退出?', ...
    '退出', ...
    '是','否','否');
switch choice
    case '是'
        close;
    otherwise
        return;
end



% --- Executes on button press in pushbuttonSaveResult.
function pushbuttonSaveResult_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSaveResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    if ~isempty(handles.File)
        raw = [];
        xlsfile = fullfile(pwd, 'Result/result.xls');
        if exist(xlsfile, 'file')
            [num, txt, raw] = xlsread(xlsfile);
        end
        
        F = [];
        F{1, 1} = '文件名';
        F{1, 2} = '阈值信息';
        F{1, 3} = '面积信息';
        F{1, 4} = '长度信息';
        F{1, 5} = '最大宽度信息';
        F{1, 6} = '最小宽度信息';
        F{1, 7} = '形状信息';
        
        F{2, 1} = handles.File;
        F{2, 2} = handles.Result.BwTh;
        F{2, 3} = handles.Result.BwArea;
        F{2, 4} = handles.Result.BwLength;
        F{2, 5} = handles.Result.BwWidthMax;
        F{2, 6} = max(handles.Result.BwWidthMin,0.01);
        F{2, 7} = handles.Result.str;
        
        F = [raw; F];
        xlswrite(xlsfile, F);
        
        msgbox('保存结果成功！', '信息提示框');
    end
catch
    msgbox('保存结果失败，请检查程序！', '信息提示框');
end


% --- Executes on button press in pushbuttonBridge.
function pushbuttonBridge_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBridge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.Result)
    axes(handles.axes1); imshow(handles.Result.Image); title('原图像');
    axes(handles.axes2); imshow(handles.Result.BwFilter); title('二值图像滤波');
    axes(handles.axes3); imshow(handles.Result.CrackJudge); title('裂缝判断');
    axes(handles.axes4); imshow(handles.Result.CrackBridge); title('裂缝拼接');
end


% --- Executes on button press in pushbuttonSaveImage.
function pushbuttonSaveImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },'Save Image',...
    fullfile(pwd, 'Result/result.png'));
if ~isequal(filename, 0)
    imwrite(handles.Result.BwEnd, fullfile(pathname, filename));
    msgbox('保存图像成功！', '信息提示框');
end


% --- Executes on button press in pushbuttonDiplay.
function pushbuttonDiplay_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDiplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.File)
    F = [];
    F{1} = sprintf('文件名:%s', handles.File);
    F{2} = sprintf('阈值信息%.2f', handles.Result.BwTh);
    F{3} = sprintf('面积信息%.2f', handles.Result.BwArea);
    F{4} = sprintf('长度信息%.2f', handles.Result.BwLength);
    F{5} = sprintf('最大宽度信息%.2f', handles.Result.BwWidthMax);
    F{6} = sprintf('最小宽度信息%.2f', max(handles.Result.BwWidthMin,0.01));
    F{7} = sprintf('形状信息%s', handles.Result.str);
    listdlg('PromptString', '参数显示:',...
        'Name', '参数信息', ...
        'ListSize', [300, 150], ...
        'SelectionMode','single',...
        'ListString', F);
end
