% compute loss map for desired path
function lossmap = computeLossMap(width, height, x, y)
    lossmap(1:height, 1:width) = 0;
    % compute euclidean loss
    for i = 1:height
        for j = 1:width
            mdist = Inf;
            for k = 1:size(x, 2)
                dist = sqrt((j - x(k)).^2 + (i - y(k)).^2);
                if dist < mdist
                    mdist = dist;
                end
            end
            lossmap(i, j) = mdist;
        end
    end
    lossmap = (lossmap - min(lossmap(:))) / (max(lossmap(:)) - min(lossmap(:)));
end