img = im2double(imread('lena.jpg'));

%% compute gradient magnitude and orientation with Sobel filter
[magnitude, orientation] = sobel_feature(img);

%% apply thresholding to detect edge
threshold = 0.3;
e = magnitude > threshold;


%% use built-in function to detect edge
e1 = edge(img, 'Sobel'); % change img to sobel edge detection
e2 = edge(img, 'Canny'); % change img to canny edge detection

figure, imshow(img);
figure, imshow(e1); title('Sobel Edge');
figure, imshow(e2); title('Canny Edge');