
function feature = multiscale_sobel_feature(img, scale)

    % initialize feature vector
    feature = [];
    
    for i = 1:scale
        
        % compute sobel feature
        [magnitude, orientation] = sobel_feature(img);
        f = orientation; 
        
        % concatenate feature vector
        feature = cat(1, feature, f(:));
        
        % down-sample image by 2
        img = imresize(img,0.5);
    end
    
end