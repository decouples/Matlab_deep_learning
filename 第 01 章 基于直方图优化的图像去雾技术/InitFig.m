function InitFig(hObject,handles)
axes(handles.axes1); cla; set(gca, 'Color', [0.8039 0.8784 0.9686]);
axes(handles.axes2); cla; axis on; box on; set(gca, 'Color', [0.8039 0.8784 0.9686]);
set(gca, 'XTickLabel', [], 'YTickLabel', [], 'XTick', [], 'YTick', []);
set(handles.textInfo, 'String', ...
    '图像去雾系统，首先载入图像并显示，然后选择去雾算法，最后可以观察直方图对比效果。');