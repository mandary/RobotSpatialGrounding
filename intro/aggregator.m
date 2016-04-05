
% Compute cost with a given featureList
function cost = aggregator(weights, featureList)
    cost = 0;
    for i = 1:size(featureList, 2)
        index = mod(i, size(weights, 2));
        if index == 0
            index = size(weights, 2);
        end
        cost = cost + featureList(i) * weights(index);
    end
end