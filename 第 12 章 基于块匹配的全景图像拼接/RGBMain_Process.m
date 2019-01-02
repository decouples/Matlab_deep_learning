function [MStitch, result] = RGBMain_Process(MStitch, W_box, H_box, bdown)

[MStitch, result] = Fun_StitchRGB(MStitch.im2, W_box, H_box, bdown, MStitch);
