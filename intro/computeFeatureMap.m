% compute feature map for map, each feature value is normalized from 0 ~ 1
function result = computeFeatureMap(width, height, goal, object, featn)
    % collect maxmin of feature value for normalizing
    maxmin = [];
    for g = 1:featn*2
        if mod(g, 2) == 1
            maxmin = [maxmin 0];
        else
            maxmin = [maxmin Inf];
        end
    end
    % initialize feature map
    result(1:height, 1:width, 1:featn + 1) = 0;
    % compute feature for each square on the map
    for i = 1:height
        for j = 1:width
            feature = computeFeature(j, i, goal, object); 
            for k = 1:featn
                % store computed feature
                result(i, j, k) = feature(k);
                % collect max and min for each feature value
                if feature(k) > maxmin(k * 2 - 1)
                    maxmin(k * 2 - 1) = feature(k);
                end
                if feature(k) < maxmin(k * 2)
                    maxmin(k * 2) = feature(k);
                end
            end
            % Constant feature for number of steps
            result(i, j, featn + 1) = feature(featn + 1);
        end
    end
    
    % normalize feature value from 0 ~ 1
    for i = 1:height
        for j = 1:width
            feature = computeFeature(j, i, goal, object); 
            for k = 1:featn
                min = maxmin(k * 2);
                diff = maxmin(k * 2 - 1) - min;
                result(i, j, k) = (feature(k) - min) / diff;
            end
        end
    end
end