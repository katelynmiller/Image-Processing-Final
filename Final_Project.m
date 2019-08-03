clc;
close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


img = imread("Test1.jpg");


img_gray = rgb2gray(img);


img_gauss = imgaussfilt(img_gray, 8);


can = edge(img_gauss, "Canny");


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

P  = houghpeaks(HT,5,'threshold',ceil(0.3*max(HT(:))));
x = theta(P(:,2)); 
y = rho(P(:,1));
plot(x,y,'s','color','white');


lines = houghlines(can, theta, rho, P, "FillGap", 25, "MinLength", 10);
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

clc;
close all;
clear all;