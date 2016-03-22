function result = computeFeatureMap(width, height, goal, object, matrix)
    result(1:height, 1:width, 1:4) = 0;
    for i = 1:height
        for j = 1:width
%             if matrix(i, j) == -100 % obstacle
%                 for k = 1:4
%                     result(i, j, k) = -25;
%                 end
%             else
                feature = computeFeature(j, i, goal, object); %pass in feature map
                for k = 1:4
                    result(i, j, k) = feature(k);
                end
%             end
        end
    end
end