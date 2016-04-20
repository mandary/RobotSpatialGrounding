% Dijkstra in costmap 
function [xp, yp] = Dijkstra(costmap, start, goal, proportion)
    working = table();
    hi = size(costmap, 1);
    wi = size(costmap, 2);
    visited = zeros(hi, wi);
    cost(1:hi, 1:wi) = Inf;
    path = zeros(hi, wi); %linear index
    sy = start{1, 2};
    sx = start{1, 1};
    y = sy;
    x = sx;
    working = [working; table(y, x)];
    path(sy, sx) = sy * wi + sx;
    cost(sy, sx) = costmap(sy, sx);
    xp = [];
    yp = [];
    
    % find path process
    while size(working, 1) ~= 0
        % traverse working table, pop the smallest cost element
        tempy = 0;
        tempx = 0;
        mincost = Inf;
        minindex = 1;
        for i = 1:size(working, 1)
            if cost(working{i, 1}, working{i, 2}) < mincost
                tempy = working{i, 1};
                tempx = working{i, 2};
                mincost = cost(tempy, tempx);
                minindex = i;
            end
        end
        % conventional pop
        working(minindex, :) = [];
        % find the goal
        if isGoal(tempx, tempy, goal, proportion)
            %backtrack
            [xp, yp] = backtrack(path, tempx, tempy, sx, sy, wi);
            break;
        end
        % not visited yet
        if ~visited(tempy, tempx)
            visited(tempy, tempx) = 1;
            % for each neighbor
            for x = tempx:tempx+1
                for y = tempy:tempy+1
                    if x <= wi && y <= hi && ~visited(y, x)
                        working = [working; table(y, x)];
                        c1 = cost(tempy, tempx) + costmap(y, x);
                        c2 = cost(y, x);
                        if c1 < c2
                            cost(y, x) = c1;
                            path(y, x) = sub2ind(size(path), tempy, tempx);
                        end
                    end
                end
            end
        end
    end
end

function bol = isGoal(gx, gy, goal, proportion)
    gys = goal{1, 2} - proportion;
    gxs = goal{1, 1} - proportion;
    bol = gx > gxs && gy > gys;
end

function [xp, yp] = backtrack(path, x, y, sx, sy, wi)
    xp = x;
    yp = y;
    while path(y, x) ~= sy * wi + sx
          [y, x] = ind2sub(size(path), path(y, x));
          xp = [x xp];
          yp = [y yp];
    end
    xp = [sx xp];
    yp = [sy yp];
end