

% example cost function learning algorithm
function learch
    load('sampleMap.mat');
    % load data, how to concat data together? In a table?
    load('path1.mat');
    sampleCost = Inf;
    planCost = Inf;
    weights = [1, 1, 1, 1];
    while sampleCost ~= planCost
        costmap(1:height, 1:width) = 0;
        for i = 1:n % n samples
             for x = 1:size(A, 1)
                 for y = 1:size(A, 2)
                     % should not be individual grid of matrix
                     % do generate point, but how?
                     % update cost map with computeFeature and weights/cost
                     % function
                 end
             end
             % plan path from costmap
             [planPath, planCost] = Dijkstra(costmap);
             % for each cell of mincost path, increase cost
             % modify weights for cost function?, feature value don't change
             % check back on 473 slides
             % for each point in sample path, decrease cost
             
             % update cost of sample and plan
             
        end
    end
end

% is there a for each loop?
% how to combine data from each file as a single data?
% when to determine convergence?
% need to modify dijkstra for matrix, maybe reuse code from AI course
% maybe later add loss-augmented cost map
