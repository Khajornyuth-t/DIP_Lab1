%% Quistion:
% 
%% Q1: - Manual RGB to Gray Conversion
% Load Lena color image
lena_org_img = imread('./data/input/lena_color.jpg');

% แยก channel R,G,B
R = lena_org_img(:,:,1);
G = lena_org_img(:,:,2);
B = lena_org_img(:,:,3);

% --- 1) Equal Weight Method ---
gray_equal = uint8(0.33*double(R) + 0.33*double(G) + 0.33*double(B));

% --- 2) Weighted by Wavelength ---
gray_weighted = uint8(0.3*double(R) + 0.59*double(G) + 0.11*double(B));

% --- แสดงผล ---
figure;
subplot(1,3,1);
imshow(lena_org_img);
title('Original RGB');

subplot(1,3,2);
imshow(gray_equal);
title('Gray (Equal 0.33,0.33,0.33)');

subplot(1,3,3);
imshow(gray_weighted);
title('Gray (0.3,0.59,0.11)');

%% Q2: - Rotation lena_color.jpg 180 degrees
% Rotate Lena color image 180 degrees
lena_rot180_img = rot90(lena_org_img, 2);

% Display rotated image
figure;
imshow(lena_rot180_img);

%% Q3 - Image Mosaic from Lena and Peppers (Grayscale)

% โหลดภาพและแปลงเป็นขาวดำ
lena = rgb2gray(imread('./data/input/lena_color.jpg'));
peppers = rgb2gray(imread('./data/input/peppers.png'));

% ปรับขนาดให้เท่ากัน
[rows, cols] = size(lena);
peppers_resized = imresize(peppers, [rows cols]);

% ตัดครึ่ง
half_row = round(rows/2);
half_col = round(cols/2);

lena_tl = lena(1:half_row, 1:half_col);             % Top-left
lena_br = lena(half_row+1:end, half_col+1:end);     % Bottom-right

peppers_tr = peppers_resized(1:half_row, half_col+1:end);  % Top-right
peppers_bl = peppers_resized(half_row+1:end, 1:half_col);  % Bottom-left

% รวม 4 ส่วนเข้าด้วยกัน
top_half    = [lena_tl, peppers_tr];
bottom_half = [peppers_bl, lena_br];
mosaic_img  = [top_half; bottom_half];

% แสดงผล
figure;
imshow(mosaic_img);
title('Khajornyuth');

%% Q4 - Place Lena on Peppers Background

% โหลดภาพและแปลงเป็นขาวดำ
lena = rgb2gray(imread('./data/input/lena_color.jpg'));
peppers = rgb2gray(imread('./data/input/peppers.png'));
% ปรับขนาดภาพ Lena ให้เล็กลง (เช่น 50% ของ peppers)
[rowsP, colsP] = size(peppers);
lena_small = imresize(lena, 0.5);

% หมุน Lena 180 องศา
lena_rot180 = rot90(lena_small, 2);

% คำนวณตำแหน่งวาง (ให้ Lena อยู่ตรงกลาง)
[rowsL, colsL] = size(lena_rot180);
row_start = floor((rowsP - rowsL) / 2) + 1;
col_start = floor((colsP - colsL) / 2) + 1;

% ทำสำเนาพื้นหลัง Peppers
result = peppers;

% วาง Lena ลงบนพื้นหลัง
result(row_start:row_start+rowsL-1, col_start:col_start+colsL-1) = lena_rot180;

% แสดงผล
figure;
imshow(result);
title('Khajornyuth');

%% Q5 - Color Mix Square 4x4 (Peppers <-> Lena)
I1 = imread('./data/input/peppers.png');        % สี
I2 = imread('./data/input/lena_color.jpg');     % สี

% ให้สองภาพมีขนาดเท่ากันและหารด้วย 4 ลงตัว
N = 4;                                   % แถว×คอลัมน์ของบล็อค
H = 800; W = 800;                        % ขนาดเป้าหมาย (ปรับได้)
I1 = imresize(I1, [H W]);
I2 = imresize(I2, [H W]);

% แบ่งเป็นบล็อคย่อย
hr = H / N; hc = W / N;
I1c = mat2cell(I1, hr*ones(1,N), hc*ones(1,N), 3);
I2c = mat2cell(I2, hr*ones(1,N), hc*ones(1,N), 3);

% สลับแบบกระดานหมากรุก (checkerboard)
M = I1c;  % เตรียมผลลัพธ์ในรูป cell
for r = 1:N
    for c = 1:N
        if mod(r+c,2)==0
            M{r,c} = I1c{r,c};
        else
            M{r,c} = I2c{r,c};
        end
    end
end

% (ตัวเลือก) หมุนบางบล็อคเพื่อให้ลุคคล้ายตัวอย่าง
rotate_idx = [2 3; 3 2];   % ตำแหน่งที่จะหมุน 90°
for k = 1:size(rotate_idx,1)
    r = rotate_idx(k,1); c = rotate_idx(k,2);
    M{r,c} = rot90(M{r,c}, 1);
end

out = cell2mat(M);
figure; imshow(out);
%title('Color Mix Square 4x4');

%% Q6 - Grayscale Mix Square 4x4 (Peppers <-> Lena)
lena    = rgb2gray(imread('./data/input/lena_color.jpg'));
peppers = rgb2gray(imread('./data/input/peppers.png'));

N = 4;
H = 800; W = 800;
I1 = imresize(peppers, [H W]);   % พื้น Peppers
I2 = imresize(lena,    [H W]);   % Lena

hr = H / N; hc = W / N;
I1c = mat2cell(I1, hr*ones(1,N), hc*ones(1,N));
I2c = mat2cell(I2, hr*ones(1,N), hc*ones(1,N));

M = I1c;
for r = 1:N
    for c = 1:N
        if mod(r+c,2)==0
            M{r,c} = I1c{r,c};
        else
            M{r,c} = I2c{r,c};
        end
    end
end

% (ตัวเลือก) หมุนบางบล็อค 180° ให้มีลูกเล่น
for r = 2:2:N-1
    for c = 2:2:N-1
        M{r,c} = rot90(M{r,c}, 2);
    end
end

out = cell2mat(M);
figure; imshow(out); title('Mix Square');


%% Q7 - Color Tiling 3x3 (Lena <-> Peppers)
I1 = imread('./data/input/peppers.png');        % สี
I2 = imread('./data/input/lena_color.jpg');     % สี

% ให้ขนาดเท่ากันก่อน
tileSize = [256 256];       % ปรับได้
I1 = imresize(I1, tileSize);
I2 = imresize(I2, tileSize);

N = 3;                      % จำนวนแถว/คอลัมน์ของกระเบื้อง
C = cell(N,N);
for r = 1:N
    for c = 1:N
        if mod(r+c,2)==0, C{r,c} = I1; else, C{r,c} = I2; end
    end
end
out = cell2mat(C);

figure; imshow(out); title('Q7 - Color Checkerboard 3x3');

%% Q8 - Grayscale Tiling 3x3 (Lena <-> Peppers)
G1 = rgb2gray(imread('./data/input/peppers.png'));
G2 = rgb2gray(imread('./data/input/lena_color.jpg'));

tileSize = [256 256];
G1 = imresize(G1, tileSize);
G2 = imresize(G2, tileSize);

N = 3;
C = cell(N,N);
for r = 1:N
    for c = 1:N
        if mod(r+c,2)==0, C{r,c} = G1; else, C{r,c} = G2; end
    end
end
out = cell2mat(C);

figure; imshow(out); title('Q8 - Grayscale Checkerboard 3x3');