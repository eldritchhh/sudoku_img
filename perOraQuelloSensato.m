% Sam dove sei?
clc
close all
clear all

img = im2double(imread('immagini/7.jpg'));
img = Iscale(img);                  % SCALA A QUALCOSA DI CIRCA 1000 x 1000
img = rgb2gray(img);
originale = img;                    % COPIA DELL'IMMAGINE IN BIANCO E NERO INIZIALE
[r,c] = size(originale);
%img = sauvola(img); %per 5.jpg e 2.jpg visto che � molto luminosa

                                    %QUINDI GAMMA CORRECTION

fl = [0,-1,0;                       %FILTRAGGIO PER EDGE
      -1,4,-1;
      0,-1,0];

fx = [1,2,1;
      0,0,0;
      1,2,1];

fy = [1,0,1;
      2,0,2;
      1,0,1];

imx = imfilter(img,fx);
imy = imfilter(img,fy);
%img = ((imx .^2) + (imy .^2) ).^(1/2);
img = abs(imx)+abs(imy); % non vanno la 5 e la 2 ma va la 10
img = imfilter(img, fl);        % ??
%figure, imshow(img);

img = imclose(img, ones(6));        %THRESHOLDING
thresh = graythresh(img);
img(img > thresh) = 1;
img(img <= thresh) = 0;
%figure, imshow(img);

[labels, n] = bwlabel(img);         %LABELING COMPONENTI CONNESSE
%figure,imagesc(labels),axis image, colorbar;
properties = regionprops(labels, 'EulerNumber', 'BoundingBox', 'ConvexImage', 'Image');
box = 0;
                                    %SCELTA COMPONENTE CORRETTA
for i = 1 : n
    if properties(i).EulerNumber < -10
        box = i;
    end
end
figure, imshow(properties(box).ConvexImage);

bordo = properties(box).BoundingBox;
mask = zeros(r,c);                  %CREAZIONE MASCHERA
mask(bordo(2):(bordo(2)+bordo(4)), bordo(1):(bordo(1)+bordo(3))) = 1;

originale = mask .* originale;
figure, subplot(1, 2, 1), imshow(originale), title('Originale');

                                    %ROTAZIONE IMMAGINE
h = 180;
index = 1;
while index ~= 10
    angle(index) = ceil(Irotation(properties(box).ConvexImage, h));
    if index > 1 && abs(angle(index - 1) - angle(index)) > 3
        index = 0;
    end
    index = index + 1;
    h = h - 1;
end
                                                % SI PU� USARE CONVEXIMAGE
                                                %O FILLEDIMAGE MA IN OGNI CASO
                                                %SE � SEGMENTATA MALE ESCE
                                                %UN ANGOLO MONGOLO
angle
angle = mode(angle);
angle
originale = imrotate(originale, angle, 'bilinear');

subplot(1, 2, 2), imshow(originale), title('Ruotata');
