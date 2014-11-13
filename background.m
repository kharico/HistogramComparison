function bg = background(image,BW)
    %gives background of image, excluding object
    img = imread(image);
    BW_bg = ~BW; %background, image1
    BWbg3d = cat(3, BW_bg, BW_bg, BW_bg);
    bg = img; % background object
    bg(~BWbg3d) = 0;
    figure
    subplot(2,1,1)
    imshow(bg)
    