function [corner_x, corner_y] = Harris_corner_detector(I, sigma1, sigma2, alpha, R_threshold, name)
	%% Gaussian kernels
    hsize1 = 1 + 2 * ceil(sigma1 * 2);
    hsize2 = 1 + 2 * ceil(sigma2 * 2);

    gaussian_kernel1 = fspecial('gaussian', hsize1, sigma1);
    gaussian_kernel2 = fspecial('gaussian', hsize2, sigma2);

    %% derivative filter
    Dx = [1, 0, -1];
    Dy = [1; 0; -1];
    
    %% Step 1: Image Gradients
    Gi = imfilter(I, gaussian_kernel1, 'replicate');
    Ix = imfilter(Gi, Dx, 'replicate');
    Iy = imfilter(Gi, Dy, 'replicate');
    
    
    imwrite(Ix + 0.5, sprintf('%s_Ix.png', name));
    imwrite(Ix + 0.5, sprintf('%s_Iy.png', name));
    imwrite(Gi + 0.5, sprintf('%s_Gi.png', name))


    %% Step 2: Products of Gradients 
    Ixx = Ix .* Ix;
    Iyy = Iy .* Iy;
    Ixy = Ix .* Iy;    
    
    %% Step 3: Matrix M 
    Sxx = imfilter(Ixx, gaussian_kernel2, 'replicate');
    Syy = imfilter(Iyy, gaussian_kernel2, 'replicate');
    Sxy = imfilter(Ixy, gaussian_kernel2, 'replicate');
    
    %% Step 4: Corner Response
    detM = Sxx .* Syy - Sxy .* Sxy;
    traceM = Sxx + Syy;
    R = detM - (alpha * traceM.^2);
    
    corner_map = (R > R_threshold);
    
    imwrite(R , sprintf('%s_R.png', name))
    imwrite(corner_map , sprintf('%s_R2.png', name))
    
    %% Step 5: Non-maxima Suppression

     local_maxima = imregionalmax(R);
     final_corner_map = corner_map & local_maxima;
    
     imwrite(local_maxima + 0.5, sprintf('%s_local_maxima.png', name))
     imwrite(final_corner_map + 0.5,sprintf('%s_final_corner_map.png', name))

    %% Step 6: Extract corner points and plot final corner map and corner x, y coordinates

    [corner_y, corner_x] = find(final_corner_map);
    
    figure, imshow(I); hold on;
    plot(corner_x, corner_y, 'ro');

end