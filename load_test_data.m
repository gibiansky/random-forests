% LOAD_TEST_DATA loads all frames in the test video.
function [imgs] = load_test_data()

% Find the number of files.
img_dir = 'video/*.jpg';
files = dir(img_dir);
nfiles = length(files);

% Allocate space for images and eye positions.
[width, height] = size(rgb2gray(imread(['video/', files(1).name])));
imgs = single(zeros(nfiles, width, height));

% Load each file.
counter = 1;
for file = files'
    filename = ['video/', file.name];
    imgs(counter, :, :) = im2single(rgb2gray(imread(filename)));
    counter = counter + 1;
end

end
