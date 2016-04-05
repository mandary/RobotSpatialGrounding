
function result = computeCostMap(width, height, weights, featuremap)
%     result(1:height, 1:width) = 0;
%     for i = 1:height
%         for j = 1:width
%             if matrix(i, j) == -100 % obstacle
%                 result(i, j) = -100;
%             else
%                 feature = computeFeature(j, i, goal, object); %pass in feature map
%                 result(i, j) = sum(feature.*weights);
%             end
%         end
%     end
%    save('data/result', 'result');
    result(1:height, 1:width) = 0;
    for i = 1:height
        for j = 1:width
            sum = 0;
            for k = 1:size(weights, 2)
                sum = sum + featuremap(i, j, k) * weights(k);
            end
            result(i, j) = sum;
        end
    end
end