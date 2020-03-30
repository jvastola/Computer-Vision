function [output, match] = template_matching_SSD(img, template, threshold)
    output = img;
    [x,y,z] = size(template);
    shift_u = floor(x/2);
    shift_v = floor(y/2);
    [i,j,z] = size(img);
    img = padarray(img, [x, y], 0, 'both');
    %figure, imshow(img);
    for u = 1 + shift_u : size(img, 2) - shift_u
        for v = 1 + shift_v : size(img, 1) - shift_v
            x1 = u - shift_u;
            x2 = u + shift_u;
            y1 = v - shift_v;
            y2 = v + shift_v;
            patch = img(y1:y2, x1:x2);
            
            % SSD
            inv = template - patch;
            value = sum(inv(:).^2);
            output(v- shift_v,u-shift_u) = value;
        end
    end
    %% threshold
    match = (output < threshold);