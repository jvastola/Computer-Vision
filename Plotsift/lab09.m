run('vlfeat-0.9.21/toolbox/vl_setup');

img1 = im2single(imread('prtn13.jpg'));
img2 = im2single(imread('prtn12.jpg'));
%%SIFT feature extraction
I1 = rgb2gray(img1);
I2 = rgb2gray(img2);

[f1, d1] = vl_sift(I1);
[f2, d2] = vl_sift(I2);

d1 = double(d1);
d2 = double(d2);

plot_sift(img1, f1, d1)
plot_sift(img2, f2, d2)

 
 %%Feature matching
 [matches, scores] = vl_ubcmatch(d1, d2) ;
 plot_match(img1, img2, f1, f2, matches)
 
 %%Ransac
 n=2;
 e=0.2;
 p=.999;
 s=2;
 
 k = (log(1-p))/(log(1-(1-e)^s));

 best_tx=0;
 best_ty =0;
 max_inlier=0;
 
    
 for i=1:k
     len=length(matches);
     randindex= randperm(len,1);
     p1 = f1(1:2, matches(1, randindex));
     p2 = f2(1:2, matches(2, randindex));
     tx_0 = p1(1) - p2(1);
     ty_0 = p1(2) - p2(2);
     inlier= 0;
     mindelta= 10000000;
     for j=1:len
         if j~=randindex
             p1_j = f1(1:2, matches(1, j));
             p2_j = f2(1:2, matches(2, j));
             tx_1 = p1(1)-p2(1);
             ty_1 = p1(1)-p2(1);
             if((tx_1-tx_0)^2+(ty_1-ty_0)^2<mindelta)
                 mindelta=(tx_1-tx_0)^2+(ty_1-ty_0)^2
                 inlier=inlier +1
             end
         end
     end
 if inlier > max_inlier
         max_inlier=inlier;
         best_tx = tx_0; 
         best_ty = ty_0;
 end
 end
 %%Stitching
tx = round(best_tx);
ty = round(best_ty);
H = size(img1, 1);
W = size(img1, 2);
output = zeros(H + ty, W + tx, 3);
output(1:H, 1:W, :) = img1;

for y2 = 1:size(img2, 1)
    for x2 = 1:size(img2, 2)
        y1 = y2 + ty;
        x1 = x2 + tx;
        if( y1 >= 1 && y1 <= H + ty && x1 >= 1 && x1 <= W + tx)
            output(y1, x1, :) = img2(y2, x2, :);
        end
    end
end


 
figure, imshow(output);
imwrite(output, 'result.png');
 