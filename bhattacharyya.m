function [coeff,dist] = bhattacharyya(image,image2)
    %returns bhattacharyya coefficient/distance given two images
    img = image;
    img2 = image2;

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
    
    dx = diff(x(1:2));
    
    yred = yred/sum(yred*dx);   %normalize so sum == 1
    yblue = yblue/sum(yblue*dx);
    ygreen = ygreen/sum(ygreen*dx);
    
    yred2 = yred2/sum(yred2*dx);    %normalize so sum == 1
    yblue2 = yblue2/sum(yblue2*dx);
    ygreen2 = ygreen2/sum(ygreen2*dx);
  
    figure
    subplot(2,1,1)
    plot(x, yred, 'Red', x, ygreen, 'Green', x, yblue, 'Blue');
    subplot(2,1,2)
    plot(x, yred2, 'Red', x, ygreen2, 'Green', x, yblue2, 'Blue');

    %compute bhattacharyya coefficient/distance for each channel
   
    sum(yred)
    sum(yred2)
    sum(ygreen)
    sum(ygreen2)
    sum(yblue)
    sum(yblue2)
    bcoeff_r = 0;
    bcoeff_g = 0;
    bcoeff_b = 0;
    bins = size(x,1);

    for i=1:bins
        bcoeff_r = bcoeff_r + sqrt(yred(i)*yred2(i));
        bcoeff_g = bcoeff_g + sqrt(ygreen(i)*ygreen2(i)); 
        bcoeff_b = bcoeff_b + sqrt(yblue(i)*yblue2(i));
    end


    bcoeff_r
    bcoeff_g
    bcoeff_b
    coeff = (bcoeff_r + bcoeff_g + bcoeff_b)/3

    bdist_r = sqrt(1-bcoeff_r);
    bdist_g = sqrt(1-bcoeff_g);
    bdist_b = sqrt(1-bcoeff_b);

    dist = (bdist_r + bdist_g + bdist_b)/3
end

