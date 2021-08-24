close all;
image_dir = './';
images = dir(fullfile(image_dir, '*.png'));
images = fullfile(image_dir, {images(:).name});
r = [];
g = [];
for i = 1 : length(images)
    fprintf('processing %d/%d\n',i, length(images))
    I = im2double(imread(images{i}));
    I = reshape(I,[],3);
    r=[r; I(:,1) ./ sum(I,2)];
    g= [g; I(:,2) ./ sum(I,2)];
end
r = r(~isinf(r));
g = g(~isinf(r));
rg = cat(2, r, g) * 1000;
I = imread('Rg_normalized_color_coordinates.png');
f = figure;
imagesc(flipud(I));
hold on;
axis on
s = scatter(rg(:,1) + 1,rg(:,2) + 1, 2, 'filled', 'MarkerFaceColor',[0.7,0.7,0.7]);
set(gca,'ydir','normal');
xlabel('r');
ylabel('g');

% counter_r = zeros(size(r));
% counter_g = zeros(size(r));
% for i = 1 : length(r)
%     counter_r(i) = length(find(r(i) == r));
%     counter_g(i) = length(find(g(i) == g));
% end
% %alpha_data = cat(2, counter_r, counter_g);
% alpha_data = (counter_r + counter_g) / length(counter_r);
% s.AlphaData = alpha_data;
% s.MarkerFaceAlpha = 'flat';

set(gcf,'renderer','painters');
print(gcf, '-dpdf', 'rg-chrom-plot');