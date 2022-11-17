% This compares the output of scene gist (the output of gistGabor() ) by
% normalizing it to 1 and using KL divergence to compare each image.

% Parameters:


% Precompute filter transfert functions (only need to do this one, unless image size is changes):
%createGabor(orientationsPerScale, imageSize); % this shows the filters
G = createGabor(orientationsPerScale, imageSize);

% compute gist for each image
for i=1:n_imgs
    fprintf('Computing gist for image %i\n', i);
    
    % Load image
    img = image_data{i};
    img = imresize(img, [imageSize imageSize]);
    
    % Computing gist requires 1) prefilter image, 2) filter image and collect
    % output energies
    output = prefilt(double(img), 4);
    g(i) = { gistGabor(output, numberBlocks, G) };
    %normalize g
    g{i} = g{i} ./ sum(g{i});
end

% compare the results for each image
for i=1:n_imgs
    for j=i+1:n_imgs
        score_list(i,j) = kldiv(transpose([1:size_g]), g{i}, g{j}) + ...
                kldiv(transpose([1:size_g]), g{j}, g{i});
    end
end