%% Setup Script for Image Process Lab1
% Purpose: Initialize paths and environment settings
% Author: Khajornyuth Tonpuban
% Date: 31 July 2025

clear all;      % Clear all variables
close all;      % Close all figures
clc;            % Clear command window

% Add Parths
addpath('src');          % Add source code directory
addpath('data');         % Add data directory
addpath('data/input');  % Add input data directory
addpath('data/output'); % Add output data directory

% Display Project Information
fprintf('===== Image Process Lab1 =====\n');
fprintf('Author: Khajornyuth Tonpuban\n');
fprintf('Current directory: %s\n', pwd);
fprintf('Setup complete.\n');

