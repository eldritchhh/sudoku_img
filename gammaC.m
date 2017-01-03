function out=gammaC(img)
    %clc, clear all, close all;

%    img = imread('immagini/IMG_20161129_111710.jpg');
%    img = imread('immagini/9.jpg');
%    img = rgb2gray(img);
%    img = im2double(img);

%    figure, imshow(img);

    img2 = img;

    img2(img2 > 0.95) = 1;
    img2(img2 <= 0.95) = 0;
    imgF = img .* img2;
    %figure, imshow(imgF);

    imgF = imadjust(imgF, [0.95 1], [0.6 1], 2);
    %figure, imshow(imgF);

    for i = 1 : size(img, 1)
        for j = 1 : size(img, 2)
            if(imgF(i, j) > 0.96)
                img(i, j) = imgF(i, j);
            end
        end
    end



%    img(imgF > 0) = imgF;
    %figure, imshow(img);
    %-----------------------------------------------
    %   GAMMA CORRECTION LOCALE
    %-----------------------------------------------


%    img = imadjust(img, [0.1 1], [0 1], 2);

%    figure, imshow(img), title('adjudferfde');

    out = img;
end
