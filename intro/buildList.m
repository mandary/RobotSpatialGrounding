% Builds feature list for selected path
function featureList = buildList(x, y, goal, object)
    featureList = [];
    for i = 1:size(x, 2)
        feature = computeFeature(x(i), y(i), goal, object);
        featureList = [featureList feature];
    end
        
end