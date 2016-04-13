% compute feature map for map, each feature value is normalized from 0 ~ 1
function result = computeFeatureMap(width, height, goal, object, featn)
    % initialize feature map
    result = zeros(height, width, featn + 1);
    % compute feature for each square on the map
    for i = 1:height
        for j = 1:width
            result(i,j,:) = computeFeature(j, i, goal, object); 
        end
    end
    % Max and min of features
    maxval = max(reshape(result, height*width, featn+1), [], 1);
    minval = min(reshape(result, height*width, featn+1), [], 1);
    
    % normalize feature value from 0 ~ 1
    for i = 1:height
        for j = 1:width
            for k = 1:featn
                result(i, j, k) = (result(i,j,k) - minval(k)) / (maxval(k) - minval(k));
            end
        end
    end
end