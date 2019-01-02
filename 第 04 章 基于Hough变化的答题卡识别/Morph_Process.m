function [bw2, Loc] = Morph_Process(bw1, flag)

if nargin < 2
    flag = 1;
end
bw2 = bwareaopen(bw1, round(0.005*numel(bw1)/100));
bws = sum(bw2);
inds = find(bws>round(sum(bw2(:))*0.015));
Loc = inds(1)-5;
bw2(:, Loc:end) = 0;
bw2 = bwareaopen(bw2, round(0.005*numel(bw1)/100));
if flag
    figure('units', 'normalized', 'position', [0 0 1 1]);
    subplot(1, 2, 1); imshow(bw1, []); title('´ý²Ù×÷Í¼Ïñ', 'FontWeight', 'Bold');
    subplot(1, 2, 2); imshow(bw2, []); title('ÂË²¨Í¼Ïñ', 'FontWeight', 'Bold');
end