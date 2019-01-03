function varargout = MainFrame(varargin)
% MAINFRAME MATLAB code for MainFrame.fig
%      MAINFRAME, by itself, creates a new MAINFRAME or raises the existing
%      singleton*.
%
%      H = MAINFRAME returns the handle to a new MAINFRAME or the handle to
%      the existing singleton*.
%
%      MAINFRAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFRAME.M with the given input arguments.
%
%      MAINFRAME('Property','Value',...) creates a new MAINFRAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainFrame_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainFrame_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainFrame

% Last Modified by GUIDE v2.5 30-Apr-2017 06:35:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainFrame_OpeningFcn, ...
    'gui_OutputFcn',  @MainFrame_OutputFcn, ...
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


% --- Executes just before MainFrame is made visible.
function MainFrame_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainFrame (see VARARGIN)

% Choose default command line output for MainFrame
handles.output = hObject;
clc;
handles.videoFilePath = 0;
handles.videoInfo = 0;
handles.videoImgList = 0;
handles.videoStop = 1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainFrame wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainFrame_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonPlay.
function pushbuttonPlay_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 播放按钮
set(handles.pushbuttonPause, 'Enable', 'On');
set(handles.pushbuttonPause, 'tag', 'pushbuttonPause', 'String', '暂停');
set(handles.sliderVideoPlay, 'Max', handles.videoInfo.NumberOfFrames, 'Min', 0, 'Value', 1);
set(handles.editSlider, 'String', sprintf('%d/%d', 0, handles.videoInfo.NumberOfFrames));
% 循环载入视频帧图像并显示
for i = 1 : handles.videoInfo.NumberOfFrames
    waitfor(handles.pushbuttonPause,'tag','pushbuttonPause');
    I = imread(fullfile(pwd, sprintf('video_images\\%03d.jpg', i)));    
    try
        imshow(I, [], 'Parent', handles.axesVideo);
        % 设置进度条
        set(handles.sliderVideoPlay, 'Value', i);
        set(handles.editSlider, 'String', sprintf('%d/%d', i, handles.videoInfo.NumberOfFrames));
    catch
        return;
    end
    drawnow;
end
% 控制暂停按钮
set(handles.pushbuttonPause, 'Enable', 'Off');

% --- Executes on button press in pushbuttonOpenVideoFile.
function pushbuttonOpenVideoFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOpenVideoFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打开视频文件按钮
videoFilePath = OpenVideoFile();
if videoFilePath == 0
    return;
end
set(handles.editVideoFilePath, 'String', videoFilePath);
msgbox('打开视频文件成功！', '提示信息');
handles.videoFilePath = videoFilePath;
guidata(hObject, handles);


% --- Executes on button press in pushbuttonImageList.
function pushbuttonImageList_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonImageList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 获取图像序列按钮
if handles.videoInfo == 0
    msgbox('请先获取视频信息', '提示信息');
    return;
end
Video2Images(handles.videoFilePath);
msgbox('获取图像序列成功！', '提示信息');

% --- Executes on button press in pushbuttonStopCheck.
function pushbuttonStopCheck_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStopCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 视频分析
[s, sx, sy] =  MotionAnalysis();
handles.s = s;
handles.sx = sx;
handles.sy = sy;
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbuttonPause.
function pushbuttonPause_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 暂停按钮
% 获取响应标记
str = get(handles.pushbuttonPause, 'tag');
if strcmp(str, 'pushbuttonPause') == 1
    set(handles.pushbuttonPause, 'tag', 'pushbuttonContinue', 'String', '继续');
    pause on;
else
    set(handles.pushbuttonPause, 'tag', 'pushbuttonPause', 'String', '暂停');
    pause off;
end

% --- Executes on button press in pushbuttonStop.
function pushbuttonStop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 停止按钮
axes(handles.axesVideo); cla; axis on; box on;
set(gca, 'XTick', [], 'YTick', [], ...
    'XTickLabel', '', 'YTickLabel', '', 'Color', [0.7020 0.7804 1.0000]);
set(handles.editSlider, 'String', '0/0');
set(handles.sliderVideoPlay, 'Value', 0);
set(handles.pushbuttonPause, 'tag', 'pushbuttonContinue', 'String', '继续');
set(handles.pushbuttonPause, 'Enable', 'Off');
set(handles.pushbuttonPause, 'String', '暂停');


function editFrameNum_Callback(hObject, eventdata, handles)
% hObject    handle to editFrameNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrameNum as text
%        str2double(get(hObject,'String')) returns contents of editFrameNum as a double


% --- Executes during object creation, after setting all properties.
function editFrameNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrameNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrameWidth_Callback(hObject, eventdata, handles)
% hObject    handle to editFrameWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrameWidth as text
%        str2double(get(hObject,'String')) returns contents of editFrameWidth as a double


% --- Executes during object creation, after setting all properties.
function editFrameWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrameWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrameHeight_Callback(hObject, eventdata, handles)
% hObject    handle to editFrameHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrameHeight as text
%        str2double(get(hObject,'String')) returns contents of editFrameHeight as a double


% --- Executes during object creation, after setting all properties.
function editFrameHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrameHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrameRate_Callback(hObject, eventdata, handles)
% hObject    handle to editFrameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrameRate as text
%        str2double(get(hObject,'String')) returns contents of editFrameRate as a double


% --- Executes during object creation, after setting all properties.
function editFrameRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVideoFilePath_Callback(hObject, eventdata, handles)
% hObject    handle to editVideoFilePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVideoFilePath as text
%        str2double(get(hObject,'String')) returns contents of editVideoFilePath as a double


% --- Executes during object creation, after setting all properties.
function editVideoFilePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVideoFilePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonGetVideoInfo.
function pushbuttonGetVideoInfo_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonGetVideoInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 获取视频信息按钮
if handles.videoFilePath == 0
    msgbox('请载入视频文件！', '提示信息');
    return;
end
% 获取信息并保存
videoInfo = VideoReader(handles.videoFilePath);
handles.videoInfo = videoInfo;
guidata(hObject, handles);
% 提取信息并显示到界面
set(handles.editFrameNum, 'String', sprintf('%d', videoInfo.NumberOfFrames));
set(handles.editFrameWidth, 'String', sprintf('%d px', videoInfo.Width));
set(handles.editFrameHeight, 'String', sprintf('%d px', videoInfo.Height));
set(handles.editFrameRate, 'String', sprintf('%d f/s', videoInfo.FrameRate));
set(handles.editDuration, 'String', sprintf('%.1f s', videoInfo.Duration));
set(handles.editVideoFormat, 'String', sprintf('%s', videoInfo.VideoFormat));
msgbox('获取视频文件信息成功！', '提示信息');


function editDuration_Callback(hObject, eventdata, handles)
% hObject    handle to editDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDuration as text
%        str2double(get(hObject,'String')) returns contents of editDuration as a double


% --- Executes during object creation, after setting all properties.
function editDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVideoFormat_Callback(hObject, eventdata, handles)
% hObject    handle to editVideoFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVideoFormat as text
%        str2double(get(hObject,'String')) returns contents of editVideoFormat as a double


% --- Executes during object creation, after setting all properties.
function editVideoFormat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVideoFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonSnap.
function pushbuttonSnap_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSnap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 抓图按钮响应函数
SnapImage();

% --- Executes on slider movement.
function sliderVideoPlay_Callback(hObject, eventdata, handles)
% hObject    handle to sliderVideoPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderVideoPlay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderVideoPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function editSlider_Callback(hObject, eventdata, handles)
% hObject    handle to editSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSlider as text
%        str2double(get(hObject,'String')) returns contents of editSlider as a double


% --- Executes during object creation, after setting all properties.
function editSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInfo_Callback(hObject, eventdata, handles)
% hObject    handle to editInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInfo as text
%        str2double(get(hObject,'String')) returns contents of editInfo as a double


% --- Executes during object creation, after setting all properties.
function editInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonExit.
function pushbuttonExit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 退出系统按钮
choice = questdlg('确定要退出系统?', ...
    '退出', ...
    '确定','取消','取消');
switch choice
    case '确定'
        close;
    case '取消'
        return;
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Exist_Callback(hObject, eventdata, handles)
% hObject    handle to Exist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 退出菜单
choice = questdlg('确定要退出系统?', ...
    '退出', ...
    '确定','取消','取消');
switch choice
    case '确定'
        close;
    case '取消'
        return;
end

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = '视频处理系统V1.0';
msgbox(str, '提示信息');



function edit_videowidth_Callback(hObject, eventdata, handles)
% hObject    handle to edit_videowidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_videowidth as text
%        str2double(get(hObject,'String')) returns contents of edit_videowidth as a double


% --- Executes during object creation, after setting all properties.
function edit_videowidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_videowidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 选择路径
video_path = out_put_videofile();
if isequal(video_path, 0)
    % 选择失效，返回
    return;
end
% 输出文件
image_folder = fullfile(pwd, 'video_images');
Images2Video(image_folder, video_path);
% 提示
msgbox('导出成功！', '提示信息');

function video_path = out_put_videofile()
% 设置路径
foldername_out = fullfile(pwd, 'video_out');
if ~exist(foldername_out, 'dir')
    % 如果文件夹不存在，则创建
    mkdir(foldername_out);
end
% 设置文件名
video_default_path = fullfile(foldername_out, 'out.avi');
% 打开对话框，设置路径
[video_file_name, video_folder_name, ~] = uiputfile( ...
    {  '*.avi','VideoFile (*.avi)'; ...
    '*.wmv','VideoFile (*.wmv)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'VideoFile', ...
    video_default_path);
% 初始化
video_path = 0;
if isequal(video_file_name, 0) || isequal(video_folder_name, 0)
    % 如果选择失效，则返回
    return;
end
% 路径整合
video_path = fullfile(video_folder_name, video_file_name);

function Images2Video(image_folder, video_file_name)
% 默认起始帧
start_frame = 1;
% 默认结束帧
end_frame = size(ls(fullfile(image_folder, '*.jpg')), 1);
% 创建对象句柄
hwrite = VideoWriter(video_file_name);
% 设置帧率
hwrite.FrameRate = 24;
% 开始打开
open(hwrite);
% 进度条
hwaitbar = waitbar(0, '', 'Name', '生成视频文件...');
% 总帧数
steps = end_frame - start_frame;
for num = start_frame : end_frame
    % 当前序号的名称
    image_file = sprintf('%03d.jpg', num);
    % 当前序号的位置
    image_file = fullfile(image_folder, image_file);
    % 读取
    image_frame = imread(image_file);
    % 转化为帧对象
    image_frame = im2frame(image_frame);
    % 写出
    writeVideo(hwrite,image_frame);
    % 刷新
    pause(0.01);
    % 进度
    step = num - start_frame;
    % 显示
    waitbar(step/steps, hwaitbar, sprintf('已处理：%d%%', round(step/steps*100)));
end
% 关闭句柄
close(hwrite);
% 关闭进度条
close(hwaitbar);
