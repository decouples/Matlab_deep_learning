function S = GetDatabase(dirName)
if exist(fullfile(pwd, 'S.mat'), 'file')
    load(fullfile(pwd, 'S.mat'));
    return;
end
if nargin < 1
    dirName = './wav/Database';
end
h = waitbar(0, '', 'Name', '获取音频信号特征...');
fileList = getAllFiles(dirName);
steps = length(fileList);
for i = 1 : steps
    file = fileList{i};
    [~, name, ~]= fileparts(file);
    ind = strfind(name, '语音信号');
    if ~isempty(ind)
        name = name(1:ind-1);
        name = strtrim(name);
    end
    MC = GetFeather(file);
    S(i).name = name;
    S(i).MC = MC;
    waitbar(i/steps, h, sprintf('已处理：%d%%', round(i/steps*100)));
end
close(h);
save S.mat S