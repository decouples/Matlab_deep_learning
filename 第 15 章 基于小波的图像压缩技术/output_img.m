function output_img(x, y, filename, th, ext)
if nargin < 5
    ext = 'png';
end
[~, file, ~] = fileparts(filename);
foldername = fullfile(pwd, 'output');
if ~exist(foldername, 'dir')
    mkdir(foldername);
end
file1 = fullfile(foldername, sprintf('%s_origin.%s', file, ext));
file2 = fullfile(foldername, sprintf('%s_wave_%.1f.%s', file, th, ext));
imwrite(x, file1);
imwrite(y, file2);
info1 = imfinfo(file1);
info2 = imfinfo(file2);
fprintf('\n压缩前图像所需存储空间为%.2fbytes', info1.FileSize);
fprintf('\n压缩后图像所需存储空间为%.2fbytes', info2.FileSize);
fprintf('\n文件大小比为%.2f', info1.FileSize/info2.FileSize);