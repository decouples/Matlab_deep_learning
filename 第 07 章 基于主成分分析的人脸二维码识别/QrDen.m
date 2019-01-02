function res = QrDen(qr_im)

if nargin < 1
    load mtx.mat;
    qr_im = mtx;
end
zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing_encrypt.jar');
javaaddpath(zxingpath);
zxingpath = fullfile(pwd, 'zxing_decrypt.jar');
javaaddpath(zxingpath);
qr_im = im2java(qr_im);
width = qr_im.getWidth(); 
height = qr_im.getHeight();
source = com.google.zxing.client.j2se.BufferedImageLuminanceSource(qr_im.getBufferedImage());
binarizer = com.google.zxing.common.HybridBinarizer(source);
bitmap = com.google.zxing.BinaryBitmap(binarizer);
reader = com.google.zxing.MultiFormatReader();
res = char(reader.decode(bitmap));