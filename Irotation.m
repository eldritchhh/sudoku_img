%sarebbe da trovare la bounding box orientata
function out = Irotation(im)
%lollo infame

    % (0,0)-----------A
    %   |
    %   |
    %   B
    A = [1, 1, 1, 1, 1, 1];
    B = [1, 1, 1, 1, 1, 1];

    for k = 1 : size(A, 2)
        while im(k + 5, A) ~= 1
            A(k) = A(k) + 1;
        end

        while im(B, k + 5) ~= 1
            B(k) = B(k) + 1;
        end
    end
    catetoA = mean(A)
    catetoB = mean(B)
%    cateto = min(catetoA, catetoB);

    ipotenusa = (catetoA^2 + catetoB^2)^(1/2)
    catetoMaggiore = max(catetoA, catetoB)
    costeta =  catetoMaggiore / ipotenusa;
    alpha = rad2deg(acos(costeta));

    if catetoA > catetoB
        out = - alpha;
    else
        out = alpha;
    end
    out
end
