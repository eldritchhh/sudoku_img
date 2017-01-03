clc, close all, clear all;

%    img = imread('immagini/IMG_20161129_111710.jpg');
%    img = imread('immagini/9.jpg');
%IMG_20161128_120727
img = im2double(imread('immagini/9.jpg'));
img = Iscale(img);                  % SCALA A QUALCOSA DI CIRCA 1000 x 1000
img = rgb2gray(img);

originale = img;                    % COPIA DELL'IMMAGINE IN BIANCO E NERO INIZIALE
[r,c] = size(originale);
%figure, imshow(img), title('Original');
%img = sauvola(img, [10 10]); %per 5.jpg e 2.jpg visto che è molto luminosa
%figure, imshow(img), title('Sauvola');
%img = imopen(img, ones(5));
%figure, imshow(img), title('Opened');
img = gammaC(img);
%figure, imshow(img);
                    % ---------------------
                    % QUINDI GAMMA CORRECTION
                    % ---------------------

                    % ---------------------
                    %FILTRAGGIO PER EDGE
                    % ---------------------

fl = [0,-1,0;
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
%figure, imshow(img), title('Edge-ata');

img = imclose(img, ones(6));        %THRESHOLDING
thresh = graythresh(img);
img(img > thresh) = 1;
img(img <= thresh) = 0;
%figure, imshow(img), title('BlackWhite');

                    % ---------------------
                    % PRIMA SEGMENTAZIONE
                    % ---------------------

                    % LABELING COMPONENTI CONNESSE
[labels, n] = bwlabel(img);
figure,imagesc(labels),axis image, colorbar;
properties = regionprops(labels, 'EulerNumber', 'BoundingBox', 'ConvexImage', 'Eccentricity');
box = 1;
                    % SCELTA COMPONENTE CORRETTA
for i = 2 : n
    if properties(i).EulerNumber < -50 & abs(properties(i).Eccentricity - 0.2) < 0.55
        box = i;
    end
end

%figure, imshow(properties(box).ConvexImage), title('convex');

bordo = properties(box).BoundingBox;
mask = zeros(r,c);                  %CREAZIONE MASCHERA
mask(bordo(2):(bordo(2)+bordo(4)), bordo(1):(bordo(1)+bordo(3))) = 1;

originale = mask .* originale;
%figure, subplot(1, 2, 1), imshow(originale), title('Originale');

originale = imcrop(originale, [bordo(1) bordo(2) bordo(3) bordo(4)]);



%originale = imbinarize(originale, 0.3);
originale = sauvola(originale, [5 5], 0.3);
%figure, imshow(originale);
originale = imopen(originale, ones(3));
%figure, imshow(originale);

                    % ---------------------
                    % SECONDA SEGMENTAZIONE
                    % ---------------------


                    % LABELING COMPONENTI CONNESSE
[labels, n] = bwlabel(img);
properties = regionprops(labels, 'EulerNumber', 'BoundingBox', 'ConvexImage', 'Image');
box2 = 0;
                    % SCELTA COMPONENTE CORRETTA
for i = 1 : n
    if properties(i).EulerNumber < -50
        box2 = i;
    end
end
%figure, imshow(properties(box2).ConvexImage);

                    % ---------------------
                    % ROTAZIONE IMMAGINE
                    % ---------------------

%angle = ceil(Irotation(properties(box).ConvexImage));

%index = 1;
%while index ~= 10
%    angle(index) = ceil(Irotation(properties(box).ConvexImage));
%    if index > 1 && abs(angle(index - 1) - angle(index)) > 3
%        index = 0;
%    end
%    index = index + 1;
%    h = h - 1;
%end
                                                % SI PU� USARE CONVEXIMAGE
                                                %O FILLEDIMAGE MA IN OGNI CASO
                                                %SE � SEGMENTATA MALE ESCE
                                                %UN ANGOLO MONGOLO
%ruotata = imrotate(originale, angle, 'bilinear');

%subplot(1, 2, 2), imshow(ruotata), title('Ruotata');
