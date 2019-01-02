function y = idwt_process(ya, yd, lf, hf)
alen = length(ya);        
dlen = length(yd);

while dlen - alen >= 0        
    yai = upsample_prcoess(ya);          
    yai = conv(yai, lf);      
    ydi = yd(dlen-alen+1:dlen);    
    ydi = upsample_prcoess(ydi);   
    ydi = conv(ydi, hf);      
    ya = yai + ydi;             
    yd = yd(1:dlen-alen);       
    alen = length(ya);        
    dlen = length(yd);
end                       
y = ya;                  
