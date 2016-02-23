

% example cost function learning algorithm
function weights = learch(lr, iteration)
    load('data/sampleMap.mat');
    % load data, how to concat data together? In a table?
    load('data/path1.mat');
    % weights
     weights = [1, 1, 1, 1];
    % might want to switch xx, yy with xcon, ycon pair
    featureMap = computeFeatureMap(width, height, goal, object, A);
    sampleFeatureList = buildList(xx, yy, goal, object);
    sampleCost = aggregator(weights,sampleFeatureList);
    planCost = Inf;
    for iter = 1:iteration
        %for sample = 1:10
            costmap = computeCostMap(width, height, weights, featureMap);
            % plan path from costmap
            [xp, yp, planCost] = Dijkstra(costmap, start);
            planFeatureList = buildList(xp, yp, goal, object);
            % update weights
            if planCost < sampleCost
                error = sampleCost - planCost;
                weights = computeError(weights, planFeatureList, sampleFeatureList, lr, error);
            end
            sampleCost = aggregator(weights, sampleFeatureList);
            planCost = aggregator(weights, planFeatureList);
        %end
    end
end

% maybe later add loss-augmented cost map
