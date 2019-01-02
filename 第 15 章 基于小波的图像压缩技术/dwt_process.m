function [ya, yd] = dwt_process(x, lf, hf, num)
x = double(x);
ya = x;      
yd = [];
for i = 1 : num
    yli = conv(ya,lf);  
    yai = downsample_prcoess(yli);   
    yhi = conv(ya, hf);   
    ydi = downsample_prcoess(yhi);  
    ya = yai;                
    yd = [yd ydi];        
end
