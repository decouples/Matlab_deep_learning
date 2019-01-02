function [W_box, H_box, bdown, MStitch] = Fun_Match(im2, MStitch)

Pwidth = MStitch.Pwidth;
Pheight = MStitch.Pheight; 
W_min = MStitch.W_min; 
W_max = MStitch.W_max;
H_min = MStitch.H_min; 
minval = MStitch.minval; 
im1 = MStitch.im1;
[Fheight, Fwidth] = size(im2);

hw = waitbar(0, 'Í¼ÏñÆ¥Åä½ø¶È£º', 'Name', 'Í¼ÏñÆ¥Åä¡­¡­');
w_ind = 64; h_ind = 151;
for w = W_min : W_max
    for h = H_min : Fheight
        imsum = 0; 
        x2 = 1;
        for x1 = Pwidth-w : 5 : Pwidth
            y2 = 1;
            for y1 = Pheight-h+1 : 5 : Pheight
                [x1, y1] = CheckRC(x1, y1, im1);
                [x2, y2] = CheckRC(x2, y2, im2);
                imsum = imsum + abs(im1(y1, x1) - im2(y2, x2));
                y2 = y2 + 5;
            end
            x2 = x2 + 5;
        end
        if imsum*5*5 < minval*w*h
            minval = imsum*5*5/(w*h);
            w_ind = w;
            h_ind = h;
        end
    end
    rt = 0.5*(w - W_min)/(W_max - W_min);
    waitbar(rt, hw, sprintf('Í¼ÏñÆ¥Åä½ø¶È£º%i%%', round(rt*100)));
end
W_box = w_ind-1;
H_box = h_ind+1;
bdown = 1;
if H_box < size(im2, 1)
    H_box = size(im2, 1);
end

for w = W_min : W_max
    for h = H_min : Fheight
        imsum = 0; 
        x2 = 1;
        for x1 = Pwidth-w : 5 : Pwidth
            y1 = 1;
            for y2 = Fheight-h+1 : 5 : Fheight
                [x1, y1] = CheckRC(x1, y1, im1);
                [x2, y2] = CheckRC(x2, y2, im2);
                imsum = imsum + abs(im1(y1, x1) - im2(y2, x2));
                y1 = y1 + 5;
            end
            x2 = x2 + 5;
        end
        if imsum*5*5 < minval*w*h
            minval = imsum*5*5/(w*h);
            w_ind = w;
            h_ind = h;
            bdown = 0;
        end
    end
    rt = 0.5 + 0.5*(w - W_min)/(W_max - W_min);
    waitbar(rt, hw, sprintf('Í¼ÏñÆ¥Åä½ø¶È£º%i%%', round(rt*100)));
end
MStitch.minval = minval;
delete(hw);