
 name = 'lines';
%name = 'bridge';
 %name = 'hill';

img = imread(sprintf('%s.png', name));
edge_map = edge(rgb2gray(img), 'Canny',.1,3);


%% Hough Transform mb
[m, b] = hough_transform(edge_map);
x = 1:size(img, 2);
y = m * x + b;

figure, imshow(img);  hold on;
plot(x, y, 'LineWidth', 2, 'Color', 'red');
fig = gcf;
saveas(fig, sprintf('%s_mb_line.png', name));


%% Hough Transform polar(vote for r and theta)
[r, theta] = hough_transform_polar(edge_map);
x = 1:size(img, 2);
y = -(cos(theta)/sin(theta)) * x + (r / sin(theta));

figure, imshow(img); hold on;
plot(x, y, 'LineWidth', 2, 'Color', 'blue');
fig = gcf;
saveas(fig, sprintf('%s_polar_line.png', name));
