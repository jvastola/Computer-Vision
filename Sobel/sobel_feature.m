function [magnitude, orientation] = sobel_feature(img)

    % horizontal edge
    Hy = [1, 2, 1; 0, 0, 0; -1, -2, -1]; 
    
    % vertical edge
    Hx = [1, 0, -1; 2, 0, -2; 1, 0, -1]; 
    
    %% Sobel filtering
    img_sobel_y = imfilter(img, Hy); 
    img_sobel_x = imfilter(img, Hx);
    
    %% compute gradient magnitude and orientation
    magnitude = sqrt(img_sobel_y.^2+img_sobel_x.^2); 
    orientation = atan2(img_sobel_y, img_sobel_x);
end