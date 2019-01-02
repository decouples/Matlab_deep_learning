function outimg = QrGen(doctext, width, height)

if nargin < 3
    height = 400;
end
if nargin < 2
    width = 400;
end
if nargin < 1
    doctext = 'hello';
end

if ~ischar(doctext)
    str = '';
    for i = 1 : length(doctext)
        str = sprintf('%s %.1f', str, doctext(i));
    end
    doctext = str;
end
zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing_encrypt.jar');
c = onCleanup(@()javarmpath(zxingpath));
javaaddpath(zxingpath);
writer = com.google.zxing.MultiFormatWriter();
bitmtx = writer.encode(doctext, com.google.zxing.BarcodeFormat.QR_CODE, ...
    width, height);
outimg = char(bitmtx);
clear bitmtx writer
outimg(outimg==10) = []; 
outimg = reshape(outimg(1:2:end), width, height)'; 
outimg(outimg~='X') = 1;
outimg(outimg=='X') = 0;
outimg = double(outimg);