function [MStitch, result] = GrayMain_Process(MStitch, W_box, H_box, bdown)

[MStitch, result] = Fun_Stitch(MStitch.im2, W_box, H_box, bdown, MStitch);
