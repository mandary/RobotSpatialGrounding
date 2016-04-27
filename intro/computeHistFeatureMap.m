function map = computeHistFeatureMap(width, height, featMap, featn)
    map = zeros(height, width, featn);
    edge = [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1.0];
    for i = 1:height
        for j = 1:width
            feature = reshape(featMap(i, j, :), [1, size(featMap, 3)]);
            for k = 1:size(feature, 2)-1
                ct = histcounts(feature(k), edge);
                feature = [feature ct];
            end
            map(i, j, :) = feature;
        end
    end

end