% Dijkstra in costmap 
%function [xp, yp, cost] = 
function Dijkstra(costmap, start, goal, proportion)
    %cosGraph = createGraph(costmap);
    xp = [];
    yp = [];
    working = table();
    hi = size(costmap, 1);
    wi = size(costmap, 2);
    visited(1:hi, 1:wi) = 0;
    cost(1:hi, 1:wi) = Inf;
    path;
    
    % find start and goal
    i = start{1, 2} + proportion + 1;
    j = start{1, 1} + proportion + 1;
%     temps = strcat(num2str(i), '0', num2str(j));
%     temps = str2double(temps);
    gis = goal{1, 2} - proportion;
    gjs = goal{1, 1} - proportion;
%     tempe = strcat(num2str(gis), '0', num2str(gjs));
%     tempe = str2double(tempe);
    working = [working; table(i, j)];
    
    % find path process
    while size(working, 1) ~= 0
        tempi = working{size(working, 1), 1};
        tempj = working{size(working, 1), 2};
        working(size(working, 1),:) = []; % conventional pop
        % find the goal
        if tempi == gis && tempj == gjs
            break;
        end
        % not visited yet
        if ~visited(tempi, tempj)
            visited(tempi, tempj) = 1;
            % for the visited's neighbor
            for i = tempi-1:tempi+1
                for j = tempj-1:tempj+1
                    if i ~= tempi && j ~= tempj && ~visited(i, j) % no self loop
                        working = [working; table(i, j)];
                        c1 = cost(tempi, tempj) + costmap(i, j);
                        c2 = cost(i, j);
                        if c1 < c2
                            cost(i, j) = c1;
                            path([i, j]) = path([tempi, tempj]);
                        end
                    end
                end
            end         
        end
    end
    disp(path);
end
        

%might want to randomize start

          