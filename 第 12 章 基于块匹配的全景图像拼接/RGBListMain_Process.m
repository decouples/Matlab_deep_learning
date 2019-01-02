function [MStitch, result] = RGBListMain_Process(file)

for i = 1 : length(file)-1
    if i == 1
        file1 = file{i};
        im1 = imread(file1);
        im1 = rgb2gray(im1);
        MStitch.im1 = double(im1);
        
        [Pheight, Pwidth] = size(im1);
        
        MStitch.Pwidth = Pwidth; 
        MStitch.Pheight = Pheight;
        
        MStitch.W_min = round(0.60*Pwidth); 
        MStitch.W_max = round(0.83*Pwidth); 
        MStitch.H_min = round(0.98*Pheight); 
        MStitch.minval = 255;
        
        im1 = imread(file1);
        MStitch.imrgb1 = double(im1);
        im1 = rgb2gray(im1);
        MStitch.im1 = double(im1);
    else
        MStitch.im1 = double(result1);
    end
    file2 = file{i+1};   
    im2 = imread(file2);
    MStitch.imrgb2 = double(im2);
    im2 = rgb2gray(im2);
    im2 = double(im2);    
    [W_box, H_box, bdown, MStitch] = Fun_Match(im2, MStitch);
    [MStitch, result1] = Fun_StitchRGB(im2, W_box, H_box, bdown, MStitch);
end
result = result1;