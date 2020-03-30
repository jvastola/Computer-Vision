%Johnathan Vastola CSE185 Lab02
clc
clear
%% 1
% Rotate 01.jpg by 45 degree using forward warping, and save as rotate_0.jpg
I = imread('01.jpg');
xsize=size(I,2);
ysize=size(I,1);
x0=xsize/2;
y0=ysize/2;
I2 = zeros(ysize,xsize,3,'uint8');
for y1=1:ysize
    for x1=1:xsize
        x2=cosd(45)*(x1-x0)+sind(45)*(y1-y0)+x0;
        y2=-sind(45)*(x1-x0)+cosd(45)*(y1-y0)+y0;
        
        if(y2<=ysize && y2>=1 && x2<=xsize && x2>=1)
            I2(round(y2),round(x2),:) = I(y1,x1,:);
        end
    end
end

imwrite(I2,'rotate_0.jpg');
figure, imshow(I2);

%% 2
% Rotate 01.jpg by 45 degree using backward warping,  and save as rotate_1.jpg
I = imread('01.jpg');
xsize=size(I,2);
ysize=size(I,1);
x0=xsize/2;
y0=ysize/2;
I2 = zeros(ysize,xsize,3,'uint8');
for y2=1:ysize
    for x2=1:xsize
        x1=cosd(45)*(x2-x0)+-sind(45)*(y2-y0)+x0;
        y1=sind(45)*(x2-x0)+cosd(45)*(y2-y0)+y0;
        x1=round(x1);
        y1=round(y1);
        
        if(y1<ysize && y1>1 && x1<xsize && x1>1)
            I2(y2,x2,:) = I(y1,x1,:);
        end
    end
end

imwrite(I2,'rotate_1.jpg');
figure, imshow(I2);

I=imrotate(I,45,'nearest','crop');
figure, imshow(I);
%% 3
%Implement median_filter.m for lena_noisy.jpg, use patch size = 3 and save the image as median_0.jpg
img = im2double(imread('lena_noisy.jpg'));

% Median filter
patch_size = [3, 3];

img_median = median_filter(img, patch_size);
imwrite (img_median, 'median_0.jpg');
figure,imshow(img_median);

%I = medfilt2(img, patch_size);
%figure,imshow(I);

%% 4
% Use patch size = 5, and save the image as median_1.jpg
img = im2double(imread('lena_noisy.jpg'));

% Median filter
patch_size = [5, 5];

img_median = median_filter(img, patch_size);
imwrite (img_median, 'median_1.jpg');
figure,imshow(img_median);



%I = medfilt2(img, patch_size);
%figure,imshow(I);
%% Helper Functions
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
