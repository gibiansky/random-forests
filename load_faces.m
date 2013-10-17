% LOAD_FACES loads all faces from the face database.
% Returns the eye positions in each face and the images.
function [eye_positions, imgs] = load_faces()

% Find the number of files.
img_dir = 'faces/imgs/*.pgm';
files = dir(img_dir);
files = files(1:100);
nfiles = length(files);

% Allocate space for images and eye positions.
[width, height] = size(imread(['faces/imgs/', files(1).name]));
imgs = single(zeros(nfiles, width, height));
eye_positions = zeros(nfiles, 4);

% Load each file.
counter = 1;
for file = files'
    filename = ['faces/imgs/', file.name];
    eyefile = ['faces/eyes/', file.name(1:end - 3), 'eye'];
    image = imread(filename);
    eyecoords = parse_eye(eyefile);

    imgs(counter, :, :) = im2single(imread(filename));
    eye_positions(counter, :) = eyecoords;
    counter = counter + 1;
end

end

function coords = parse_eye(filename)

% Open the file for reading and skip the first line, which is a comment.
fid = fopen(filename, 'r');
fgetl(fid);

coord_string = fgetl(fid);
coords = sscanf(coord_string, '%u %u\t %u %u');

end
