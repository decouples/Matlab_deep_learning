function s = GetStrelList()
%获取算子；s 算子结构体
% 生成串联算子
s.co11 = strel('line',5,-45);
s.co12 = strel('line',7,-45);
% 生成串联算子
s.co21 = strel('line',5,45);
s.co22 = strel('line',7,45);
% 生成串联算子
s.co31 = strel('line',3,90);
s.co32 = strel('line',5,90);
% 生成串联算子
s.co41 = strel('line',3,0);
s.co42 = strel('line',5,0);
