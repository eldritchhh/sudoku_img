%sarebbe da trovare la bounding box orientata
function out = Irotation(im, temp)

    % (0,0)-----------A
    %   |
    %   |
    %   B
    catetoA = 1;
    catetoB = 1;

    while im(temp, catetoA) ~= 1
        catetoA = catetoA + 1;
    end

    while im(catetoB, temp) ~= 1
        catetoB = catetoB + 1;
    end

    ipotenusa = (catetoA^2 + catetoB^2)^(1/2);
    catetoMaggiore = max(catetoA, catetoB);
    costeta =  catetoMaggiore / ipotenusa;
    alpha = rad2deg(acos(costeta));

    if catetoA > catetoB
        out = - alpha;
    else
        out = alpha;
    end
end
