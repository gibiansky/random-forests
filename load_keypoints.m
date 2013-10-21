% load_keypoints    Returns a list of feature vectors and their classifications
% as positive or negative (1 or 0, respcetively).
function [vectors, classes] = load_keypoints(nimgs, radius)

% Initialize vl_feat
run('vlfeat/toolbox/vl_setup');

% Output variables.
vectors = [];
classes = [];

% Load all the data
[eyes, images] = load_faces(nimgs);
for i = 1:length(eyes)
    % Apply SIFT and get locations of keypoints.
    [features, descriptors] = vl_sift(squeeze(images(i, :, :)));
    npts = length(features); 

    left_eye = repmat(eyes(i, 1:2), npts, 1);
    right_eye = repmat(eyes(i, 3:4), npts, 1);
    locs = features(1:2, :)';
    left_dists = sqrt(sum((locs - left_eye)' .^ 2));
    right_dists = sqrt(sum((locs - right_eye)' .^ 2));

    % Compute all classes, and the number of eyes.
    classifications = (left_dists < radius | right_dists < radius);

    % Select as many non-eyes as eyes to balance the classes.
    yes_eyes = find(classifications == 1);
    num_eyes = length(yes_eyes);
    not_eyes = find(classifications == 0);
    indices = randperm(length(not_eyes));
    not_eyes = not_eyes(indices(1:num_eyes));

    indices = [yes_eyes, not_eyes];
    indices = indices(randperm(length(indices)));

    classes = [classes, classifications(indices)];
    vectors = [vectors, descriptors(:, indices)];

    disp(sprintf('Processed image %d...', i));
end

disp(sprintf('Total points: %d', length(vectors)));

end
