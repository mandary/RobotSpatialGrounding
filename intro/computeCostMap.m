
function result = computeCostMap(width, height, weights, goal, object, matrix)
    result(1:height, 1:width) = 0;
    for i = 1:height
        for j = 1:width
            if matrix(i, j) == -1 % obstacle
                result(i, j) = -1;
            elseif matrix(i, j) == 10 % goal
                result(i, j) = -100;
            elseif matrix(i, j) == 5 % start
                result(i, j) = -50;
            else
                feature = computeFeature(j, i, goal, object);
                result(i, j) = sum(feature.*weights);
            end
        end
    end
    plot(0, 0);
    hold on;
    imagesc(result);
    save('data/result', 'result');
end