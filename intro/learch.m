

% example cost function learning algorithm
function weights = learch(lr, iteration)
    load('data/sampleMap.mat');
    % load data, how to concat data together? In a table?
    load('data/path1.mat');
    % weights
     weights = [1, 1, 1, 1];
    % might want to switch xx, yy with xcon, ycon pair
    sampleFeatureList = buildList(xx, yy, goal, object);
    sampleCost = aggregator(weights,sampleFeatureList);
    planCost = Inf;
    %while sampleCost ~= planCost
    for sample = 1:10
            costmap = computeCostMap(width, height, weights, goal, object, A);
            % plan path from costmap
            [xp, yp, planCost] = Dijkstra(costmap, start);
            planFeatureList = buildList(xp, yp, goal, object);
            % update weights
            if planCost < sampleCost
                error = sampleCost - planCost;
                weights = computeError(weights, planFeatureList, lr, error);
            end
            sampleCost = aggregator(weights, sampleFeatureList);
            planCost = aggregator(weights, planFeatureList);
        %end
    end
end

% maybe later add loss-augmented cost map
