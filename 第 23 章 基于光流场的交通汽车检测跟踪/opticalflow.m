clear all
videofile = 'viptraffic.avi';
info = mmfileinfo(videofile);
cols=info.Video.Width;
rows=info.Video.Height;
hReader = vision.VideoFileReader(videofile,...
    'ImageColorSpace', 'RGB',...      
    'VideoOutputDataType', 'single'); 
hFlow = vision.OpticalFlow( ...
    'OutputValue', 'Horizontal and vertical components in complex form', ...
    'ReferenceFrameDelay', 3,...
    'Method','Horn-Schunck');
hMean1 = vision.Mean; 
hMean2 = vision.Mean('RunningMean', true); 
hFilter = vision.MedianFilter;
hClose = vision.MorphologicalClose('Neighborhood', strel('line',5,45));
hBlob = vision.BlobAnalysis(...
    'CentroidOutputPort', false,...
    'AreaOutputPort', true, ...
    'BoundingBoxOutputPort', true,...
    'OutputDataType', 'double', ...
    'MinimumBlobArea', 250,...
    'MaximumBlobArea', 3600,...
    'MaximumCount', 80);
hErode = vision.MorphologicalErode('Neighborhood', strel('square',2));
hShape1 = vision.ShapeInserter(...
    'BorderColor', 'Custom', ...
    'CustomBorderColor', [0 1 0]); 
hShape2 = vision.ShapeInserter(...
    'Shape','Lines', ...
    'BorderColor', 'Custom', ...
    'CustomBorderColor', [255 255 0]); 
hText = vision.TextInserter(...
    'Text', '%4d',...
    'Location',  [1 1], ...
    'Color', [1 1 1],...
    'FontSize', 12);
sz = get(0,'ScreenSize');  
pos = [(sz(3)-4*(cols+75))/2, (sz(4)-rows)/2 cols+60 rows+80];  
hVideo1 = vision.VideoPlayer('Name','Original Video','Position',pos);
pos(1) = pos(1)+cols+75;
hVideo2 = vision.VideoPlayer('Name','Motion Vector','Position',pos);
pos(1) = pos(1)+cols+75;
hVideo3 = vision.VideoPlayer('Name','Thresholded Video','Position',pos);
pos(1) = pos(1)+cols+75; 
hVideo4 = vision.VideoPlayer('Name','Results Video','Position',pos);
[xpos,ypos]=meshgrid(1:5:cols,1:5:rows);
xpos=xpos(:);
ypos=ypos(:);
locs=sub2ind([rows,cols],ypos,xpos);
while ~isDone(hReader)
    pause(0.3);
    frame  = step(hReader);
    gray = rgb2gray(frame);
    flow = step(hFlow, gray);
    lines = [xpos, ypos, xpos+20*real(flow(locs)), ypos+20*imag(flow(locs))];
    vector = step(hShape2, frame, lines);
    magnitude = flow .* conj(flow);
    threshold = 0.5 * step(hMean2, step(hMean1, magnitude));
    carobj = step(hFilter, magnitude >= threshold);
    carobj = step(hClose, step(hErode, carobj));
    [area, bbox] = step(hBlob, carobj);
    grow=22;
    idx = bbox(:,1) > grow;
    ratio = zeros(length(idx), 1);
    ratio(idx) = single(area(idx,1))./single(bbox(idx,3).*bbox(idx,4));
    flag = ratio > 0.4;
    count = int32(sum(flag));
    bbox(~flag, :) = int32(-1);
    result = step(hShape1, frame, bbox);
    result(grow:grow+1,:,:) = 1;
    result(1:15,1:30,:) = 0;
    result = step(hText, result, count);
    step(hVideo1, frame);  
    step(hVideo2, vector);    
    step(hVideo3, carobj);       
    step(hVideo4, result);    
end
release(hReader);