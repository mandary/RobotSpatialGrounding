
% Compute cost with a given featureList
function cost = aggregator(weights, featureList)
    for i = 1:size(featureList, 2)
        cost = cost + featureList(i) * weights(mod(i, 4));
    end
end