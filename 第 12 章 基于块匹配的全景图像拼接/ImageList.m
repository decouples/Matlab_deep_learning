function Img = ImageList(file)

Img = [];
Img1 = imread(file{1});
spc = cat(3, ...
    repmat(ones(1, 5)*255, size(Img1, 1), 1), ...
    repmat(zeros(1, 5), size(Img1, 1), 1), ...
    repmat(zeros(1, 5), size(Img1, 1), 1));
if length(file) == 2
    Img = imread(file{2});
    return;
end
for i = 2 : length(file)
    Imgi = imread(file{i});
    Img = [Img Imgi spc];
end