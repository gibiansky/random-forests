function run_test(images, classifier)   

[nframes, width, height] = size(images);
for i = 1:20:nframes
    i
    frame = squeeze(images(i, :, :));
    [features, descriptors] = vl_sift(frame);
    npts = length(features);

    classes = zeros(1, npts);
    for j=1:npts
        classes(j) = classifier(descriptors(:, j));
    end

    imshow(frame); hold on;
    plot(features(1, classes == 0), features(2, classes == 0), 'r.');
    plot(features(1, classes == 1), features(2, classes == 1), 'g.');
    drawnow;
    pause;
end

end
