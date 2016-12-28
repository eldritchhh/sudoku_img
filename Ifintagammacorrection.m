function out = Ifintagammacorrection(img)
    [r,c,ch] = size(img);
    img = rgb2hsv(img);
    imv = img(:,:,3);

    m = mean2(imv);
    s = std2(imv);

    d = (m-2*s)-(m+2*s);
    r = 1/d;
    if r < 3
        y = -log2(s);
        k = imv.^y+(1-imv.^y)*m^y;
        c = 1./(1+ heaviside(0.5-m) .*(k-1));
        if m < 0.5
          out = imv.^y/k;
        else
          out = (imv).^y;
        end
    else
        k = imv.^y+(1-imv.^y)*m^y;
        c = 1./(1+ heaviside(0.5-m) .*(k-1));
        y = exp((1-(m+s))/2);
        if (m < 0.5 && (m+s)<1)
            out = c*(imv).^y;
        else
            out = c*(imv).^y;
        end
    end
end
