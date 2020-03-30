function [low_pass_img, high_pass_img] =separate_frequency(img, ratio)
    % apply FFT  
        frequency_map = fft2(img);
    
    % shift the frequency map
        frequency_map_shifted = fftshift(frequency_map);
    
    % compute low-frequency mask 
        [x,y,z] = size(img);
        y1 = y/2 - ratio * y/2;
        y2 = y/2 + ratio * y/2;
        x1 = x/2 - ratio * x/2;
        x2 = x/2 + ratio * x/2;
        mask = zeros(size(img));
        mask(y1 : y2, x1 : x2, :) = 1;
    
    % separate low-frequency and high-frequency maps  
        low_frequency_map_shifted = frequency_map_shifted .* mask;
        high_frequency_map_shifted = frequency_map_shifted .* (1 - mask);
   
    % shift frequency maps back%% apply Inverse FFT 
        low_frequency_map = ifftshift(low_frequency_map_shifted);
        high_frequency_map = ifftshift(high_frequency_map_shifted);

        low_pass_img = real(ifft2(low_frequency_map));  
        high_pass_img = real(ifft2(high_frequency_map));
end