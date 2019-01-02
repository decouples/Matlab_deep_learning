function [c, s] = Wave_Decompose(M, zt, wtype)

if nargin < 3
    wtype = 'haar';
end
if nargin < 2
    zt = 2;
end

[c, s] = wavedec2(M, zt, wtype);
