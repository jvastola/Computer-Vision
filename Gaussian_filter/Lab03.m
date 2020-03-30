%Johnathan Vastola CSE185 Lab03
clc
clear

%% 1
% Implement sobel_filter.m, use Hy filter and save the image as sobel_y.jpg
img= im2double(imread('lena.jpg'));

Hy = [1, 2, 1; 0, 0, 0; -1, -2, -1]; % horizontal edge
img_sobel= sobel_filter(img, Hy);

figure, imshow(img_sobel);
imwrite(img_sobel, 'sobel_y.jpg');

%% 
% Use Hx filter and save the image as sobel_x.jpg

img= im2double(imread('lena.jpg'));

Hx = [1, 0, -1; 2, 0, -2; 1, 0, -1]; % vertical edge
img_sobel= sobel_filter(img, Hx);

figure, imshow(img_sobel);
imwrite(img_sobel, 'sobel_x.jpg');


%% 3
%Break 2D filter (Hy)to 1D filter, use column-wise filter first and then row-wise filter, save the image assobel_cr.jpg
img = im2double(imread('lena.jpg'));
HY1=[1 1 1;0 0 0;-1 -1 -1];
HY2= [1 2 1];
    tic
    [rows,cols]=size(img);
    I2 = zeros(rows+2,cols+2);
    I2(1+1:rows+1,1+1:cols+1) = img;
    output= zeros(rows+2, cols+2);
    output2 = zeros(rows, cols);
    
    for i=1:rows
        for j=1:cols
            output(i,j:j+2) = sum(HY1.*I2(i:i+2,j:j+2), 1);
            output2(i,j) = sum(HY2.*output(i,j:j+2));
        end
    end
    toc

figure, imshow(output2);
imwrite(output2, 'sobel_cr.jpg');

%% 4
% Use row-wise filter first and then column-wise filter, save the image as sobel_rc.jpg
I1 = im2double(imread('lena.jpg'));
HY1=[1 2 1; 1 2 1; 1 2 1];
HY2= [1 0 -1];
tic
[rows,cols]= size(I1);
I2= zeros(rows+2, cols+2);
I2(1+1:rows+1,1+1:cols+1) = I1;
ouput= zeros(rows+2, cols+2);
output2 = zeros(rows, cols);
for i= 1:rows
    for j = 1:cols
        output(i:i+2,j) = sum(HY1.*I2(i:i+2,j:j+2), 2);
        output2(i,j) = sum(HY2'.*output(i:i+2,j));
    end
end
    toc
figure, imshow(output2);
imwrite(output2, 'sobel_rc.jpg');

%% 5
%Implement gaussian_filter.m, use hsize= 5, sigma = 2, and save the image as gaussian_5.jpg
img = im2double(imread('lena.jpg'));

hsize = 5;
sigma = 2;
img_gaussian = gaussian_filter(img, hsize, sigma);
figure, imshow(img_gaussian);
imwrite(img_gaussian, 'gaussian_5.jpg');

%% 6
%Use hsize= 9, sigma = 4, and save the image as gaussian_9.jpg
img = im2double(imread('lena.jpg'));
hsize = 9;
sigma = 4;
img_gaussian = gaussian_filter(img, hsize, sigma);
figure, imshow(img_gaussian);
imwrite(img_gaussian, 'gaussian_9.jpg');

%% 7
%Upload your output images and lab03.m, sobel_filter.m, and gaussian_filter.m







