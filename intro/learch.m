

% example cost function learning algorithm
function weights = learch(lr, iteration)
    load('data/sampleMap.mat');
    % load data, how to concat data together? In a table?
    load('data/path1.mat');
    % weights
    weights = [1, 1, 1, 1];
    % compute feature map, number of features is always 1 less because of
    % the constant feature
    featureMap = computeFeatureMap(width, height, goal, object, size(weights, 2) - 1);
    % descretize line by bresenham's
    [xs, ys] = descretize(xx, yy);
    % compute loss map
    lossMap = computeLossMap(width, height, xs, ys);
    % build sample path's feature list
    sampleFeatureList = buildList(xs, ys, featureMap);
    sampleCost = aggregator(weights,sampleFeatureList);
    planCost = Inf;
    for iter = 1:iteration
        %for sample = 1:10
            costmap = computeCostMap(width, height, weights, featureMap);
            costmap = lossAug(xx, yy, costmap, lossMap);
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
            [xp, yp] = descretize(xp, yp);
            planFeatureList = buildList(xp, yp, featureMap);
            % update weights
            if planCost ~= sampleCost
                weights = computeError(weights, planFeatureList, sampleFeatureList, lr, 0.1);
            end
            sampleCost = aggregator(weights, sampleFeatureList);
            planCost = aggregator(weights, planFeatureList);
        %end
    end
    
end
