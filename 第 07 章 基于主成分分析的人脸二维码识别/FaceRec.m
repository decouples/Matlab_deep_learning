function Ims = FaceRec(c, sz)
if ischar(c)
    d = [];
    ind = strfind(c, ' ');
    for i = 1 : length(ind)-1
        di = c(ind(i):ind(i+1));
        d = [d str2double(di)];
    end
    c = [d str2double(c(ind(i+1):end))];
end
load(fullfile(pwd, '»À¡≥ø‚/model.mat'));
temp = base(:,1:length(c))* c';
temp = temp + samplemean';
Ims = im2uint8(mat2gray(reshape(real(temp), sz(1), sz(2))));