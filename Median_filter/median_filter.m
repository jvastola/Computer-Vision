function output = median_filter(img, patch_size)
output = zeros(size(img));
for u = 1+ patch_size(1): size(img, 2)- patch_size(1)
    for v = 1+ patch_size(2): size(img, 1)-patch_size(2)
        a=(patch_size(1)-1)/2;
        x1 = u-a; x2 = u+a;
        y1 = v-a; y2 = v+a;
        patch = img(y1:y2, x1:x2);
        A=median(patch);
        value = median(A);
        output(v, u) = value;
    end
end
end