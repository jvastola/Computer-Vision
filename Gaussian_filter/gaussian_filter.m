function output = gaussian_filter(img, hsize, sigma)
    H=fspecial('gaussian',hsize,sigma);
    [rows,cols]=size(img);
    output = zeros(rows,cols);
    i2 = padarray(img,[(floor(hsize/2)) (floor(hsize/2))]);
    
    for i=1:rows
        for j=1:cols
            temp = i2(i:i+hsize-1,j:j+hsize-1);
            conv = H.*temp;
            output(i,j)=sum(conv(:));
        end
    end
end