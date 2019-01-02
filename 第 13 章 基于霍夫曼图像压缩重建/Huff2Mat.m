function vec = Huff2Mat(zvec, zi)
if ~isa(zvec,'uint8')
    fprintf('\n请确认输入uint8类型数据向量！\n');
    return;
end
len = length(zvec);
str_tmp = repmat(uint8(0),1,len.*8);
bi = 1:8;
for index = 1:len
    str_tmp(bi+8.*(index-1)) = uint8(bitget(zvec(index),bi));
end
str_tmp = logical(str_tmp(:)'); 
len = length(str_tmp);
str_tmp((len-zi.pad+1):end) = []; 
len = length(str_tmp);
vec = repmat(uint8(0),1,zi.length);
vi = 1;
ci = 1;
cd = 0;
for index = 1:len
    cd = bitset(cd,ci,str_tmp(index));
    ci = ci+1;
    byte = Decode(bitset(cd,ci),zi);
    if byte > 0
        vec(vi) = byte-1;
        ci = 1;
        cd = 0;
        vi = vi+1;
    end
end