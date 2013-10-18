% load_keypoints    Returns a list of feature vectors and their classifications
% as positive or negative (1 or 0, respcetively).
function [vectors, classes] = load_keypoints()

% Initialize vl_feat
run('vlfeat/toolbox/vl_setup');

% Output variables.
vectors = [];
classes = [];

% Pixel distance that classifies a key point as near an eye.

radius = 15;
% Load all the data
[eyes, images] = load_faces();
for i = 1:length(eyes)
    % Apply SIFT and get locations of keypoints.
    [features, descriptors] = vl_sift(squeeze(images(i, :, :)));
    npts = length(features); 

    left_eye = repmat(eyes(i, 1:2), npts, 1);
    right_eye = repmat(eyes(i, 3:4), npts, 1);
    locs = features(1:2, :)';
    left_dists = sum((locs - left_eye)' .^ 2);
    right_dists = sum((locs - right_eye)' .^ 2);

    % Aggregate output.
    classes = [classes, (left_dists < radius | right_dists < radius)];
    vectors = [vectors, descriptors];

    disp(sprintf('Processed image %d...', i));
end

end
