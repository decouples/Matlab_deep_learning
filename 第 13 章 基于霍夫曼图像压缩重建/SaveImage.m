function SaveImage(Img)

imagesPath = '.\\results';
if ~exist(imagesPath, 'dir')
    mkdir(imagesPath);
end

[FileName,PathName,FilterIndex] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'±£´æ½ØÍ¼',...
          '.\\results\\result.jpg');
if isequal(FileName, 0) || isequal(PathName, 0)
    return;
end
fileStr = fullfile(PathName, FileName);
imwrite(mat2gray(Img), fileStr);
