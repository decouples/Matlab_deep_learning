function SaveImage(Img)
imagesPath = '.\\results';
if ~exist(imagesPath, 'dir')
    mkdir(imagesPath);
end

[FileName,PathName,FilterIndex] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'保存截图',...
          '.\\results\\result.jpg');
if isequal(FileName, 0) || isequal(PathName, 0)
    return;
end
fileStr = fullfile(PathName, FileName);
imwrite(Img, fileStr);
msgbox('处理结果保存成功！', '提示信息');