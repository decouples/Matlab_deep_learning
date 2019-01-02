function xr = idwt2_process(ya, yv, yh, yd, lf, hf, dimv)
xt = [ya, yv; yh, yd];
mr = round(size(xt, 1)/2);
for j = 1 : size(xt, 2)                      
    yaj = xt(1:mr, j);           
    ydj = xt(mr+1:end, j);         
    xtj = idwt_process(yaj, ydj, lf, hf);    
    xc(:, j) = wkeep(xtj, dimv(1));   
end
mc = round(size(xt, 2)/2);
for i = 1 : size(xc, 1)                     
    yai = xc(i, 1:mc);           
    ydi = xc(i, mc+1:end);
    xti = idwt_process(yai, ydi, lf, hf);
    xr(i, :) = wkeep(xti,dimv(2));  
end