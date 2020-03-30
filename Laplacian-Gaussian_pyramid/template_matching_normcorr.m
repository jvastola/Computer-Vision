function [output, match] = template_matching_normcorr(img, template, threshold)
    
    output = img;
    [x,y,z] = size(template);
    shift_u = floor(x/2);
    shift_v = floor(y/2);
    [i,j,z] = size(img);
    img = padarray(img, [x, y], 0, 'both');
    %figure, imshow(img);
    
    %% your code here
    
    for u = 1 + shift_u : size(img, 2) - shift_u
        for v = 1 + shift_v : size(img, 1) - shift_v
            x1 = u - shift_u;
            x2 = u + shift_u;
            y1 = v - shift_v;
            y2 = v + shift_v;
            patch = img(y1:y2, x1:x2);
            % Normalized Cross-Correlation
                patch = patch(:);
                template = template(:);
                patch = patch - mean(patch);
                template = template - mean(template);
                patch = patch ./ norm(patch);
                template = template ./ norm(template);
            value = dot(patch, template);
            output(v-shift_v,u-shift_u) = value;
        end
    end
    match = (output > threshold);
    
end