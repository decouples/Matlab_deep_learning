function vec=exactvecotr(img)
[m,n,~]=size(img);
vec=zeros(m*n,3);
img=double(img);
for j=1:n
    for i=1:m
        color=img(i,j,:);
        dist=[];
        texture=[];
        vec((j-1)*m+i,:)=[color(:);dist(:);texture(:)];
    end
end