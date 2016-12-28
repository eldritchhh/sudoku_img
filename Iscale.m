function out = Iscale(imm)
    [r,c,ch] = size(imm);
    x = round(c/1000);
    out = imresize(imm, [round(r/x) round(c/x)]);
end
