
run('vlfeat-0.9.21/toolbox/vl_setup');

img1 = im2single(imread('prtn13.jpg'));
img2 = im2single(imread('prtn12.jpg'));

%% SIFT feature extraction
I1 = rgb2gray(img1);
I2 = rgb2gray(img2);

[f1, d1] = vl_sift(I1);
[f2,d2] = vl_sift(I2);
d1 = double(d1);
d2 = double(d2);

plot_sift(I1,f1,d1);
plot_sift(I2,f2,d2);
%% feature matching
[matches, scores] = vl_ubcmatch(d1, d2) ;
plot_match(I1,I2,f1,f2,matches);
match_len = length(matches);
%% RANSAC
e = 0.1;
s = 2;
p = 0.999;

%---------------------------------------%
% 	E    |     P      |   K Value
%---------------------------------------%
%   .2   |   .199     |   0.6
%---------------------------------------%
%   .5   |    .999    |   24.33
%---------------------------------------%
%   .5   |    .555    |   3.4
%---------------------------------------%

delta = 5;

best_tx = 0;
best_ty = 0;

k = floor(log(1-p))/log(1-(1-e).^s);
max_liner = 0;
for i = 1:k
    randomOrder = randperm(match_len);
    p1 = f1(1:2, matches(1, randomOrder(1)));
    p2 = f2(1:2, matches(2, randomOrder(1)));
    tx0 = p1(1)-p2(1);
    ty0 = p1(2)-p2(2);
    liner = 0;
    for j = 2:match_len
        randomOrder2 = randperm(match_len);
        p3 = f1(1:2, matches(1, randomOrder(1)));
        p4 = f2(1:2, matches(2, randomOrder(2)));
        tx = p1(1) - p2(1);
        ty = p1(2) - p2(2);
        if (tx0 - tx)^2 + (ty0 - ty)^2 < delta
            liner = liner + 1;
        end
    end
    if liner > max_liner
        best_tx = tx0;
        best_ty = ty0;
        max_liner = liner;
    end
end

%% Stitching
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
        
        if( y1 >= 1 && y1 <= H + ty && x1 >= 1 && x1 <= W + tx )
            output(y1, x1, :) = img2(y2, x2, :);
        end
        
    end
end

figure, imshow(output);
imwrite(output, 'result.png');


