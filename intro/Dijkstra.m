% Dijkstra in costmap 
function [xp, yp] = Dijkstra(costmap, start, goal, proportion)
    working = table();
    hi = size(costmap, 1);
    wi = size(costmap, 2);
    visited(1:hi, 1:wi) = 0;
    cost(1:hi, 1:wi) = Inf;
    path(1:hi, 1:wi, 1:2*hi) = 0;
    index(1:hi, 1:wi) = 0;
    sy = start{1, 2};
    sx = start{1, 1};
    y = sy;
    x = sx;
    working = [working; table(y, x)];
    path(sy, sx, 1) = sy;
    path(sy, sx, 2) = sx;

    index(sy, sx) = 1;
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
            if costmap(working{i, 1}, working{i, 2}) < mincost
                tempy = working{i, 1};
                tempx = working{i, 2};
                mincost = costmap(tempy, tempx);
                minindex = i;
            end
        end
        % conventional pop
        working(minindex, :) = [];
        % find the goal
        if isGoal(tempx, tempy, goal, proportion)
            for i = 1:index(tempy, tempx)
                yp = [yp path(tempy, tempx, i*2-1)];
                xp = [xp path(tempy, tempx, i*2)];
            end
            break;
        end
        % not visited yet
        if ~visited(tempy, tempx)
            visited(tempy, tempx) = 1;
            % for each neighbor
            for x = tempx:tempx+1
                for y = tempy:tempy+1
                    if x <= wi && y <= hi
                        working = [working; table(y, x)];
                        c1 = cost(tempy, tempx) + costmap(y, x);
                        c2 = cost(y, x);
                        if c1 < c2
                            cost(y, x) = c1;
                            path(y, x, :) = path(tempy, tempx, :);
                            index(y, x) = index(tempy, tempx) + 1;
                            path(y, x, index(y, x)*2-1) = y;
                            path(y, x, index(y, x)*2) = x;
                        end
                    end
                end
            end
        end
    end
%     indi = randi([2, 10]);
%     file = num2str(indi);
%     file = strcat(file, '.mat');
%     file = strcat('data/path', file);
%     load(file);
%     xp = xx;
%     yp = yy;
end

function bol = isGoal(gx, gy, goal, proportion)
    gys = goal{1, 2} - proportion;
    gxs = goal{1, 1} - proportion;
    bol = gx > gxs && gy > gys;
end