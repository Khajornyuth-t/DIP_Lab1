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

% --- Display ---
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

% Load original images and convert to grayscale
lena = rgb2gray(imread('./data/input/lena_color.jpg'));
peppers = rgb2gray(imread('./data/input/peppers.png'));

% Adjust size of peppers to match lena
[rows, cols] = size(lena);
peppers_resized = imresize(peppers, [rows cols]);

% half size of lena
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

% display the mosaic image
figure;
imshow(mosaic_img);
title('Khajornyuth');

%% Q4 - Place Lena on Peppers Background

% Load images and convert to grayscale
lena = rgb2gray(imread('./data/input/lena_color.jpg'));
peppers = rgb2gray(imread('./data/input/peppers.png'));

% Resize Lena to fit Peppers background
[rowsP, colsP] = size(peppers);
lena_small = imresize(lena, 0.5);

% Rotate lena 180 degrees
lena_rot180 = rot90(lena_small, 2);

% Calculate position to center Lena on Peppers
[rowsL, colsL] = size(lena_rot180);
row_start = floor((rowsP - rowsL) / 2) + 1;
col_start = floor((colsP - colsL) / 2) + 1;

% Create a copy of Peppers background
result = peppers;

% Place Lena on Peppers background
result(row_start:row_start+rowsL-1, col_start:col_start+colsL-1) = lena_rot180;

% Display the result
figure;
imshow(result);
title('Khajornyuth');

%% Q5 - Color Mix Square 4x4 (Peppers <-> Lena)
% Load images
I1 = imread('./data/input/peppers.png');        % color
I2 = imread('./data/input/lena_color.jpg');     % color

% Resize images to a common size
N = 4;                                   % row/column count
H = 800; W = 800;                        % Adjustable size
I1 = imresize(I1, [H W]);
I2 = imresize(I2, [H W]);

% Divide images into N x N blocks
hr = H / N; hc = W / N;
I1c = mat2cell(I1, hr*ones(1,N), hc*ones(1,N), 3);
I2c = mat2cell(I2, hr*ones(1,N), hc*ones(1,N), 3);

% Create a new cell array to hold the mixed blocks

M = I1c;  % Preserve the structure of I1c
for r = 1:N
    for c = 1:N
        if mod(r+c,2)==0
            M{r,c} = I1c{r,c};
        else
            M{r,c} = I2c{r,c};
        end
    end
end

% Rotate some blocks for effect
rotate_idx = [2 3; 3 2];   % Specify blocks to rotate
for k = 1:size(rotate_idx,1)
    r = rotate_idx(k,1); c = rotate_idx(k,2);
    M{r,c} = rot90(M{r,c}, 1);
end

out = cell2mat(M);
figure; imshow(out);

%% Q6 - Grayscale Mix Square 4x4 (Peppers <-> Lena)

% Load grayscale images
lena    = rgb2gray(imread('./data/input/lena_color.jpg'));
peppers = rgb2gray(imread('./data/input/peppers.png'));

N = 4;
H = 800; W = 800;
I1 = imresize(peppers, [H W]);   % Area Peppers
I2 = imresize(lena,    [H W]);   % Area Lena

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

% Rotate some blocks for effect
for r = 2:2:N-1
    for c = 2:2:N-1
        M{r,c} = rot90(M{r,c}, 2);
    end
end

out = cell2mat(M);
figure; imshow(out); title('Mix Square');


%% Q7 - Color Tiling 3x3 (Lena <-> Peppers)

% Load images
I1 = imread('./data/input/peppers.png');        % color
I2 = imread('./data/input/lena_color.jpg');     % color

% prepare size
tileSize = [256 256];       % Adjustable tile size
I1 = imresize(I1, tileSize);
I2 = imresize(I2, tileSize);

N = 4;                      % Row/Column count
C = cell(N,N);
for r = 1:N
    for c = 1:N
        if mod(r+c,2)==0, C{r,c} = I1; else, C{r,c} = I2; end
    end
end
out = cell2mat(C);

figure; imshow(out);

%% Q8 - Grayscale Tiling 3x3 (Lena <-> Peppers)

% Load grayscale images
G1 = rgb2gray(imread('./data/input/peppers.png'));
G2 = rgb2gray(imread('./data/input/lena_color.jpg'));

tileSize = [256 256];
G1 = imresize(G1, tileSize);
G2 = imresize(G2, tileSize);

N = 4;
C = cell(N,N);
for r = 1:N
    for c = 1:N
        if mod(r+c,2)==0, C{r,c} = G1; else, C{r,c} = G2; end
    end
end
out = cell2mat(C);

figure; imshow(out); 
