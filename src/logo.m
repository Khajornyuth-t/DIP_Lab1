%%Create Logo

clear; clc; close all;

% Basic Setting
figure('Position', [100, 100, 512, 512]); % Size 512x512 pixels
hold on;
axis equal;
axis off;

% Back ground
set(gca, 'Color', 'black'); % Set axis background color
set(gcf, 'Color', 'blue'); % Set figure background color

% t parameter
t = linspace(0, 2*pi, 1000);

% Loop heart
n_hearts = 5;

% Draw
for i = 1:n_hearts
    % Down size formula
    scale = 1.2 - (i-1) * 0.25; 
    
    % Transpender
    alpha = 0.9 - (i-1) * 0.1;   
    
    % Color
    red = 1.0;                       
    green = (i-1) * 0.2;               
    blue = (i-1) * 0.2;               
    
    % Heart Calculate
    x = 16 * sin(t).^3 * scale;
    y = (13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t)) * scale;
    
    % Draw
    fill(x, y, [red, green, blue], 'EdgeColor', 'none', 'FaceAlpha', alpha);
    
    % Display
    %fprintf('Heart %d: Scale=%.2f, Alpha=%.2f, Color=[%.2f, %.2f, %.2f]\n', ...
     %       i, scale, alpha, red, green, blue);
end

% Setting position
xlim([-25, 25]);
ylim([-20, 20]);

% Display Label
%title('Gradient Heart - 6 Layers', 'Color', 'white', 'FontSize', 14);

% Save Picture
%saveas(gcf, 'MyLogo.png');

% แสดงสรุปการตั้งค่า
%fprintf('\n=== การตั้งค่า ===\n');
%fprintf('จำนวนหัวใจ: %d ดวง\n', n_hearts);
%fprintf('สูตรขนาด: scale = 1.2 - (i-1) * 0.25\n');
%fprintf('สูตรความเข้ม: alpha = 0.9 - (i-1) * 0.1\n');
%fprintf('สูตรสี: Green/Blue = (i-1) * 0.2\n');