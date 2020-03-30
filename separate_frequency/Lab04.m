%Johnathan Vastola CSE185 Lab03
clc
clear

%% 2.Use ratio = 0.1, and save the image as lena_low_0.1.jpg and lena_high_0.1.jpg
img = im2double(imread('images/lena.jpg'));
ratio = 0.1;
[low_pass_img, high_pass_img] =separate_frequency(img, ratio);
imwrite(low_pass_img, 'lena_low_pass_0.1.jpg');
imwrite(high_pass_img + 0.5, 'lena_high_pass_0.1.jpg');
figure, imshow(low_pass_img);
figure, imshow(high_pass_img+.5);

%% 3.Use ratio = 0.2, and save the image as lena_low_0.2.jpg and lena_high_0.2.jpg
img = im2double(imread('images/lena.jpg'));
ratio = 0.2;
[low_pass_img, high_pass_img] =separate_frequency(img, ratio);
imwrite(low_pass_img, 'lena_low_pass_0.2.jpg');
imwrite(high_pass_img + 0.5, 'lena_high_pass_0.2.jpg');
figure, imshow(low_pass_img);
figure, imshow(high_pass_img+.5);

%% 5.Use any ratio to merge the low-frequency of marilyn.jpg and the high frequency of einstein.jpg, and save the image as hybrid_1.jpg
img1 = im2double(imread('images/marilyn.jpg'));
img2 = im2double(imread('images/einstein.jpg'));
ratio = 0.2;
img_merged1 = hybrid_image(img1, img2, ratio);
figure, imshow(img_merged1);
imwrite(img_merged1, 'hybrid_1.jpg');

%%6.Use any ratio to merge the low-frequency of einstein.jpg and the high frequency of marilyn.jpg, and save the image as hybrid_2.jpg
img_merged2 = hybrid_image(img2, img1, ratio);
figure, imshow(img_merged2);
imwrite(img_merged2, 'hybrid_2.jpg');