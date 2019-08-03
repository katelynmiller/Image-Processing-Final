clc;
close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


img = imread("Test2.jpg");drawpolygon

disp(size(img, 1));
pause;
disp(size(img, 2));
pause;


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


test = imdilate(can, strel("square", 3));

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
%Shawn's Snake


figure;
%I = img_gray;
IGrey = img_gray;
imshow(IGrey)
title('Original Image')

mask = zeros(size(IGrey));
mask(400:end-1,5:end-1) = 1; %mask(a:b,c:d) (a to b is Y-axis, c to d is X-axis)
figure;
imshow(mask)
title('Initial Contour Location')

bw = activecontour(IGrey,mask,600); %600 works perfectly for coins

figure;
imshow(bw)
title('Segmented Image')

pause;

clc; close all; clear all;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear all;
