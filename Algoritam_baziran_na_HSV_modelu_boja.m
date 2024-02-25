image = imread("cube.jpg");

hsvImage = rgb2hsv(image);
hImage = hsvImage(:,:,1);
sImage = hsvImage(:,:,2);
vImage = hsvImage(:,:,3);

figure(1)
h = imshow(hImage);
hPI = impixelinfo(h);
figure(2)
s =imshow(sImage);
sPI = impixelinfo(s);
figure(3)
v =imshow(vImage);
vPI = impixelinfo(v);

smallestAcceptableArea = 100;

thresholds = [0 0.03 0.83 0.98 0.38 0.48
    0.01 0.05 0.86 0.99 0.68 0.79
    0.13 0.17 0.70 0.79 0.66 0.72
    0.37 0.39 0.75 0.99 0.40 0.44
    0.58 0.60 0.77 0.96 0.31 0.42];

figure(4)
subplot(2,3,1)
imshow(image);

for i = 1:5
    hThresholdLow = thresholds(i,1);
    hThresholdHigh = thresholds(i,2);
    sThresholdLow = thresholds(i,3);
    sThresholdHigh = thresholds(i,4);
    vThresholdLow = thresholds(i,5);
    vThresholdHigh = thresholds(i,6);

    hMask = (hImage >= hThresholdLow) & (hImage <= hThresholdHigh);
    sMask = (sImage >= sThresholdLow) & (sImage <= sThresholdHigh);
    vMask = (vImage >= vThresholdLow) & (vImage <= vThresholdHigh);
    
    coloredObjectsMask = uint8(hMask & sMask & vMask);
    coloredObjectsMask = uint8(bwareaopen(coloredObjectsMask, smallestAcceptableArea));
    coloredObjectsMask = imfill(logical(coloredObjectsMask), 'holes');
    coloredObjectsMask = cast(coloredObjectsMask, 'like', image);
    
    maskedImageR = coloredObjectsMask .* image(:,:,1);
    maskedImageG = coloredObjectsMask .* image(:,:,2);
    maskedImageB = coloredObjectsMask .* image(:,:,3);
    
    maskedRGBImage = cat(3, maskedImageR, maskedImageG, maskedImageB);
    
    subplot(2,3,i+1)
    imshow(maskedRGBImage);
end
