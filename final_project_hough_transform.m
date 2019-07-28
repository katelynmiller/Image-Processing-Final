%start with an image
%move to every 2 frames per second
%move to each frame per second

v = VideoReader('IMG_2088.mov');
totalFrames = v.NumberOfFrames;
disp(totalFrames);


%Hough Transform

image = imread('roadway_test_polygon.jpeg');
image = im2bw(image);
[rows, columns] = size(image);
disp(rows);
disp(columns);
figure
imshow(image)
h = images.roi.Rectangle(gca,'Position',[(columns/2),(columns/2),(rows/2),(rows/2)],'StripeColor','r');
pause();
BW = edge(image,'canny');
imshow(BW);




[H,theta,rho] = hough(BW);
figure
imshow(imadjust(rescale(H)),[],...
       'XData',theta,...
       'YData',rho,...
       'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal 
hold on
colormap(gca,hot)

P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2)); 


y = rho(P(:,1));
plot(x,y,'s','color','white');


lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
figure, imshow(image), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end





