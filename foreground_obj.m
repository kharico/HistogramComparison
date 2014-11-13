function fg = foreground_obj(image,BW)
    %gives image of foreground object
    img = imread(image);
    BW3d = cat(3, BW, BW, BW); 
    fg = img; 
    fg(~BW3d) = 0;
    subplot(2,1,1)
    imshow(fg)
end