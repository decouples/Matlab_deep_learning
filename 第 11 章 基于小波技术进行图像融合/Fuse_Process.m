function Coef_Fusion = Fuse_Process(c0, c1, s0, s1)

KK = size(c1);
Coef_Fusion = zeros(1, KK(2));
Coef_Fusion(1:s1(1,1)*s1(1,2)) = (c0(1:s1(1,1)*s1(1,2))+c1(1:s1(1,1)*s1(1,2)))/2; 
MM1 = c0(s1(1,1)*s1(1,2)+1:KK(2));
MM2 = c1(s1(1,1)*s1(1,2)+1:KK(2));
mm = (abs(MM1)) > (abs(MM2));
Y  = (mm.*MM1) + ((~mm).*MM2);
Coef_Fusion(s1(1,1)*s1(1,2)+1:KK(2)) = Y;