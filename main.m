%% Image Processing Lab1 - Grayscale Conversion
% Purpose: Convert color image to grayscale
% Author: Khajornyuth Tonpuban
% Date: 31 July 2025

%% Section 1: Setup and Clear Environment
clear all;
close all;
clc;

% Run setup
setup;

%% Section 2: Load and Display Original Image
% Load image (DSCF0362.jpg)
% original_img = imread('data/input/DSCF0362.jpg');
lena_org_img = imread('data/input/lena_color.jpg');
peppers_org_img = imread('data/input/peppers_color.png');

% Display original image
figure(1);
imshow(lena_org_img);
title('Original Color Image');
figure(2);
imshow(peppers_org_img);
title('Original Color Image - Peppers');

%% Section 3: Convert to Grayscale
% TODO: Add grayscale conversion code here

%% Section 4: Display and Compare Results
% TODO: Add comparison display code here

%% Section 5: Save Results
% TODO: Add save functionality here

fprintf('Image processing completed!\n');