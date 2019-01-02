function InitFig(hObject,handles)
axes(handles.axes1); 
cla; axis on; box on;
set(gca, 'Color', [0.8039 0.8784 0.9686]);
set(gca, 'XTickLabel', [], 'YTickLabel', [], 'XTick', [], 'YTick', []);
axes(handles.axes2); 
cla; axis on; box on;
set(gca, 'Color', [0.8039 0.8784 0.9686]);
set(gca, 'XTickLabel', [], 'YTickLabel', [], 'XTick', [], 'YTick', []);
set(handles.textInfo, 'String', ...
    '图像压缩系统，载入图像，选择压缩算法，比较压缩效果。');