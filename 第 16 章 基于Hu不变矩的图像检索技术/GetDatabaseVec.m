function GetDatabaseVec
clc;
foldename = fullfile(pwd, 'database');
filename_list = ls(fullfile(foldename, '*.*'));
H = [];
for i = 1 : size(filename_list, 1)
    filename = fullfile(foldename, strtrim(filename_list(i, :)));
    [~, ~, ext] = fileparts(filename);
    if isequal(ext, '.') || isequal(ext, '..')
        continue;
    end
    [Img, map] = imread(filename);
    if ~isempty(map)
        Img = ind2rgb(Img, map);
    end
    % Hu不变矩特征
    vec_hu = get_hu_vec(Img);
    % 颜色量化特征
    vec_color = get_color_vec(Img);
    [~, name, ext] = fileparts(filename);
    h.vec_hu = vec_hu;
    h.vec_color = vec_color;
    h.filename = sprintf('./database/%s%s', name, ext);
    H = [H h];
end
save(fullfile(pwd, 'database/H.mat'), 'H');
