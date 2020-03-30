img = im2double(imread('lena.jpg'));

sigma = 2.0;
hsize = 7;
scale = 5;


%% Gaussian Pyramid
I = img;
for s = 1 : scale
    
    % Gaussian filter
    h = fspecial('gaussian', hsize, sigma);
    I = imfilter(I, h);
    % Save or show image
    imwrite(I, sprintf('Gaussian_scale%d.jpg', s));
    figure, imshow(I);
    
    % Down-sampling
    I = imresize(I, 0.5);
end


%% Laplacian Pyramid
I = img;
for s = 1 : scale
    
    % Gaussian filtering
    h = fspecial('gaussian', hsize, sigma);
    I = imfilter(I, h);
    % Laplacian filtering
    h = fspecial('laplacian', 1);
    I = imfilter(I, h);
    % Save or show image
    imwrite(I + 0.5, sprintf('Laplacian_scale%d.jpg', s)); % change I to the output of Laplacian filter
    figure, imshow(I + 0.5);
    
    % Down-sampling
    I = imresize(I, 0.5);
end