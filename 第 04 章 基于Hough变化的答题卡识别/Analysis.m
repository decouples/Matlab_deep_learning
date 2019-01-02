function [Dom, Aom, Answer, Bn] = Analysis(stats1, stats2, Line, Img, flag)

if nargin < 5
    flag = 1;
end
Line1 = Line{1};
Line2 = Line{2};
Line3 = Line{3};
Line4 = Line{4};
yn1 = round(Line1(1, 2) + 0.18*(Line2(1, 2)-Line1(1, 2)));
yn2 = round(Line1(1, 2) + 0.34*(Line2(1, 2)-Line1(1, 2)));
yn3 = round(Line1(1, 2) + 0.50*(Line2(1, 2)-Line1(1, 2)));
Linen1_1 = [Line1(1, 1) yn1; Line1(2, 1) yn1];
Linen2_1 = [Line1(1, 1) yn2; Line1(2, 1) yn2];
Linen3_1 = [Line1(1, 1) yn3; Line1(2, 1) yn3];
% 定位竖直网格分割线
xn1 = round(Line3(1, 1) + 0.22*(Line4(1, 1)-Line3(1, 1)));
xn2 = round(Line3(1, 1) + 0.26*(Line4(1, 1)-Line3(1, 1)));
xn3 = round(Line3(1, 1) + 0.48*(Line4(1, 1)-Line3(1, 1)));
xn4 = round(Line3(1, 1) + 0.52*(Line4(1, 1)-Line3(1, 1)));
xn5 = round(Line3(1, 1) + 0.73*(Line4(1, 1)-Line3(1, 1)));
xn6 = round(Line3(1, 1) + 0.77*(Line4(1, 1)-Line3(1, 1)));
xn7 = round(Line3(1, 1) + 0.98*(Line4(1, 1)-Line3(1, 1)));

Linen1_2 = [xn1 Line3(1, 2); xn1 Line3(2, 2)];
Linen2_2 = [xn2 Line3(1, 2); xn2 Line3(2, 2)];
Linen3_2 = [xn3 Line3(1, 2); xn3 Line3(2, 2)];
Linen4_2 = [xn4 Line3(1, 2); xn4 Line3(2, 2)];
Linen5_2 = [xn5 Line3(1, 2); xn5 Line3(2, 2)];
Linen6_2 = [xn6 Line3(1, 2); xn6 Line3(2, 2)];
Linen7_2 = [xn7 Line3(1, 2); xn7 Line3(2, 2)];
ym1_1 = round(Line1(1, 2) + 0.32*(Linen1_1(1, 2)-Line1(1, 2)));
ym2_1 = round(Line1(1, 2) + 0.5*(Linen1_1(1, 2)-Line1(1, 2)));
ym3_1 = round(Line1(1, 2) + 0.65*(Linen1_1(1, 2)-Line1(1, 2)));
ym4_1 = round(Line1(1, 2) + 0.80*(Linen1_1(1, 2)-Line1(1, 2)));
ym5_1 = round(Line1(1, 2) + 0.95*(Linen1_1(1, 2)-Line1(1, 2)));
Linem1_1 = [Line1(1, 1) ym1_1; Line1(2, 1) ym1_1];
Linem2_1 = [Line1(1, 1) ym2_1; Line1(2, 1) ym2_1];
Linem3_1 = [Line1(1, 1) ym3_1; Line1(2, 1) ym3_1];
Linem4_1 = [Line1(1, 1) ym4_1; Line1(2, 1) ym4_1];
Linem5_1 = [Line1(1, 1) ym5_1; Line1(2, 1) ym5_1];

ym1_2 = round(Linen1_1(1, 2) + 0.25*(Linen2_1(1, 2)-Linen1_1(1, 2)));
ym2_2 = round(Linen1_1(1, 2) + 0.40*(Linen2_1(1, 2)-Linen1_1(1, 2)));
ym3_2 = round(Linen1_1(1, 2) + 0.60*(Linen2_1(1, 2)-Linen1_1(1, 2)));
ym4_2 = round(Linen1_1(1, 2) + 0.75*(Linen2_1(1, 2)-Linen1_1(1, 2)));
ym5_2 = round(Linen1_1(1, 2) + 0.90*(Linen2_1(1, 2)-Linen1_1(1, 2)));
Linem1_2 = [Line1(1, 1) ym1_2; Line1(2, 1) ym1_2];
Linem2_2 = [Line1(1, 1) ym2_2; Line1(2, 1) ym2_2];
Linem3_2 = [Line1(1, 1) ym3_2; Line1(2, 1) ym3_2];
Linem4_2 = [Line1(1, 1) ym4_2; Line1(2, 1) ym4_2];
Linem5_2 = [Line1(1, 1) ym5_2; Line1(2, 1) ym5_2];

ym1_3 = round(Linen2_1(1, 2) + 0.25*(Linen3_1(1, 2)-Linen2_1(1, 2)));
ym2_3 = round(Linen2_1(1, 2) + 0.40*(Linen3_1(1, 2)-Linen2_1(1, 2)));
ym3_3 = round(Linen2_1(1, 2) + 0.60*(Linen3_1(1, 2)-Linen2_1(1, 2)));
ym4_3 = round(Linen2_1(1, 2) + 0.75*(Linen3_1(1, 2)-Linen2_1(1, 2)));
ym5_3 = round(Linen2_1(1, 2) + 0.90*(Linen3_1(1, 2)-Linen2_1(1, 2)));
Linem1_3 = [Line1(1, 1) ym1_3; Line1(2, 1) ym1_3];
Linem2_3 = [Line1(1, 1) ym2_3; Line1(2, 1) ym2_3];
Linem3_3 = [Line1(1, 1) ym3_3; Line1(2, 1) ym3_3];
Linem4_3 = [Line1(1, 1) ym4_3; Line1(2, 1) ym4_3];
Linem5_3 = [Line1(1, 1) ym5_3; Line1(2, 1) ym5_3];
xm1_1 = round(Line3(1, 1) + 0.07*(Linen1_2(1, 1)-Line3(1, 1)));
xm1_2 = round(Line3(1, 1) + 0.25*(Linen1_2(1, 1)-Line3(1, 1)));
xm1_3 = round(Line3(1, 1) + 0.43*(Linen1_2(1, 1)-Line3(1, 1)));
xm1_4 = round(Line3(1, 1) + 0.63*(Linen1_2(1, 1)-Line3(1, 1)));
xm1_5 = round(Line3(1, 1) + 0.83*(Linen1_2(1, 1)-Line3(1, 1)));
xm1_6 = round(Line3(1, 1) + 1.02*(Linen1_2(1, 1)-Line3(1, 1)));

Linem1_1_2 = [xm1_1 Line3(1, 2); xm1_1 Line3(2, 2)];
Linem1_2_2 = [xm1_2 Line3(1, 2); xm1_2 Line3(2, 2)];
Linem1_3_2 = [xm1_3 Line3(1, 2); xm1_3 Line3(2, 2)];
Linem1_4_2 = [xm1_4 Line3(1, 2); xm1_4 Line3(2, 2)];
Linem1_5_2 = [xm1_5 Line3(1, 2); xm1_5 Line3(2, 2)];
Linem1_6_2 = [xm1_6 Line3(1, 2); xm1_6 Line3(2, 2)];

xm2_1 = round(Linen2_2(1, 1) + 0.05*(Linen3_2(1, 1)-Linen2_2(1, 1)));
xm2_2 = round(Linen2_2(1, 1) + 0.22*(Linen3_2(1, 1)-Linen2_2(1, 1)));
xm2_3 = round(Linen2_2(1, 1) + 0.41*(Linen3_2(1, 1)-Linen2_2(1, 1)));
xm2_4 = round(Linen2_2(1, 1) + 0.58*(Linen3_2(1, 1)-Linen2_2(1, 1)));
xm2_5 = round(Linen2_2(1, 1) + 0.78*(Linen3_2(1, 1)-Linen2_2(1, 1)));
xm2_6 = round(Linen2_2(1, 1) + 0.98*(Linen3_2(1, 1)-Linen2_2(1, 1)));


Linem2_1_2 = [xm2_1 Line3(1, 2); xm2_1 Line3(2, 2)];
Linem2_2_2 = [xm2_2 Line3(1, 2); xm2_2 Line3(2, 2)];
Linem2_3_2 = [xm2_3 Line3(1, 2); xm2_3 Line3(2, 2)];
Linem2_4_2 = [xm2_4 Line3(1, 2); xm2_4 Line3(2, 2)];
Linem2_5_2 = [xm2_5 Line3(1, 2); xm2_5 Line3(2, 2)];
Linem2_6_2 = [xm2_6 Line3(1, 2); xm2_6 Line3(2, 2)];

xm3_1 = round(Linen4_2(1, 1) + 0.03*(Linen5_2(1, 1)-Linen4_2(1, 1)));
xm3_2 = round(Linen4_2(1, 1) + 0.22*(Linen5_2(1, 1)-Linen4_2(1, 1)));
xm3_3 = round(Linen4_2(1, 1) + 0.41*(Linen5_2(1, 1)-Linen4_2(1, 1)));
xm3_4 = round(Linen4_2(1, 1) + 0.58*(Linen5_2(1, 1)-Linen4_2(1, 1)));
xm3_5 = round(Linen4_2(1, 1) + 0.78*(Linen5_2(1, 1)-Linen4_2(1, 1)));
xm3_6 = round(Linen4_2(1, 1) + 0.98*(Linen5_2(1, 1)-Linen4_2(1, 1)));

Linem3_1_2 = [xm3_1 Line3(1, 2); xm3_1 Line3(2, 2)];
Linem3_2_2 = [xm3_2 Line3(1, 2); xm3_2 Line3(2, 2)];
Linem3_3_2 = [xm3_3 Line3(1, 2); xm3_3 Line3(2, 2)];
Linem3_4_2 = [xm3_4 Line3(1, 2); xm3_4 Line3(2, 2)];
Linem3_5_2 = [xm3_5 Line3(1, 2); xm3_5 Line3(2, 2)];
Linem3_6_2 = [xm3_6 Line3(1, 2); xm3_6 Line3(2, 2)];

xm4_1 = round(Linen6_2(1, 1) + 0.03*(Linen7_2(1, 1)-Linen6_2(1, 1)));
xm4_2 = round(Linen6_2(1, 1) + 0.22*(Linen7_2(1, 1)-Linen6_2(1, 1)));
xm4_3 = round(Linen6_2(1, 1) + 0.41*(Linen7_2(1, 1)-Linen6_2(1, 1)));
xm4_4 = round(Linen6_2(1, 1) + 0.58*(Linen7_2(1, 1)-Linen6_2(1, 1)));
xm4_5 = round(Linen6_2(1, 1) + 0.78*(Linen7_2(1, 1)-Linen6_2(1, 1)));
xm4_6 = round(Linen6_2(1, 1) + 0.98*(Linen7_2(1, 1)-Linen6_2(1, 1)));

Linem4_1_2 = [xm4_1 Line3(1, 2); xm4_1 Line3(2, 2)];
Linem4_2_2 = [xm4_2 Line3(1, 2); xm4_2 Line3(2, 2)];
Linem4_3_2 = [xm4_3 Line3(1, 2); xm4_3 Line3(2, 2)];
Linem4_4_2 = [xm4_4 Line3(1, 2); xm4_4 Line3(2, 2)];
Linem4_5_2 = [xm4_5 Line3(1, 2); xm4_5 Line3(2, 2)];
Linem4_6_2 = [xm4_6 Line3(1, 2); xm4_6 Line3(2, 2)];

ym1_4 = round(Line1(1, 2) - 0.18*(Linen1_1(1, 2)-Line1(1, 2)));
ym2_4 = round(Line1(1, 2) - 0.35*(Linen1_1(1, 2)-Line1(1, 2)));
ym3_4 = round(Line1(1, 2) - 0.50*(Linen1_1(1, 2)-Line1(1, 2)));
ym4_4 = round(Line1(1, 2) - 0.65*(Linen1_1(1, 2)-Line1(1, 2)));
ym5_4 = round(Line1(1, 2) - 0.80*(Linen1_1(1, 2)-Line1(1, 2)));
ym6_4 = round(Line1(1, 2) - 0.95*(Linen1_1(1, 2)-Line1(1, 2)));
ym7_4 = round(Line1(1, 2) - 1.10*(Linen1_1(1, 2)-Line1(1, 2)));
ym8_4 = round(Line1(1, 2) - 1.22*(Linen1_1(1, 2)-Line1(1, 2)));
ym9_4 = round(Line1(1, 2) - 1.35*(Linen1_1(1, 2)-Line1(1, 2)));
ym10_4 = round(Line1(1, 2) - 1.50*(Linen1_1(1, 2)-Line1(1, 2)));
ym11_4 = round(Line1(1, 2) - 1.65*(Linen1_1(1, 2)-Line1(1, 2)));

Linem1_4 = [Line1(1, 1) ym1_4; Line1(2, 1) ym1_4];
Linem2_4 = [Line1(1, 1) ym2_4; Line1(2, 1) ym2_4];
Linem3_4 = [Line1(1, 1) ym3_4; Line1(2, 1) ym3_4];
Linem4_4 = [Line1(1, 1) ym4_4; Line1(2, 1) ym4_4];
Linem5_4 = [Line1(1, 1) ym5_4; Line1(2, 1) ym5_4];
Linem6_4 = [Line1(1, 1) ym6_4; Line1(2, 1) ym6_4];
Linem7_4 = [Line1(1, 1) ym7_4; Line1(2, 1) ym7_4];
Linem8_4 = [Line1(1, 1) ym8_4; Line1(2, 1) ym8_4];
Linem9_4 = [Line1(1, 1) ym9_4; Line1(2, 1) ym9_4];
Linem10_4 = [Line1(1, 1) ym10_4; Line1(2, 1) ym10_4];
Linem11_4 = [Line1(1, 1) ym11_4; Line1(2, 1) ym11_4];

Dom(1).Loc = [Line1(1, 2) Linen1_1(1, 2)];
Dom(1).y = [ym1_1 ym2_1 ym3_1 ym4_1 ym5_1];
xt{1} = [xm1_1 xm1_2 xm1_3 xm1_4 xm1_5 xm1_6];
xt{2} = [xm2_1 xm2_2 xm2_3 xm2_4 xm2_5 xm2_6];
xt{3} = [xm3_1 xm3_2 xm3_3 xm3_4 xm3_5 xm3_6];
xt{4} = [xm4_1 xm4_2 xm4_3 xm4_4 xm4_5 xm4_6];
Dom(1).x = xt;

Dom(2).Loc = [Linen1_1(1, 2) Linen2_1(1, 2)];
Dom(2).y = [ym1_2 ym2_2 ym3_2 ym4_2 ym5_2];
xt{1} = [xm1_1 xm1_2 xm1_3 xm1_4 xm1_5 xm1_6];
xt{2} = [xm2_1 xm2_2 xm2_3 xm2_4 xm2_5 xm2_6];
xt{3} = [xm3_1 xm3_2 xm3_3 xm3_4 xm3_5 xm3_6];
xt{4} = [xm4_1 xm4_2 xm4_3 xm4_4 xm4_5 xm4_6];
Dom(2).x = xt;

Dom(3).Loc = [Linen2_1(1, 2) Linen3_1(1, 2)];
Dom(3).y = [ym1_3 ym2_3 ym3_3 ym4_3 ym5_3];
xt{1} = [xm1_1 xm1_2 xm1_3 xm1_4 xm1_5 xm1_6];
xt{2} = [xm2_1 xm2_2 xm2_3 xm2_4 xm2_5 xm2_6];
xt{3} = [xm3_1 xm3_2 xm3_3 xm3_4 xm3_5 xm3_6];
xt{4} = [xm4_1 xm4_2 xm4_3 xm4_4 xm4_5 xm4_6];
Dom(3).x = xt;

Aom(1).Loc = [ym7_4 ym6_4];
Aom(1).y = [ym7_4 ym6_4];
Aom(1).x = [xm1_5 xm1_6];
Aom(2).Loc = [ym11_4 ym1_4];
Aom(2).y = [ym11_4 ym10_4 ym9_4 ym8_4 ...
    ym7_4 ym6_4 ym5_4 ym4_4 ...
    ym3_4 ym2_4 ym1_4];
Aom(2).x = [xm2_5 xm2_6 xm3_1 xm3_2 xm3_3 ...
    xm3_4 xm3_5 xm3_6 xm4_1 xm4_2];
Aom(3).Loc = [ym11_4 ym1_4];
Aom(3).y = [ym11_4 ym10_4 ym9_4 ym8_4 ...
    ym7_4 ym6_4 ym5_4 ym4_4 ...
    ym3_4 ym2_4 ym1_4];
Aom(3).x = [xm4_5 xm4_6];

aw = ['A' 'B' 'C' 'D'];

for i = 1 : length(stats1)
    Answer(i).Loc = [];
    Answer(i).no = [];
    Answer(i).aw = []; 
end
for i = 1 : length(stats1)
    temp = stats1(i).Centroid; 
    for i1 = 1 : length(Dom)
        Loc = Dom(i1).Loc; 
        if temp(2) >= Loc(1) && temp(2) <= Loc(2)
            x = Dom(i1).x;
            y = Dom(i1).y;
            i_y = (i1-1)*20;
            for i2 = 1 : length(x)
                xt = x{i2};
                for i3 = 1 : length(xt)-1
                    if temp(1) >= xt(i3) && temp(1) <= xt(i3+1)
                        i_x = (i2-1)*5 + i3;
                        break;
                    end
                end
            end
            i_n = i_y + i_x;
            for i4 = 1 : length(y)-1
                if temp(2) >= y(i4) && temp(2) <= y(i4+1)
                    i_a = aw(i4);
                    break;
                end
            end
        end
    end
    Answer(i_n).Loc = [Answer(i_n).Loc; temp];
    Answer(i_n).no = i_n;
    Answer(i_n).aw = [Answer(i_n).aw i_a];
end

Loc1 = Aom(1).Loc;
x1 = Aom(1).x;
y1 = Aom(1).y;
Loc2 = Aom(2).Loc;
x2 = Aom(2).x;
y2 = Aom(2).y;
Loc3 = Aom(3).Loc;
x3 = Aom(3).x;
y3 = Aom(3).y;
% 科目字符串
strs = ['政治'; '语文'; '数学'; '物理'; '化学'; '外语'; '历史'; '地理'; '生物'];

for i = 1 : 3
    Bn(i).result = []; % 涂抹结果可以存储多个涂抹信息）
    Bn(i).Loc = []; % 位置（可以存储多个位置信息）
end
for i = 1 : length(stats2)
    temp = stats2(i).Centroid; 
    if temp(1) >= x1(1) && temp(1) <= x1(2) && ...
            temp(2) >= y1(1) && temp(2) <= y1(2)
        Bn(1).Loc = temp; 
        Bn(1).result = 1;
    end
    if temp(2) >= Loc2(1) && temp(2) <= Loc2(2)
        for i1 = 1 : length(x2)-1
            if temp(1) >= x2(i1) && temp(1) <= x2(i1+1)
                for i2 = 1 : length(y2)-1
                    if temp(2) >= y2(i2) && temp(2) <= y2(i2+1)
                        Bn(2).Loc = [Bn(2).Loc; temp]; 
                        Bn(2).result = [Bn(2).result; i2-1];
                    end
                end
            end
        end
    end
    if temp(2) >= Loc3(1) && temp(2) <= Loc3(2) && temp(1) >= x3(1) && temp(1) <= x3(2)
        for i1 = 1 : length(y3)-1
            if temp(2) >= y3(i1) && temp(2) <= y3(i1+1)
                Bn(3).Loc = [Bn(3).Loc; temp];
                Bn(3).result = [Bn(3).result; strs(i1, :)]; 
            end
        end
    end
end

if flag
    figure;
    imshow(Img); title('网格线生成', 'FontWeight', 'Bold');
    hold on;
    plot(Linem1_1(:, 1), Linem1_1(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem2_1(:, 1), Linem2_1(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem3_1(:, 1), Linem3_1(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem4_1(:, 1), Linem4_1(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem5_1(:, 1), Linem5_1(:, 2), 'r-', 'LineWidth', 1);
    
    plot(Linem1_2(:, 1), Linem1_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem2_2(:, 1), Linem2_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem3_2(:, 1), Linem3_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem4_2(:, 1), Linem4_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem5_2(:, 1), Linem5_2(:, 2), 'r-', 'LineWidth', 1);
    
    plot(Linem1_3(:, 1), Linem1_3(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem2_3(:, 1), Linem2_3(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem3_3(:, 1), Linem3_3(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem4_3(:, 1), Linem4_3(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem5_3(:, 1), Linem5_3(:, 2), 'r-', 'LineWidth', 1);
    
    plot(Linem1_4(:, 1), Linem1_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem2_4(:, 1), Linem2_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem3_4(:, 1), Linem3_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem4_4(:, 1), Linem4_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem5_4(:, 1), Linem5_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem6_4(:, 1), Linem6_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem7_4(:, 1), Linem7_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem8_4(:, 1), Linem8_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem9_4(:, 1), Linem9_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem10_4(:, 1), Linem10_4(:, 2), 'b-', 'LineWidth', 1);
    plot(Linem11_4(:, 1), Linem11_4(:, 2), 'b-', 'LineWidth', 1);
    
    plot(Linem1_1_2(:, 1), Linem1_1_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem1_2_2(:, 1), Linem1_2_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem1_3_2(:, 1), Linem1_3_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem1_4_2(:, 1), Linem1_4_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem1_5_2(:, 1), Linem1_5_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem1_6_2(:, 1), Linem1_6_2(:, 2), 'r-', 'LineWidth', 1);
    
    plot(Linem2_1_2(:, 1), Linem2_1_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem2_2_2(:, 1), Linem2_2_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem2_3_2(:, 1), Linem2_3_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem2_4_2(:, 1), Linem2_4_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem2_5_2(:, 1), Linem2_5_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem2_6_2(:, 1), Linem2_6_2(:, 2), 'r-', 'LineWidth', 1);
    
    plot(Linem3_1_2(:, 1), Linem3_1_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem3_2_2(:, 1), Linem3_2_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem3_3_2(:, 1), Linem3_3_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem3_4_2(:, 1), Linem3_4_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem3_5_2(:, 1), Linem3_5_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem3_6_2(:, 1), Linem3_6_2(:, 2), 'r-', 'LineWidth', 1);
    
    plot(Linem4_1_2(:, 1), Linem4_1_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem4_2_2(:, 1), Linem4_2_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem4_3_2(:, 1), Linem4_3_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem4_4_2(:, 1), Linem4_4_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem4_5_2(:, 1), Linem4_5_2(:, 2), 'r-', 'LineWidth', 1);
    plot(Linem4_6_2(:, 1), Linem4_6_2(:, 2), 'r-', 'LineWidth', 1);
    hold off;
    set(gcf, 'units', 'normalized', 'position', [0 0 1 1]);
    figure;
    imshow(Img); title('结果分析标记', 'FontWeight', 'Bold'); hold on;
    for i = 1 : length(Answer)
        if ~isempty(Answer(i).Loc)
            tempi = Answer(i).Loc; 
            awi = Answer(i).aw;
            for j = 1 : size(tempi, 1)
                tempij = tempi(j, :);
                awij = awi(j);
                text(tempij(1), tempij(2), awij, 'color', 'b');
            end
        end
    end
    Err = [0 0 0];
    if ~isempty(Bn(1).Loc)
        tempi = Bn(1).Loc;
        resulti = Bn(1).result;
        for j = 1 : size(tempi, 1)
            tempij = tempi(j, :);
            resultij = resulti(j, :);
            text(tempij(1), tempij(2), num2str(resultij), 'color', 'b');
        end
    else
        Err(1) = 1;
    end
    if ~isempty(Bn(2).Loc)
        tempi = Bn(2).Loc;
        resulti = Bn(2).result;
        for j = 1 : size(tempi, 1)
            tempij = tempi(j, :);
            resultij = resulti(j, :);
            text(tempij(1), tempij(2), num2str(resultij), 'color', 'b');
        end
        if size(tempi, 1) ~= 9
            Err(2) = 1;
        end
    else
        Err(2) = 1;
    end
    if ~isempty(Bn(3).Loc)
        tempi = Bn(3).Loc; 
        resulti = Bn(3).result; 
        for j = 1 : size(tempi, 1)
            tempij = tempi(j, :);
            resultij = resulti(j, :);
            text(tempij(1), tempij(2), num2str(resultij), 'color', 'b');
        end
        if size(tempi, 1) ~= 1
            Err(3) = 1;
        end
    else
        Err(3) = 1;
    end
    hold off;
    set(gcf, 'units', 'normalized', 'position', [0 0 1 1]);
    if Err(1)
        msgbox('试卷类型报警！', '提示信息', 'modal');
    end
    if Err(2)
        msgbox('准考证报警，请检查是否涂抹正确！', '提示信息', 'modal');
    end
    if Err(3)
        msgbox('考试科目报警！', '提示信息', 'modal');
    end    
end