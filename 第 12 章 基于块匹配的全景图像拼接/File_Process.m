function file = File_Process(filename, pathname)
if ~isa(filename, 'cell') && size(filename, 1) == 1
    [pathstr, name, ext] = fileparts(filename);
    pathname = strrep(pathname, '\', '\\');
    imfile = ls([pathname, '*', strtrim(ext)]);
    for i = 1 : size(imfile, 1)
        file{i} = fullfile(pathname, imfile(i, :));
    end
else
    for i = 1 : length(filename)
        file{i} = fullfile(pathname, filename{i});
    end
end