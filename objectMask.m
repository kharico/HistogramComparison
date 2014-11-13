function BW = objectMask(image)
    %creates mask of object defined in an image
    img = imread(image);
    h_im = imshow(img);
    %e = imellipse(gca,[55 10 120 120]);
    e = impoly;
    BW = createMask(e,h_im);%draw outline of mask
    pause
    BW = createMask(e,h_im);
    pause 
    figure
    imshow(BW);
end