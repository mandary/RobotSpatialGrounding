

% example cost function learning algorithm
function weights = learch(lr, iteration, lambda)
    load('data/sampleMap.mat');
    % weights
    weights = ones(1, 23);
    % compute feature map, number of features is always 1 less because of
    % the constant feature
    featureMap = computeFeatureMap(width, height, goal, object, 2);
    histFeatureMap = computeHistFeatureMap(width, height, featureMap, size(weights, 2));
    
    for iter = 1:iteration
        costmap = computeCostMap(width, height, weights, histFeatureMap);
        figure(100);
        plot(0,0);
        hold on;
        imagesc(costmap);
        drawnow;
        figure(10);
        plot(0,0);
        hold on;
        imagesc(A);
        testpath = dijkstra_grid([start{1, 1}; start{1, 2}], [goal{1, 1}; goal{1, 2}], costmap, '8-connected'); 
        xt = testpath(1, :);
        yt = testpath(2, :);
        [xt, yt] = descretize(xt, yt);
        plot(xt, yt, 'r.-');
        gradients = zeros(1, size(weights, 2));
        disp(iter);
        disp(weights);
        for sample = 1:7
            vari = num2str(sample);
            file = strcat(vari, '.mat');
            file = strcat('data/path', file);
            load(file);
            % descretize line by bresenham's
           % [xs, ys] = descretize(xx, yy);
           xs = xx;
           ys = yy;
            % compute loss map
            lossMap = computeLossMap(width, height, xs, ys);
            % build sample path's feature list
            sampleFeatureList = buildList(xs, ys, histFeatureMap);
            tempcostmap = costmap - lossMap;
            tempcostmap(tempcostmap < 0) = 0;
            % plan path from costmap
            path = dijkstra_grid([start{1, 1}; start{1, 2}], [goal{1, 1}; goal{1, 2}], tempcostmap, '8-connected'); 
            xp = path(1, :);
            yp = path(2, :);
            [xp, yp] = descretize(xp, yp);
            planFeatureList = buildList(xp, yp, histFeatureMap);         
            siz = min(size(planFeatureList, 2), size(sampleFeatureList, 2));
            tempgradients = zeros(1, size(weights, 2));
            divden = zeros(1, size(weights, 2));
            for feat = 1:siz
                index = mod(feat, size(weights, 2));
                if index == 0
                    index = size(weights, 2);
                end
                tempgradients(index) = tempgradients(index) + sampleFeatureList(feat) - planFeatureList(feat);
                divden(index) = divden(index) + 1;
            end
            gradients = gradients + (tempgradients ./ divden);
        end
        gradients = gradients ./ 7;
        weights = computeError(weights, gradients, lr, lambda);
    end
end
