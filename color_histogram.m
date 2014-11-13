% create initial binary object mask of images

img = imread('mich.jpg');
img2 = imread('mich2.jpg');
%{
h_im = imshow(img);
%e = imellipse(gca,[55 10 120 120]);
e = impoly;
BW = createMask(e,h_im);
pause
BW = createMask(e,h_im);
pause 
figure
subplot(2,1,1)
imshow(BW);

pause
h_im2 = imshow(img2);
e2 = impoly;
BW2 = createMask(e2,h_im2);
pause
BW2 = createMask(e2,h_im2);
pause 
figure
subplot(2,1,2)
imshow(BW2);
%}

% create histograms

BW3d = cat(3, BW, BW, BW); %foreground object, image1
fg = img; 
fg(~BW3d) = 0;
subplot(2,1,1)
imshow(fg)

BW2_3d = cat(3, BW2, BW2, BW2); %foreground object, image2
fg2 = img2; 
fg2(~BW2_3d) = 0;
subplot(2,1,2)
imshow(fg2)

BW_bg = ~BW; %background, image1
BWbg3d = cat(3, BW_bg, BW_bg, BW_bg);
bg = img; % background object
bg(~BWbg3d) = 0;
figure
subplot(2,1,1)
imshow(bg)

BW2_bg = ~BW2; %background, image2
BW2_bg3d = cat(3, BW2_bg, BW2_bg, BW2_bg);
bg2 = img2; % background object
bg2(~BW2_bg3d) = 0;
subplot(2,1,2)
imshow(bg2)

red = img(:,:,1); %split RGB values to 3 channels
green = img(:,:,2);
blue = img(:,:,3);

red2 = img2(:,:,1); 
green2 = img2(:,:,2);
blue2 = img2(:,:,3);

[yred, x] = imhist(red); %histogram for each channel
[ygreen, x] = imhist(green);
[yblue, x] = imhist(blue);

[yred2, x] = imhist(red2); %histogram for each channel
[ygreen2, x] = imhist(green2);
[yblue2, x] = imhist(blue2);

yred = yred/trapz(x,yred); %normalize so sum == 1
ygreen = ygreen/trapz(x,ygreen);
yblue = yblue/trapz(x,yblue);

yred2 = yred2/trapz(x,yred2); %normalize so sum == 1
ygreen2 = ygreen2/trapz(x,ygreen2);
yblue2 = yblue2/trapz(x,yblue2);

figure
subplot(2,1,1)
plot(x, yred, 'Red', x, ygreen, 'Green', x, yblue, 'Blue');
subplot(2,1,2)
plot(x, yred2, 'Red', x, ygreen2, 'Green', x, yblue2, 'Blue');

%compute bhattacharyya coefficient/distance for each channel

bcoeff_r = 0;
bcoeff_g = 0;
bcoeff_b = 0;
bins = size(x,1);

for i=1:bins
    bcoeff_r = bcoeff_r + sqrt(yred(i)*yred2(i));
end

for i=1:bins
    bcoeff_g = bcoeff_g + sqrt(ygreen(i)*ygreen2(i));
end

for i=1:bins 
    bcoeff_b = bcoeff_b + sqrt(yblue(i)*yblue2(i));
end


bcoeff_r;
bcoeff_g;
bcoeff_b;
sim_coeff = (bcoeff_r + bcoeff_g + bcoeff_b)/3;

bdist_r = sqrt(1-bcoeff_r);
bdist_g = sqrt(1-bcoeff_g);
bdist_b = sqrt(1-bcoeff_b);

sim_dist = (bdist_r + bdist_g + bdist_b)/3;






