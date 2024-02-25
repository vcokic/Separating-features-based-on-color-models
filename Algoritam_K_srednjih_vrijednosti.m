image = imread('cube.jpg');

figure(1)
subplot(2,3,1)
imshow(image);

lab_image = rgb2lab(image);

ab = lab_image(:,:,2:3);
ab = im2single(ab);
nColors = 6;

pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',6);

for i = 2:6
    mask = pixel_labels==i;
    cluster = image .* uint8(mask);
    subplot(2,3,i)
    imshow(cluster);
end
