
function result = computeCostMap(width, height, weights, featuremap)
%     result(1:height, 1:width) = 0;
%     for i = 1:height
%         for j = 1:width
%             if matrix(i, j) == 10000 % obstacle
%                 result(i, j) = 10000;
%             elseif matrix(i, j) == 10 % goal
%                 result(i, j) = 10;
%             elseif matrix(i, j) == 20 % start
%                 result(i, j) = 20;
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
            for k = 1:4
                sum = sum + featuremap(i, j, k) * weights(k);
            end
            result(i, j) = sum;
        end
    end
end