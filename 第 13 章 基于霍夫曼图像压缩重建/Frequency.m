function f = Frequency(vector)
if ~isa(vector,'uint8')
    error('应该输入uint8类型数据向量！');
end
f = histc(vector(:), 0:255); 
f = f(:)'/sum(f); 