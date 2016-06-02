

% example cost function learning algorithm
function weights = learch(lr, iteration, lambda)
    load('data/sampleMap1.mat');
    % weights
    weights = ones(1, 22);
    % compute feature map, number of features is always 1 less because of
    % the constant feature
    featureMap = computeFeatureMap(width, height, goal, object, 1);
    histFeatureMap = computeHistFeatureMap(width, height, featureMap, size(weights, 2));
    data = zeros(20, 180);
    for s = 1:10
        vari = num2str(s);
        file = strcat(vari, '.mat');
        file = strcat('data/path', file);
        load(file);
        data(s*2-1,:) = xx;
        data(s*2,:) = yy;
    end
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
           
           xs = data(sample*2-1, :);
           ys = data(sample*2, :);
           plot(xs, ys, 'g.-');
           % descretize line by bresenham's
           [xs, ys] = descretize(xx, yy);
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
            plangradient = zeros(1, size(weights, 2));
            for x = 1:size(planFeatureList, 2)
                index = mod(x, size(weights, 2));
                if index == 0
                    index = size(weights, 2);
                end
                plangradient(index) = plangradient(index) + planFeatureList(x);
            end
            plangradient = plangradient ./ size(xp, 2);
            samplegradient = zeros(1, size(weights, 2));
            for x = 1:size(sampleFeatureList, 2)
                index = mod(x, size(weights, 2));
                if index == 0
                    index = size(weights, 2);
                end
                samplegradient(index) = samplegradient(index) + sampleFeatureList(x);
            end
            samplegradient = samplegradient ./ size(xs, 2);
            gradients = gradients + (samplegradient - plangradient);
        end
        gradients = gradients ./ 7;
        weights = computeError(weights, gradients, lr, lambda);
    end
end
