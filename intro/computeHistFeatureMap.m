function map = computeHistFeatureMap(width, height, featMap, featn)
    map = zeros(height, width, featn);
    edge = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
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