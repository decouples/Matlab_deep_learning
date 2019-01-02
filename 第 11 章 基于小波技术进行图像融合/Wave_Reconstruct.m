function Y = Wave_Reconstruct(Coef_Fusion, s, wtype)

if nargin < 3
    wtype = 'haar';
end

Y = waverec2(Coef_Fusion, s, wtype);