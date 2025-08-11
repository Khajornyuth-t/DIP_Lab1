%% LAB1 Gary Convert
% Purpose: Convert color image to grayscale
lena_gray_img = rgb2gray(lena_org_img);
% imComplete: Convert 
lena_imcomplete_img = imcomplement(lena_org_img);

%% Show grayscale image
figure(3);
imshow(lena_gray_img);
title('Grayscale Image - Lena');

%% Show lena original and grayscale side by side
figure(4);
subplot(1, 2, 1);
imshow(lena_org_img);
title('Original Lena');

subplot(1, 2, 2);
imshow(lena_imcomplete_img);
title('incompleate Lena');