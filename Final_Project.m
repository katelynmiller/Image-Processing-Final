clc;
close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(1);
img = imread("Street4.png");
img_gray = rgb2gray(img);
imshow(img_gray)
title('Original Image')

%my_vertices = [0 0; 0 500; 500 500];
Y = size(img, 1);
X = size(img, 2);
my_vertices = [X/2 Y/2; 0 Y; X Y];

h = drawpolygon('Position', my_vertices);



%draw mask for certain area we need - test
figure(2);
x = [X/2 0 X];
y = [Y/2 Y Y];
bw = poly2mask(x, y, Y, X);
imshow(bw)
hold on
plot(x, y, 'b', 'LineWidth', 2)
hold off


figure(3);
masked = uint8(Apply_Filter(img_gray, bw));

imshow(masked);


%img = imread("Test2.jpg");


%img_gray = rgb2gray(img);


img_gauss = imgaussfilt(masked, 8);


can = edge(img_gauss, "Canny", .1);


figure;

subplot(2, 2, 1);
imshow(img);
title("Original");

subplot(2, 2, 2);
imshow(img_gray);
title("Grayscale");

subplot(2, 2, 3);
imshow(img_gauss);
title("Gaussian");

subplot(2, 2, 4);
imshow(can);
title("Canny");


test = imclose(can, strel("square", 5));

figure;
imshow(test);


[HT, theta, rho] = hough(can);

figure
imshow(imadjust(rescale(HT)),[],...
       'XData',theta,...
       'YData',rho,...
       'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal 
hold on
colormap(gca,hot)

P  = houghpeaks(HT, 5, "threshold", 100);%ceil(0.3 * max(HT(:))));
x = theta(P(:,2)); 
y = rho(P(:,1));
plot(x, y, "s", "color", "white");


lines = houghlines(can, theta, rho, P, "FillGap", 25, "MinLength", 10);

% lines = 
% 
% for i = 1:length(lines)
%     
% end


figure, imshow(img), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:, 1), xy(:, 2), "LineWidth", 2, "Color", "green");

   % Plot beginnings and ends of lines
   plot(xy(1, 1), xy(1, 2), "x", "LineWidth", 2, "Color", "yellow");
   plot(xy(2, 1), xy(2, 2), "x", "LineWidth", 2, "Color", "red");

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if (len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


pause;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Shawn's part
clc; close all; clear all;


%draw shape of area we need - test
%https://www.mathworks.com/help/images/ref/drawpolygon.html









% mask = zeros(size(IGrey));
% mask(400:end-1,5:end-1) = 1; %mask(a:b,c:d) (a to b is Y-axis, c to d is X-axis)
% figure(2);
% imshow(mask)
% title('Initial Contour Location')
% 
% bw = activecontour(IGrey,mask,100); %600 works perfectly for coins, small number the less it covers
% 
% figure(3);
% imshow(bw)
% title('Segmented Image')

%pause;

%clc; close all; clear all;

% I = imread('test1.jpg');
% imshow(I)
% hold on
% title('Original Image');
% 
% mask = false(size(I));
% mask(50:150,40:170) = true;
% 
% visboundaries(mask,'Color','b');
% 
% bw = activecontour(I, mask, 200, 'edge');
% 
% visboundaries(bw,'Color','r'); 
% title('Initial contour (blue) and final contour (red)');
% 
% figure, imshow(bw)
% title('Segmented Image');
% 
% break;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear all;
