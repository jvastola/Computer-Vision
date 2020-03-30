function output = sobel_filter(img, kernel)
    [rows,cols]=size(img);
    i2 = zeros(rows+2,cols+2);
    i2(1+1:rows+1,1+1:cols+1) = img;
    output(1+1:rows+1,1+1:cols+1) = img;
    
    for i=1:rows
        for j=1:cols
            output(i,j)= sum(sum(kernel.*i2(i:i+2,j:j+2)));
        end
    end
end
