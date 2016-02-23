% Dijkstra in costmap 
%function [xp, yp, cost] = 
function Dijkstra(costmap, start, goal, proportion)
    cosGraph = createGraph(costmap);
    xp = [];
    yp = [];
    working = [];
    hi = size(costmap, 1);
    wi = size(costmap, 2);
    visited = [];
    cost(1:hi, 1:wi) = 0;
    % find start and goal
    i = start{1, 2} + proportion + 1;
    j = start{1, 1} + proportion + 1;
    temps = strcat(num2str(i), '0', num2str(j));
    temps = str2double(temps);
    gis = goal{1, 2} - proportion;
    gjs = goal{1, 1} - proportion;
    tempe = strcat(num2str(gis), '0', num2str(gjs));
    tempe = str2double(tempe);
    working = [working temps];
    
    % find path process
    while size(working, 1) ~= 0
        tempn = working{size(working, 1), 1};
        working(size(working, 1),:) = []; % conventional pop
        % find the goal
        if tempn == tempe
            break;
        end
        % not visited yet
        if ~sum(ismember(visited, tempn))
            visited = [visited tempn];
            % for the visited's neighbor
            mincost = Inf;
            mini = tempi;
            minj = tempj;
            for neighbor = neighbors(cosGraph, tempn)                 
                if (cost(i, j) == 0) || (cost(i, j) > cost(tempi, tempj) + costmap(i, j))
                    cost(i, j) = round(cost(tempi, tempj) + costmap(i, j));
                    if costmap(i, j) < mincost
                        mincost = cost(i, j);
                        mini = i;
                        minj = j;
                    end
                end
            end
            % put smallest cost neighbor into path
            if ~visited(mini, minj)
                i = mini;
                j = minj;
                working = [working;table(i, j)];
                xp = [xp minj];
                yp = [yp mini];
            end           
        end
    end
    disp(path);
end
        

%might want to randomize start

          