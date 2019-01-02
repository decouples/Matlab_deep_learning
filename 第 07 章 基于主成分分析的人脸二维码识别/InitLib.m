function InitLib
zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing_encrypt.jar');
c = onCleanup(@()javarmpath(zxingpath));
javaaddpath(zxingpath);