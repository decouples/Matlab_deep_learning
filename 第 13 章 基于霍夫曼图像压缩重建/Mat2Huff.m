function [zvec, zi] = Mat2Huff(vec)

if ~isa(vec,'uint8')
    fprintf('\n请确认输入uint8类型数据向量！\n');
    return;
end

vec = vec(:)';
f = Frequency(vec);
syminfos = find(f~=0); 
f = f(syminfos);
[f, sind] = sort(f);
syminfos = syminfos(sind);
len = length(syminfos);
syminfos_ind = num2cell(1:len);
cw_temp = cell(len,1);
while length(f)>1
    ind1 = syminfos_ind{1};
    ind2 = syminfos_ind{2};
    cw_temp(ind1) = AddNode(cw_temp(ind1),uint8(0));
    cw_temp(ind2) = AddNode(cw_temp(ind2),uint8(1));
    f = [sum(f(1:2)) f(3:end)];
    syminfos_ind = [{[ind1 ind2]} syminfos_ind(3:end)];
    [f,sind] = sort(f);
    syminfos_ind = syminfos_ind(sind);
end
cw = cell(256,1);
cw(syminfos) = cw_temp;
len = 0;
for i = 1 : length(vec),
    len = len+length(cw{double(vec(i))+1});
end
str_temp = repmat(uint8(0),1,len);
pt = 1;
for index=1:length(vec)
    cd = cw{double(vec(index))+1};
    len = length(cd);
    str_temp(pt+(0:len-1)) = cd;
    pt = pt+len;
end
len = length(str_temp);
pad = 8-mod(len,8);
if pad > 0
    str_temp = [str_temp uint8(zeros(1,pad))];
end
cw = cw(syminfos);
cl = zeros(size(cw));
ws = 2.^(0:51);
mcl = 0;
for index = 1:length(cw)
    len = length(cw{index});
    if len>mcl
        mcl = len;
    end
    if len>0
        cd = sum(ws(cw{index}==1));
        cd = bitset(cd,len+1);
        cw{index} = cd;
        cl(index) = len;
    end
end
cw = [cw{:}];
cols = length(str_temp)/8;
str_temp = reshape(str_temp,8,cols);
ws = 2.^(0:7);
zvec = uint8(ws*double(str_temp));
huffcodes = sparse(1,1);
for index = 1:numel(cw)
    huffcodes(cw(index),1) = syminfos(index);
end
zi.pad = pad;
zi.huffcodes = huffcodes;
zi.ratio = cols./length(vec);
zi.length = length(vec);
zi.maxcodelen = mcl;