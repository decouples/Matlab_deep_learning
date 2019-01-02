function words = Main_Process(bw, flag_display)

if nargin < 2
    flag_display = 1;
end
[m, n] = size(bw);
k1 = 1;
k2 = 1;
s = sum(bw); 
j = 1;
while j ~= n
    while s(j) == 0 && j <= n-1
        j = j + 1;
    end
    k1 = j-1;
    while s(j) ~= 0 && j <= n-1
        j = j + 1;
    end
    k2 = j-1;
    Tol = round(n/6.5); 
    if k2-k1 > Tol
        [val, num] = min(sum(bw(:, [k1+5:k2-5])));
        bw(:, k1+num+5)=0;  
    end
end

bw = Segmation(bw);
[m, n] = size(bw);
wideTol = round(n/20);
rateTol = 0.25;
flag = 0;
word1 = [];
while flag == 0
    [m, n] = size(bw);
    left = 1;
    wide = 0;
    while sum(bw(:,wide+1)) ~= 0
        wide = wide+1;
    end
    if wide < wideTol
        bw(:, 1:wide) = 0; 
        bw = Segmation(bw);
    else
        temp = Segmation(imcrop(bw, [1 1 wide m]));
        [m, n] = size(temp);
        tall = sum(temp(:)); 
        two_thirds = sum(sum( temp(round(m/3):2*round(m/3), :) ));
        rate = two_thirds/tall; 
        if rate > rateTol
            flag = 1;
            word1 = temp;  
        end
        bw(:, 1:wide) = 0; 
        bw = Segmation(bw);
    end
end
[word2, bw] = Word_Segmation(bw);
[word3, bw] = Word_Segmation(bw);
[word4, bw] = Word_Segmation(bw);
[word5, bw] = Word_Segmation(bw);
[word6, bw] = Word_Segmation(bw);
[word7, bw] = Word_Segmation(bw);
wid = [size(word1, 2) size(word2, 2) size(word3, 2) ...
    size(word4, 2) size(word5, 2) size(word6, 2) size(word7, 2)];
[maxwid, indmax] = max(wid);
maxwid = maxwid + 10;
wordi = word1;
wordi = [zeros(size(wordi, 1), round((maxwid-size(word1, 2))/2)) wordi zeros(size(wordi, 1), round((maxwid-size(word1, 2))/2))];
word1 = wordi;

wordi = word2;
wordi = [zeros(size(wordi, 1), round((maxwid-size(word2, 2))/2)) wordi zeros(size(wordi, 1), round((maxwid-size(word2, 2))/2))];
word2 = wordi;

wordi = word3;
wordi = [zeros(size(wordi, 1), round((maxwid-size(word3, 2))/2)) wordi zeros(size(wordi, 1), round((maxwid-size(word3, 2))/2))];
word3 = wordi;

wordi = word4;
wordi = [zeros(size(wordi, 1), round((maxwid-size(word4, 2))/2)) wordi zeros(size(wordi, 1), round((maxwid-size(word4, 2))/2))];
word4 = wordi;

wordi = word5;
wordi = [zeros(size(wordi, 1), round((maxwid-size(word5, 2))/2)) wordi zeros(size(wordi, 1), round((maxwid-size(word5, 2))/2))];
word5 = wordi;

wordi = word6;
wordi = [zeros(size(wordi, 1), round((maxwid-size(word6, 2))/2)) wordi zeros(size(wordi, 1), round((maxwid-size(word6, 2))/2))];
word6 = wordi;

wordi = word7;
wordi = [zeros(size(wordi, 1), round((maxwid-size(word7, 2))/2)) wordi zeros(size(wordi, 1), round((maxwid-size(word7, 2))/2))];
word7 = wordi;

word11 = imresize(word1, [40 20]);
word21 = imresize(word2, [40 20]);
word31 = imresize(word3, [40 20]);
word41 = imresize(word4, [40 20]);
word51 = imresize(word5, [40 20]);
word61 = imresize(word6, [40 20]);
word71 = imresize(word7, [40 20]);

words.word1 = word11;
words.word2 = word21;
words.word3 = word31;
words.word4 = word41;
words.word5 = word51;
words.word6 = word61;
words.word7 = word71;

if flag_display
    figure;
    subplot(2, 7, 1); imshow(word1); title('×Ö·û1', 'FontWeight', 'Bold');
    subplot(2, 7, 2); imshow(word2); title('×Ö·û2', 'FontWeight', 'Bold');
    subplot(2, 7, 3); imshow(word3); title('×Ö·û3', 'FontWeight', 'Bold');
    subplot(2, 7, 4); imshow(word4); title('×Ö·û4', 'FontWeight', 'Bold');
    subplot(2, 7, 5); imshow(word5); title('×Ö·û5', 'FontWeight', 'Bold');
    subplot(2, 7, 6); imshow(word6); title('×Ö·û6', 'FontWeight', 'Bold');
    subplot(2, 7, 7); imshow(word7); title('×Ö·û7', 'FontWeight', 'Bold');  
    
    subplot(2, 7, 8); imshow(word11); title('×Ö·û1', 'FontWeight', 'Bold');
    subplot(2, 7, 9); imshow(word21); title('×Ö·û2', 'FontWeight', 'Bold');
    subplot(2, 7, 10); imshow(word31); title('×Ö·û3', 'FontWeight', 'Bold');
    subplot(2, 7, 11); imshow(word41); title('×Ö·û4', 'FontWeight', 'Bold');
    subplot(2, 7, 12); imshow(word51); title('×Ö·û5', 'FontWeight', 'Bold');
    subplot(2, 7, 13); imshow(word61); title('×Ö·û6', 'FontWeight', 'Bold');
    subplot(2, 7, 14); imshow(word71); title('×Ö·û7', 'FontWeight', 'Bold');
end