function [Xpoints1, Ypoints1, Xpoints2, Ypoints2, tms, yc] = ProcessVideo(videoFilePath)
if nargin < 1
    videoFilePath = fullfile(pwd, 'video/video.avi');
end
% clc; clear all; close all;
% videoFilePath = fullfile(pwd, 'video/video.avi');
time_start = cputime;
[pathstr, name, ext] = fileparts(videoFilePath);
foldername = fullfile(pwd, sprintf('%s_images', name));
T = 1;
P = 5;
W1 = [75 95];
L1 = [360 17];
W2 = [55 55];
L2 = [35 1565];
Xpoints1 = [];
Ypoints1 = [];
Xpoints2 = [];
Ypoints2 = [];
Xpointst1 = [];
Ypointst1 = [];
Xpointst2 = [];
Ypointst2 = [];
figure('Position', get(0, 'ScreenSize'));
hg1 = subplot(1, 2, 1);
hg2 = subplot(1, 2, 2);
for frame = 1:146
    filename = fullfile(foldername, sprintf('%04d.jpg', frame));
    R = imread(filename);
    Imi = R;
    xc1 = 0;
    yc1 = 0;
    xc2 = 0;
    yc2 = 0;
    if frame > 72
        I = rgb2hsv(Imi);
        I = I(:,:,1);
        I = roicolor(I, 0.1, 0.17);
        MeanConverging1 = 1;
        while MeanConverging1
            M00 = 0.0;
            for i = L1(1)-P : (L1(1)+W1(1)+P)
                for j = L1(2)-P : (L1(2)+W1(2)+P)
                    if i > size(I,1) || j > size(I,2) || i < 1 || j < 1
                        continue;
                    end
                    M00 = M00 + double(I(i,j));
                end
            end
            M10 = 0.0;
            for i = L1(1)-P : (L1(1)+W1(1)+P)
                for j = L1(2)-P : (L1(2)+W1(2)+P)
                    if i > size(I,1) || j > size(I,2) || i < 1 || j < 1
                        continue;
                    end
                    M10 = M10 + i * double(I(i,j));
                end
            end
            M01 = 0.0;
            for i = L1(1)-P : (L1(1)+W1(1)+P)
                for j = L1(2)-P : (L1(2)+W1(2)+P)
                    if i > size(I,1) || j > size(I,2)|| i < 1 || j < 1
                        continue;
                    end
                    M01 = M01 + j * double(I(i,j));
                end
            end
            xc1 = round(M10 / M00);
            yc1 = round(M01 / M00);
            oldL = L1;
            L1 = [floor(xc1 - (W1(1)/2)) floor(yc1 - (W1(2)/2))];
            if abs(oldL(1)-L1(1)) < T || abs(oldL(2)-L1(2)) < T
                MeanConverging1 = 0;
            end
        end
        s = round(1.1 * sqrt(M00));
        W1 = [ s floor(1.2*s) ];
        L1 = [floor(xc1 - (W1(1)/2)) floor(yc1 - (W1(2)/2))];
        Xpoints1 = [Xpoints1 xc1];
        Ypoints1 = [Ypoints1 yc1];
        yc1t = yc1+randi(2,1,1)*25;
        xc1t = xc1+randi(2,1,1)*25;
        Xpointst1 = [Xpointst1 xc1t];
        Ypointst1 = [Ypointst1 yc1t];
    else
        Xpoints1 = [Xpoints1 NaN];
        Ypoints1 = [Ypoints1 NaN];
        Xpointst1 = [Xpointst1 NaN];
        Ypointst1 = [Ypointst1 NaN];
    end
    if frame > 90 && frame < 146
        R = Imi;
        I = rgb2ycbcr(R);
        I = I(:,:,1);
        I = mat2gray(I);
        I = roicolor(I, 0.05, 0.3);
        MeanConverging2 = 1;
        while MeanConverging2
            M00 = 0.0;
            M00 = 0.0;
            for i = L2(1)-P : (L2(1)+W2(1)+P),
                for j = L2(2)-P : (L2(2)+W2(2)+P),
                    if i > size(I,1) || j > size(I,2) || i < 1 || j < 1
                        continue;
                    end
                    M00 = M00 + double(I(i,j));
                end
            end
            M10 = 0.0;
            for i = L2(1)-P : (L2(1)+W2(1)+P),
                for j = L2(2)-P : (L2(2)+W2(2)+P),
                    if i > size(I,1) || j > size(I,2) || i < 1 || j < 1
                        continue;
                    end
                    M10 = M10 + i * double(I(i,j));
                end
            end
            M01 = 0.0;
            for i = L2(1)-P : (L2(1)+W2(1)+P),
                for j = L2(2)-P : (L2(2)+W2(2)+P),
                    if i > size(I,1) || j > size(I,2)|| i < 1 || j < 1
                        continue;
                    end
                    M01 = M01 + j * double(I(i,j));
                end
            end
            xc2 = round(M10 / M00);
            yc2 = round(M01 / M00);
            oldL = L2;
            L2 = [floor(xc2 - (W2(1)/2)) floor(yc2 - (W2(2)/2))];
            if abs(oldL(1)-L2(1)) < T || abs(oldL(2)-L2(2)) < T
                MeanConverging2 = 0;
            end
        end
        s = round(1.1 * sqrt(M00));
        W2 = [ s      floor(1.2*s) ];
        L2 = [floor(xc2 - (W2(1)/2)) floor(yc2 - (W2(2)/2))];
        Xpoints2 = [Xpoints2 xc2];
        Ypoints2 = [Ypoints2 yc2];
        yc2t = yc2+randi(2,1,1)*25;
        xc2t = xc2+randi(2,1,1)*25;
        Xpointst2 = [Xpointst2 xc2t];
        Ypointst2 = [Ypointst2 yc2t];
    else
        Xpoints2 = [Xpoints2 NaN];
        Ypoints2 = [Ypoints2 NaN];
        Xpointst2 = [Xpointst2 NaN];
        Ypointst2 = [Ypointst2 NaN];
    end
    axes(hg1); cla;
    imshow(Imi, []); hold on;
    if xc1 > 0 && yc1 > 0
        plot(yc1, xc1, 'go', 'MarkerFaceColor', 'g');
        plot(yc1t, xc1t, 'g+', 'MarkerFaceColor', 'g');
    end
    if xc2 > 0 && yc2 > 0
        plot(yc2, xc2, 'bo', 'MarkerFaceColor', 'b');
        plot(yc2t, xc2t, 'b+', 'MarkerFaceColor', 'b');
    end
    hold off; title(sprintf('%04d֡', frame));
    bg = true(size(Imi,1), size(Imi,2));
    axes(hg2); cla; imshow(bg);
    hold on; box on;
    plot(Ypoints1, Xpoints1, 'go-', 'MarkerFaceColor', 'g');
    plot(Ypoints2, Xpoints2, 'bo-', 'MarkerFaceColor', 'b');
    hold off; title(sprintf('%04d֡', frame));
    pause(0.001);
end
time_end = cputime;
tms = time_end - time_start;
yc.Xpointst1 = Xpointst1;
yc.Ypointst1 = Ypointst1;
yc.Xpointst2 = Xpointst2;
yc.Ypointst2 = Ypointst2;