function costmap = lossAug(xx, yy, costmap, lossmap)
    for i = 1:size(costmap, 1)
        for j = 1:size(costmap, 2)
            for g = 1:size(xx, 2)
                if xx(g) ~= j && yy(g) ~= i
                    costmap(i, j) = costmap(i, j) - lossmap(i, j);
                end
            end
        end
    end
        
end