
% Compute cost with a given featureList
function cost = aggregator(weights, featureList)
    for i = 1:size(featureList, 2)
        index = mod(i, 4);
        if index == 0
            index = 4;
        end
        cost = cost + featureList(i) * weights(index);
    end
end