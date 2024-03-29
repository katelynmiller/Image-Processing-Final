function [BW,maskedRGBImage] = Filter(RGB) 
% Convert RGB image to HSV image
I = rgb2hsl(Norm(double(RGB)));
% Define thresholds for 'Hue'. Modify these values to filter out different range of colors.
channel1Min = 0.1171875 - .075;
channel1Max = 0.1171875 + .075;
% Define thresholds for 'Saturation'
channel2Min = .8;
channel2Max = 1.000;
% Define thresholds for 'Light'
channel3Min = .5;
channel3Max = 1.000;
% Create mask based on chosen histogram thresholds
BW = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
% Initialize output masked image based on input image.
maskedRGBImage = RGB;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;