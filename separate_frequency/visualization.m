img = im2double(imread('images/new_york.jpg'));
frequency_map = fftshift(fft2(img));

%Display gray-scale frequency map:
figure, imshow(log(abs(frequency_map) + 1), []);
%Display color frequency map:
figure, imagesc(log(abs(frequency_map) + 1)), colormap jet; 

img = im2double(imread('images/flowers.jpg'));
frequency_map = fftshift(fft2(img));

%Display gray-scale frequency map:
figure, imshow(log(abs(frequency_map) + 1), []);
%Display color frequency map:
figure, imagesc(log(abs(frequency_map) + 1)), colormap jet; 