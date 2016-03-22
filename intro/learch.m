

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
            costmap = computeCostMap(width, height, weights, featureMap, A);
            figure(100);
            hold on;
            plot(0,0);
            imagesc(costmap); drawnow;
            map = costmap;
            for i = 1:height
                for j = 1:width
                    if A(i, j) ~= 0
                        map(i, j) = A(i, j);
                    end
                end
            end
            figure(10);
            hold on;
            plot(0,0);
            imagesc(map); drawnow;
            disp(iter);
            disp(weights);
            % plan path from costmap
            [xp, yp, planCost] = Dijkstra(costmap, start, goal, proportion);
            planFeatureList = buildList(xp, yp, goal, object);
            % update weights
            if planCost ~= sampleCost
                weights = computeError(weights, planFeatureList, sampleFeatureList, lr, 0.1);
            end
            sampleCost = aggregator(weights, sampleFeatureList);
            planCost = aggregator(weights, planFeatureList);
        %end
    end
    
end
