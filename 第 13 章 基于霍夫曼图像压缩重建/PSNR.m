function S=PSNR(sss,aaa)

[m n p]=size(sss);
A=double(sss);
B=double(aaa);
sumaDif=0;
maxI=m*n*max(max(A.^2));
for u=1:m
    for v=1:n
        sumaDif=sumaDif+(A(u,v)-B(u,v))^2;
    end
end
if  (sumaDif==0)
    sumaDif=1;
end
S=maxI/sumaDif;
S=10*log10(S);


    
    