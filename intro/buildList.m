% Builds feature list for selected path
function featureList = buildList(x, y, featmap)
    featureList = [];
    for i = 1:size(x, 2)
        for k = 1:size(featmap, 3)
            featureList = [featureList featmap(round(x(i)), round(y(i)), k)];
        end
    end   
end